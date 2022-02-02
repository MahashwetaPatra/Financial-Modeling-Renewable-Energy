# This is a sample Python script.
import pandas as pd
import datetime
import pickle
import numpy as np
import time
import math
# Press ⇧F10 to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.

class ScenarioModel:
    def __init__(self, metadata, root_folder_da, start_date, end_date, asset_types, prefix, name, times, output_dir):
        # metadata: dataframe containing our metadata file (usually read in from Excel)
        # root_folder: the folder on Tiger which contains the scenarios
        # start_date: string in 'YYYYMMDD' format indicating the first day for which we have scenarios for the model
        # end_date: string in 'YYYYMMDD' format indicating the last day for which we have scenarios for the model
        # asset_types: list of asset classes which we have scenarios for (typically will be ['load','solar','wind']
        # prefix: any prefix that occurs in the folder names before the date
        # name: name of model
        # num_steps: number of timesteps per file in forecast horizon

        self.metadata = metadata
        self.root_folder_da = root_folder_da
        self.start_date = start_date
        self.end_date = end_date
        self.asset_types = asset_types
        self.prefix=prefix
        self.name=name
        self.zones = sorted(np.unique(self.metadata['Zone']))
        self.clusters = [] # will eventually define a named cluster system
        self.state_group = ['All'] # hard coded to match the expected filename
        self.times = times
        self.output_dir = output_dir # the file in which the pickles will be output to

    def save_asset_data(self):
        # pulls in all data for the model and exports to pickle for each day
        # does state and zonal aggregations
        # relies on the expected formatting and file structure of our scenario CSVs
        date_temp_lst = []  # temp list to collect dfs. this is faster than appending the dfs to a bigger df

        # columns for day ahead
        col_names =  self.times
        # turning start and end date into datetimes and lists of strings which is used in file querying
        date_range = pd.date_range(self.start_date, self.end_date, freq= 'D')
        date_range_str = date_range.strftime('%Y%m%d').tolist()

        # outer loop across dates
        for date in date_range_str:
            print(date)
            # create lists which assets will be appended to
            asset_temp_lst_all = []
            # counters so that the lower level data frames have the right columns
            asset_count = 0
            # loop across asset types
            for typ in self.asset_types:
                type_count = 0
                asset_temp_lst_type = []
                # want to iterate across assets of this type and produce state, zonal, and cluster level aggregations
                # to put into pickle files.
                # also want to include all assets for an asset level pickle file
                assets_of_typ = self.metadata[self.metadata['AssetType']==typ]['AssetName']
                for asset in assets_of_typ:
                    path = self.root_folder_da + self.prefix + date + '/' + typ + '/' + asset + ".csv"
                    try:
                        asset_temp = pd.read_csv(path) # read in the csv file
                    except:
                        print("Could not read file with path " + path)
                    # Hacky way of setting the dataframe column names to indicate which asset the scenarios correspond to
                    asset_temp.columns = ['Type','Index'] + col_names
                    asset_temp.columns = [asset + '_' + col if col != 'Type' and col != 'Index' and col != "index" else col for col in asset_temp.columns]

                    # ignore the first two columns for appending if its not the first asset
                    # add assets to lists to be concatenated based on what the asset type is
                    if asset_count > 0:
                        asset_temp_lst_all.append(asset_temp.iloc[:,2:])
                    else:
                        asset_temp_lst_all.append(asset_temp)

                    if type_count > 0:
                        asset_temp_lst_type.append(asset_temp.iloc[:,2:])
                    else:
                        asset_temp_lst_type.append(asset_temp)
                    type_count += 1
                    asset_count += 1
                date_temp_type = pd.concat(asset_temp_lst_type, axis=1, ignore_index=False)
                date_temp_type['Date'] = date
                # State level aggregation and output
                agg_type_state = self.aggregate_state(date_temp_type)
                agg_type_state.to_pickle(self.output_dir + "/State_Level/"
                                         +date+"_" + typ + "_" +self.name+"_All.pkl")
                # Zonal level aggregation and output
                for zone in self.zones:
                    agg_type_zonal = self.aggregate_zonal(date_temp_type, zone)
                    agg_type_zonal.to_pickle(self.output_dir +"/Zonal_Level/"
                                             +date+ "_" + typ + "_" +self.name + "_" + zone + ".pkl")
            # Asset Level (no aggregation) + output
            date_temp_all = pd.concat(asset_temp_lst_all, axis=1, ignore_index=False)
            date_temp_all['Date'] = date
            date_temp_all.to_pickle(self.output_dir +"/Asset_Level/"
                                    +date+"_"+self.name+".pkl")
        return None

    def aggregate_state(self, df):
        # No asset level filtering when we aggregate by state, so all we must do is add the columns
        # based on the proper hours
        cols = df.columns
        cols_time = [c[-4:] for c in cols[2:-1]]
        unique_times = np.unique(cols_time)
        # create a new dataframe to return which has the aggregated amounts
        aggregation_df = pd.DataFrame()
        aggregation_df['Type'] = df['Type']
        aggregation_df['Index'] = df['Index']
        # iterate across the unique times included in the df and sum across the suffixes
        # assumes the last 5 characters of the column string are "_XXXX" where XXXX represents the time
        # should work for intraday, as long as the above assumption is validated
        for time in unique_times:
            time_df = df.filter(regex="_"+time, axis=1).sum(axis=1)
            aggregation_df['Aggregated_'+time] = time_df
        aggregation_df['Date'] = df['Date']

        return aggregation_df

    def aggregate_zonal(self, df, zone):
        # get a list of the columns corresponding to the asset names and the times that their measurements are relating to
        cols = df.columns
        cols_name = [c[:-5] for c in cols[2:-1]] # avoid the two columns at the start and the date column at the end
        cols_time = [c[-4:] for c in cols[2:-1]]
        unique_times = np.unique(cols_time)

        # some repeated work here, as this will get called for every zone, for the same df, meaning it has to iterate
        # across the columns many times... definite opportunity for improvement here.
        # TODO: Fix the issue detailed above
        filter_by_zone = np.zeros(len(cols),dtype=bool)
        # making sure we always keep the first two columns and the last one
        filter_by_zone[0] = True
        filter_by_zone[1] = True
        filter_by_zone[-1] = True
        i = 2
        for col in cols_name:
            # this logic may not work if we have multiple identical asset names in different zones
            if self.metadata[self.metadata['AssetName']==col]['Zone'].tolist()[0] == zone: # this should be of length 1, so no issues
                filter_by_zone[i] = 1
            i += 1
        filtered_df = df.loc[:, filter_by_zone]

        # now we have the filtered df which contains only assets in the specified zone, so all we must do is aggregate
        # based on the proper hours
        # create a new dataframe to return which has the aggregated amounts
        aggregation_df = pd.DataFrame()
        aggregation_df['Type'] = filtered_df['Type']
        aggregation_df['Index'] = filtered_df['Index']
        # iterate across the unique times included in the df and sum across the suffixes
        # assumes the last 5 characters of the column string are "_XXXX" where XXXX represents the time
        # should work for intraday, as long as the above assumption is validated
        for time in unique_times:
            time_df = filtered_df.filter(regex="_"+time, axis=1).sum(axis=1)
            aggregation_df['Aggregated_'+time] = time_df
        aggregation_df['Date'] = filtered_df['Date']

        return aggregation_df



