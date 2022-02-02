import pandas as pd

from scenario_models import *
import datetime
import pickle
import numpy as np
import time
import os


def prob_of_zero(realizations_hr, simulations_hr):
    # realizations_hr: a series of length 1
    # simulations_hr: a series of length 1000
    # return whether the realization is 0 and the empirical probability of the simulations being 0 for a particular hour
    tol = 1e-05
    if realizations_hr[0] <= tol:
        day_true = 1
    else:
        day_true = 0
    day_pred = simulations_hr[simulations_hr <= tol].count() / simulations_hr.shape[0]
    return day_true, day_pred


def check_zero(scenario_model, csv_dir):
    # get dates in string form based on the start and end date of the scenario model object
    date_range = pd.date_range(scenario_model.start_date, scenario_model.end_date, freq='D')
    date_range_str = date_range.strftime('%Y%m%d').tolist()

    index_col = [date + "_" + times for date in date_range_str for times in scenario_model.times]
    day_true_date = []
    day_pred_date = []
    for date in date_range_str:
        # always pulling from asset level here
        # this can possibly be abstracted with generate_percentiles and any other asset level manipulations
        reals, forecasts, sims = obtain_type("Asset", date, "All", "", scenario_model.name, scenario_model.output_dir)
        sims = sims.drop('Date', axis=1) # no longer need this if Date is dropped
        col_names = [c[:-5] for c in sims.columns] # last 5 digits will always be _XXXX representing timestamps
        col_names_filt = col_names[::len(scenario_model.times)]
        day_true = np.zeros(sims.shape[1])
        day_pred = np.zeros(sims.shape[1])
        for i in np.arange(sims.shape[1]):
            day_true[i], day_pred[i] = prob_of_zero(reals.iloc[:,i], sims.iloc[:,i])
        day_true = day_true.reshape((len(scenario_model.metadata['AssetName']),len(scenario_model.times))).T
        day_pred = day_pred.reshape((len(scenario_model.metadata['AssetName']),len(scenario_model.times))).T
        day_true_date.append(day_true)
        day_pred_date.append(day_pred)
    all_day_true = np.concatenate(day_true_date, axis=0)
    all_day_pred = np.concatenate(day_pred_date, axis=0)
    col_names_true = map(lambda x: x + "_true", col_names_filt)
    col_names_pred = map(lambda x: x + "_pred", col_names_filt)
    day_true_df = pd.DataFrame(data=all_day_true, columns=col_names_true, index=index_col)
    day_pred_df = pd.DataFrame(data=all_day_pred, columns=col_names_pred, index=index_col)
    day_true_pred_df = pd.concat([day_true_df, day_pred_df], axis=1)

    # split it into individual files for each asset type (could possibly get rid of this if we decide to)
    for typ in scenario_model.asset_types:
        type_asset_lst = list(scenario_model.metadata[scenario_model.metadata['AssetType'] == typ]['AssetName'])
        keep = np.zeros(day_true_pred_df.shape[1], dtype='bool')
        cols = [x[:-5] for x in day_true_pred_df.columns] #same last 5 digits item going on here
        for i in np.arange(day_true_pred_df.shape[1]):
            if cols[i] in type_asset_lst:
                keep[i] = True
        output_df_type = day_true_pred_df.loc[:, keep]
        path_exist = os.path.exists(csv_dir + "/Event_Analysis")
        if not path_exist:
            os.makedirs(csv_dir + "/Event_Analysis")
        output_df_type.to_csv(csv_dir + "/Event_Analysis/check_zero_" + scenario_model.name + "_" + typ + ".csv")
    return None

if __name__ == '__main__':
    start = time.time()
    output_dir = "/projects/PERFORM/Analytics_Platform/Outputs"
    pickle_dir = "/projects/PERFORM/Analytics_Platform/Scenario_Pickles_DA"
    # define variables for initialization of ScenarioModel object
    metadata = pd.read_excel("/projects/PERFORM/Scoville_Scenarios/metaData.xlsx")
    start_date = '20180101'
    end_date = '20181231'
    root_folder_da = '/projects/PERFORM/Scoville_Scenarios/Aug23_Scenarios/'
    name = 'Scoville'
    prefix = 'SimDat'
    asset_types = ['load', 'solar', 'wind']
    hours = ["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900", "1000", "1100", "1200",
             "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200",
             "2300", "2400"]
    # initialize the ScenarioModel object for Scoville
    scoville_model_da = ScenarioModel(metadata, root_folder_da, start_date, end_date, asset_types,
                                      prefix, name, hours, pickle_dir)

    pu_metadata = pd.read_excel("/projects/PERFORM/Scoville_Scenarios/metaData.xlsx") # same metadata file for now
    pu_start_date = '20180102'
    pu_end_date = '20181229'  # start and end dates are different for PU model compared to Scoville
    pu_root_folder = '/projects/PERFORM/GEMINI_Scenarios/'
    pu_asset_types = ['load', 'solar', 'wind']
    pu_prefix = ''
    pu_name = 'PU'
    pu_times = ["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900", "1000", "1100", "1200",
                "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200",
                "2300", "2400"]
    pu_model = ScenarioModel(pu_metadata, pu_root_folder, pu_start_date, pu_end_date,
                             pu_asset_types, pu_prefix, pu_name, pu_times, pickle_dir)
    check_zero(scoville_model_da, output_dir)
    check_zero(pu_model, output_dir)
    end = time.time()
    print(end - start)
