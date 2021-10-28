from scenario_models import *
import datetime
import pickle
import numpy as np
import time
import os

def calculate_ES(scenario_model, agg_level, csv_dir):
    # scenario_model: object of class ScenarioModel
    # agg_level: string with the level of aggregation desired for the ES calculation

    # get dates in string form based on the start and end date of the scenario model object
    date_range = pd.date_range(scenario_model.start_date, scenario_model.end_date, freq='D')
    date_range_str = date_range.strftime('%Y%m%d').tolist()

    # change the grouping for iterations based on the agg level
    # the code below won't really work for the asset level, but we don't do ES at asset level generally
    grouping = ''
    if agg_level == "State":
        grouping = scenario_model.state_group
    elif agg_level == "Zonal":
        grouping = scenario_model.zones
    elif agg_level == "Cluster":
        grouping = scenario_model.clusters

    idx = int(os.environ["SLURM_ARRAY_TASK_ID"])
    parameters = grouping
    myparam = parameters[idx]
    if (agg_level == "State") & (idx > 0):
        return None
    es_calc(scenario_model, agg_level, date_range_str, myparam, csv_dir)
    return None

def es_calc(scenario_model, agg_level, dates, group, csv_dir):
    d = 0 # counter for date
    es_mat = np.zeros((len(dates), len(scenario_model.asset_types)+1)) # pre-allocating the output matrix
    for date in dates[0:5]: # iterate across dates
        print(date)
        '''create empty vectors that will be appended to instead of pre-allocating in case we have to deal with a 
        scenario model with only a subset of the asset types available (i.e. NREL)'''
        reals_vec = []
        forecasts_vec = []
        sims_vec = []
        # pre-allocate for holding the ES for a given day (each asset type + 1 for all)
        es_vec = np.zeros(len(scenario_model.asset_types)+1)
        i = 0 # counter for asset type
        for asset_type in scenario_model.asset_types:
            # obtain the data from the pickled objects
            reals, forecasts, sims = obtain_type(agg_level, date, asset_type, group, scenario_model.name,
                                                 scenario_model.output_dir)
            # append the data to the vectors defined above
            reals_vec.append(reals)
            forecasts_vec.append(forecasts)
            sims_vec.append(sims)
            # run them through the prep function
            prepped_reals = prep_reals_for_scoring(reals_vec[i], num_assets=1, num_days=1, num_hours=24, full_day=True) # one asset because its aggregated
            prepped_sims = prep_sims_for_scoring(sims_vec[i], num_scenarios=1000, num_assets=1, num_days=1, num_hours=24,
                                                 full_day=True)
            es_vec[i] = energy_score(prepped_reals, prepped_sims)
            i += 1
        # do this for all assets combined (scores therefore factor in cross-asset correlations)
        reals_all = pd.concat(reals_vec, axis=1)
        sims_all = pd.concat(sims_vec, axis=1)
        prepped_reals_all = prep_reals_for_scoring(reals_all, num_assets=len(scenario_model.asset_types), num_days=1, num_hours=24, full_day=True) # three asset because its all of them
        prepped_sims_all = prep_sims_for_scoring(sims_all, num_scenarios=1000, num_assets=len(scenario_model.asset_types)
                                                 , num_days=1, num_hours=24,full_day=True)
        es_vec[-1] = energy_score(prepped_reals_all, prepped_sims_all)
        es_mat[d, :] = es_vec
        d += 1
    output = pd.DataFrame(data=es_mat, index=dates, columns=scenario_model.asset_types+['All'])
    path_exist = os.path.exists(csv_dir + "/ES")
    if not path_exist:
        os.makedirs(csv_dir + "/ES")
    #output.to_csv(csv_dir + "/ES/ES_" + scenario_model.name + "_" + group + ".csv")
    return None

if __name__ == '__main__':
    start = time.time()
    pickle_dir = "/projects/PERFORM/Analytics_Platform/Scenario_Pickles_DA"
    output_dir = "/projects/PERFORM/Analytics_Platform/Outputs"
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
    pu_asset_types = ['solar']
    pu_prefix = ''
    pu_name = 'PU'
    pu_times = ["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900", "1000", "1100", "1200",
                "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200",
                "2300", "2400"]
    pu_model = ScenarioModel(pu_metadata, pu_root_folder, pu_start_date, pu_end_date,
                             pu_asset_types, pu_prefix, pu_name, pu_times, pickle_dir)

    # run the ES calculation at the Zonal and State level for the model defined above
    calculate_ES(pu_model, 'Zonal', output_dir)
    # calculate_ES(pu_model, 'State', output_dir)
    # calculate_ES(scoville_model_da, 'Zonal', output_dir)
    # calculate_ES(scoville_model_da, 'State', output_dir)
    end = time.time()
    print(end - start)