def obtain_type(agg_level, date, asset_type, grouping, name, path_dir):
    # helper function that reads in a dataframe from a pickle file and returns 3 dataframes, containing the
    # realizations, forecasts, and simulations separated. This can ultimately be fed into other functions to prepare
    # these for ES or percentile output

    # agg_level: 'State', 'Zonal', 'Cluster', or 'Asset'
    # date: date string in 'YYYYMMDD' format
    # asset_type: the type of asset to pull (if at state, zonal, or cluster levels)
    # grouping: the grouping of the asset to pull (if at state, zonal, or cluster levels)
    # name: the name of the scenarios (usually a scenario model object)
    if agg_level == "Asset":
        path = path_dir + "/Asset_Level/" +date+"_"+name+".pkl"
    else:
        path = path_dir + "/" + agg_level + "_Level/" +date+"_" + asset_type + "_" + name+ "_" + grouping +".pkl"

    df = pd.read_pickle(path)
    actuals_only = df[df['Type'] == 'Actual']
    actuals_only = actuals_only.drop(["Type", "Index"], axis=1)
    actuals_only = actuals_only.set_index('Date')

    forecasts_only = df[df['Type'] == 'Forecast']
    forecasts_only = forecasts_only.drop(["Type", "Index"], axis=1)
    forecasts_only = forecasts_only.set_index('Date')

    sims_only = df[df['Type'] == 'Simulation']
    sims_only = sims_only.drop(["Type", "Index"], axis=1)
    return actuals_only, forecasts_only, sims_only

