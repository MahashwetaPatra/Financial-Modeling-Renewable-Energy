# This is a sample Python script.
import pandas as pd
from scenario_models import *
import datetime
import pickle
import numpy as np
import time
# Press ⇧F10 to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.

def save_data():
    start = time.time()
    pickle_dir = "/projects/PERFORM/Analytics_Platform/Scenario_Pickles_DA"
    pickle_dir_id = "/projects/PERFORM/Analytics_Platform/Scenario_Pickles_Intraday_1"

    scoville_metadata = pd.read_excel("/projects/PERFORM/Scoville_Scenarios/metaData.xlsx")
    scoville_start_date = '20180101' # this can stretch back to 2017
    scoville_end_date = '20180101'# abbreviated end_date #'20181231'
    scoville_root_folder = '/projects/PERFORM/Scoville_Scenarios/Sep13_Scenarios/'
    scoville_root_folder_intraday = '/projects/PERFORM/Scoville_Scenarios/Intraday/Intraday_1_6/'
    scoville_asset_types = ['load', 'solar', 'wind']
    scoville_prefix = 'SimDat_'
    scoville_name = 'Scoville'
    scoville_times = ["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900", "1000", "1100", "1200",
                         "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200",
                         "2300", "2400"]
    scoville_times_intraday = scoville_times[0:6]
    scoville_model_intraday = ScenarioModel(scoville_metadata, scoville_root_folder_intraday, scoville_start_date,
                                            scoville_end_date, scoville_asset_types, scoville_prefix, scoville_name,
                                            scoville_times_intraday, pickle_dir_id)

    # scoville_model = ScenarioModel(scoville_metadata, scoville_root_folder, scoville_start_date, scoville_end_date,
    #                                scoville_asset_types, scoville_prefix, scoville_name, scoville_times, pickle_dir)
    scoville_data = scoville_model_intraday.save_asset_data()

    # pu_metadata = pd.read_excel("/projects/PERFORM/Scoville_Scenarios/metaData.xlsx") # same metadata file for now
    # pu_start_date = '20180102'
    # pu_end_date = '20181229'  # start and end dates are different for PU model compared to Scoville
    # pu_root_folder = '/projects/PERFORM/xyang/scenarios/PU_joint/'
    # pu_asset_types = ['load', 'solar', 'wind']
    # #pu_asset_types = ['solar']
    # pu_prefix = ''
    # pu_name = 'PU'
    # pu_times = ["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900", "1000", "1100", "1200",
    #                   "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200",
    #                   "2300", "2400"]
    # pu_model = ScenarioModel(pu_metadata, pu_root_folder, pu_start_date, pu_end_date,
    #                          pu_asset_types, pu_prefix, pu_name, pu_times, pickle_dir)
    # pu_data = pu_model.save_asset_data()

    end = time.time()
    print("Time:", end - start)

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    save_data()
