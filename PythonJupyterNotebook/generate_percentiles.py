import os.path

import pandas as pd

from scenario_models import *
from scipy.stats import percentileofscore
import datetime
import pickle
import numpy as np
import time

def percentiles(arr, score):
    # arr: dataframe or series object
    # score: real number
    pvalue = percentileofscore(arr, score, 'weak')
    # calculate peak to peak (max - min) of scenarios
    ptp = np.ptp(arr)
    # if we correctly predict a point mass, return a NaN
    # this doesn't account for a situation where we predict say, 20% of the points to be at a point
    # mass...
    if (ptp == 0) & (arr.iloc[0] == score):
        pvalue = np.nan
    return pvalue


def calculate_percentiles(scenario_model, agg_level, csv_dir):
    # scenario_model: object of class ScenarioModel
    # agg_level: string with the level of aggregation desired for the ES calculation

    # get dates in string form based on the start and end date of the scenario model object
    date_range = pd.date_range(scenario_model.start_date, scenario_model.end_date, freq='D')
    date_range_str = date_range.strftime('%Y%m%d').tolist()

    # change the grouping for iterations based on the agg level
    # the code below won't really work for the asset level
    asset_level = False
    if agg_level == "State":
        grouping = scenario_model.state_group
    elif agg_level == "Zonal":
        grouping = scenario_model.zones
    elif agg_level == "Cluster":
        grouping = scenario_model.clusters
    elif agg_level == "Asset":
        grouping = scenario_model.metadata['AssetName'] # grab the list of assets
        asset_level = True

    # we treat things slightly differently at the asset level
    if asset_level:
        pvalue_date = []
        index_col = [date + "_" + times for date in date_range_str for times in scenario_model.times]
        total_assets = 0
        for typ in scenario_model.asset_types:
            total_assets += len(scenario_model.metadata[scenario_model.metadata['AssetType'] == typ]['AssetName'])
        for date in date_range_str:
            print(date)
            reals, forecasts, sims = obtain_type("Asset", date, "All", "", scenario_model.name, scenario_model.output_dir)
            sims = sims.drop('Date', axis=1) #no longer need this if the sims dont have the date
            col_names = [c[:-5] for c in sims.columns]
            col_names_filt = col_names[::len(scenario_model.times)]
            pvalue = np.zeros(sims.shape[1])
            # iterating across hours
            for i in np.arange(sims.shape[1]):
                pvalue[i] = percentiles(sims.iloc[:,i], reals.iloc[:,i][0])
            pvalue_mat = pvalue.reshape((total_assets, len(scenario_model.times))).T
            pvalue_date.append(pvalue_mat)
        all_pvalues = np.concatenate(pvalue_date,axis=0)
        output_df = pd.DataFrame(data=all_pvalues, columns=col_names_filt, index=index_col)

        # split it into individual files for each asset type (could possibly get rid of this if we decide to)
        for typ in scenario_model.asset_types:
            type_asset_lst = list(scenario_model.metadata[scenario_model.metadata['AssetType'] == typ]['AssetName'])
            keep = np.zeros(output_df.shape[1], dtype='bool')
            for i in np.arange(output_df.shape[1]):
                if output_df.columns[i] in type_asset_lst:
                    keep[i] = True
            output_df_type = output_df.loc[:, keep]
            output_df_type.to_csv(csv_dir + "/Percentiles/Percentiles_" + scenario_model.name + "_" + typ + ".csv")
        return None
    else:  # for all other aggregation levels, do the following
        for group in grouping:
            '''this is perhaps a little inefficient because there is more calls to read pickles than strictly necessary,
             but it still runs very quickly and hence has not been changed '''
            print(group)
            d = 0
            percentile_mat = np.zeros((len(date_range_str)*len(scenario_model.times),
                                       len(scenario_model.asset_types))) # pre-allocate output matrix
            index_col = ['']*(len(date_range_str)*len(scenario_model.times))
            for date in date_range_str: # iterate across dates
                print(date)
                # pre-allocate for holding the percentiles for a given day
                percentiles_minimat = np.zeros((len(scenario_model.times), len(scenario_model.asset_types)))
                i = 0  # counter for asset type
                for asset_type in scenario_model.asset_types:
                    reals, forecasts, sims = obtain_type(agg_level, date, asset_type, group, scenario_model.name,
                                                         scenario_model.output_dir)
                    for col_idx in np.arange(reals.shape[1]):
                        pvalue = percentiles(sims.iloc[:,col_idx], reals.iloc[:, col_idx][0])
                        percentiles_minimat[col_idx,i] = pvalue
                    i += 1
                percentile_mat[d*len(scenario_model.times):(d+1)*len(scenario_model.times), :] = percentiles_minimat
                index_col[d*len(scenario_model.times):(d+1)*len(scenario_model.times)] = [date + "_" + x for x in scenario_model.times]
                d += 1
            output = pd.DataFrame(data=percentile_mat, index=index_col, columns=scenario_model.asset_types)

            path_exist = os.path.exists(csv_dir + "/Percentiles")
            if not path_exist:
                os.makedirs(csv_dir + "/Percentiles")
            output.to_csv(csv_dir + "/Percentiles/Percentiles_" + scenario_model.name + "_" + group + ".csv")
            print(output.head())
    return None

if __name__ == '__main__':
    output_dir = "/projects/PERFORM/Analytics_Platform/Outputs/Intraday1" # change this as needed
    pickle_dir = "/projects/PERFORM/Analytics_Platform/Scenario_Pickles_DA" # ensure this is where the data is stored
    start = time.time()
    # define variables for initialization of ScenarioModel object
    metadata = pd.read_excel("/projects/PERFORM/Scoville_Scenarios/metaData.xlsx")
    start_date = '20170101'
    end_date = '20181231'
    root_folder_da = '/projects/PERFORM/Scoville_Scenarios/Aug23_Scenarios/'
    name = 'Scoville'
    prefix = 'SimDat'
    asset_types = ['load', 'solar', 'wind']
    times = ["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900", "1000", "1100", "1200",
             "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200",
             "2300", "2400"]
    # initialize the ScenarioModel object for Scoville
    scoville_model_da = ScenarioModel(metadata, root_folder_da, start_date, end_date, asset_types,
                                   prefix, name, times, pickle_dir)
    calculate_percentiles(scoville_model_da, 'Zonal', output_dir)
    calculate_percentiles(scoville_model_da, 'State', output_dir)
    calculate_percentiles(scoville_model_da, 'Asset', output_dir)
    # run the percentile calculation at the Asset, Zonal, and State level for the model defined above
    # could maybe parallelize?

    pu_metadata = pd.read_excel("/projects/PERFORM/Scoville_Scenarios/metaData.xlsx") # same metadata file for now
    pu_start_date = '20170101'
    pu_end_date = '20181231'  # start and end dates are different for PU model compared to Scoville
    pu_root_folder = '/projects/PERFORM/GEMINI_Scenarios/'
    pu_asset_types = ['load', 'solar', 'wind']
    pu_prefix = ''
    pu_name = 'PU'
    pu_times = ["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900", "1000", "1100", "1200",
                "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200",
                "2300", "2400"]
    pu_model = ScenarioModel(pu_metadata, pu_root_folder, pu_start_date, pu_end_date,
                             pu_asset_types, pu_prefix, pu_name, pu_times, pickle_dir)

    calculate_percentiles(pu_model, 'Zonal', output_dir)
    calculate_percentiles(pu_model, 'State', output_dir)
    calculate_percentiles(pu_model, 'Asset', output_dir)
    end = time.time()
    print(end - start)
    #