def prep_reals_for_scoring(real_df, num_assets, num_days, num_hours, full_day=True):
    intermediate = real_df.to_numpy()  # number of days x (number of assets x num_hours)
    if full_day:
        sims = intermediate.T
        return sims
    else:
        hrs = num_hours
        separate_hours = np.zeros((num_assets, hrs * intermediate.shape[0]))
        for i in np.arange(num_days):  # iterate across number of days we care about
            for j in np.arange(hrs):  # Iterate across the hours
                separate_hours[:, hrs*i+j] = intermediate[i, j::hrs]
        return separate_hours

def prep_sims_for_scoring(simulations_df, num_scenarios, num_assets, num_days, num_hours, full_day=True):
    """This function takes the data frame of the simulations and converts it into the expected format for the score
    functions"""
    if "Date" in simulations_df.columns:
        simulations_df.drop("Date", axis=1, inplace=True)
    hrs = num_hours
    intermediate = simulations_df.to_numpy()
    if full_day:
        hours_together = np.zeros((num_scenarios, hrs*num_assets, num_days))
        for k in np.arange(num_scenarios):
            hours_together[k, :, :] = intermediate[k::num_scenarios, :].T
        return hours_together
    else:
        separate_hours = np.zeros((num_scenarios, num_assets, num_days*hrs))
        for k in np.arange(num_scenarios):
            for i in np.arange(num_days):  # iterate across number of days we care about
                for j in np.arange(hrs):  # Iterate across the hours
                    separate_hours[k, :, hrs*i+j] = intermediate[k + num_scenarios*i, j::hrs]
        return separate_hours

def energy_score(realizations, simulations):
    # realizations: (components of random vector) x timesteps 2d numpy array representing a single instance of realizations across a day
    # simulations: (number of simulations from forecast) x (components of random vector) x timesteps 3d numpy array representing the scenarios generated by the model
    # This uses the expected shape of the inputs in order to calculate the ES

    # axis = 1 below so that it does the norm calculation on the vector in R^3, across joint distribution
    # of aggregated load, solar, and wind
    energy_score_realization_dev = np.mean(np.linalg.norm(simulations - realizations,axis=1),0)
    # pre-allocating. should always be num_scenarios C 2
    num_scenarios = simulations.shape[0] # first dimension of simulations (represents number of scenarios)
    num_timesteps = simulations.shape[2] # third dimension of simulations (represents number of timesteps)
    num_combs = math.comb(num_scenarios, 2)
    energy_score_forecast_dev_mat = np.zeros((num_combs, num_timesteps))
    counter = 0
    for i in np.arange(num_scenarios):
        for j in np.arange(i+1, num_scenarios):
            energy_score_forecast_dev_mat[counter,:] = 2 * np.linalg.norm(simulations[i,:,:] - simulations[j,:,:], axis = 0)
            counter += 1
    energy_score_forecast_dev = np.sum(energy_score_forecast_dev_mat,0) / (num_scenarios**2)
    energy_score = 0.5*energy_score_forecast_dev - energy_score_realization_dev


    return energy_score


def filter_to_asset(scenario_model, date, asset_nm):
    # takes in the date .pkl file and returns a df of the realizations, forecasts, and actuals only for that asset

    # None is the grouping - ends up being unused when agg_level is asset
    all_reals, all_forecasts, all_sims = obtain_type("Asset", date, "All", "None", scenario_model.name)
    all_sims = all_sims.drop('Date', axis=1)  # removing date as we can identify date by the for loop. Date probably isnt needed overall
    cols = all_reals.columns
    cols_name = [c[:-5] for c in cols]  # hard-coded to get the names from the data frame
    col_is_asset = np.zeros(len(cols), dtype='bool')
    for i in np.arange(len(cols_name)):
        col_is_asset[i] = cols_name[i] == asset_nm

    filtered_reals = all_reals.loc[:, col_is_asset]
    filtered_forecasts = all_forecasts.loc[:, col_is_asset]
    filtered_sims = all_sims.loc[:, col_is_asset]
    return filtered_reals, filtered_forecasts, filtered_sims
