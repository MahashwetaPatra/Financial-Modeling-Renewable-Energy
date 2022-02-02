from scenario_models import *
from generate_percentiles import *
from check_zero import *
import time

start = time.time()
#pickle_dir = "c://This PC/projects/PERFORM/Analytics_Platform/Scenario_Pickles_DA"
pickle_dir_id = "C:\\Users\\Mahashweta Patra\\Documents\\MikeLudkovski\\Pickles_Intraday_1"
output_dir = "C:\\Users\\Mahashweta Patra\\Documents\\MikeLudkovski\\Output"
scoville_metadata = pd.read_excel("C:\\Users\\Mahashweta Patra\\Documents\\MikeLudkovski\\metaData.xlsx")
scoville_start_date = '20170101' # this can stretch back to 2017
scoville_end_date = '20170101'# abbreviated end_date #'20181231'
#scoville_root_folder = 'c://This PC//projects/PERFORM/Scoville_Scenarios/Sep13_Scenarios/'
scoville_root_folder_intraday = 'C:\\Users\\Mahashweta Patra\\Documents\\MikeLudkovski\\ORFEUS\IntraDay1\\'
scoville_asset_types = ['wind']
scoville_prefix = 'SimDat_'
scoville_name = 'Scoville'
scoville_times = ["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900", "1000", "1100", "1200",
                  "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200",
                  "2300", "2400"]
scoville_times_intraday = scoville_times[0:6]
scoville_model_intraday = ScenarioModel(scoville_metadata, scoville_root_folder_intraday, scoville_start_date,
                                        scoville_end_date, scoville_asset_types, scoville_prefix, scoville_name,
                                        scoville_times_intraday, pickle_dir_id)
scoville_data_id = scoville_model_intraday.save_asset_data()
calculate_percentiles(scoville_model_intraday, 'Zonal', output_dir)
calculate_percentiles(scoville_model_intraday, 'State', output_dir)
calculate_percentiles(scoville_model_intraday, 'Asset', output_dir)
#check_zero(scoville_model_intraday, output_dir)
end = time.time()
print(end-start)
