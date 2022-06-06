
 **NOTE for KSScoreVersion1Version2 (script):**
 For solar and wind assets, read the csv files contains the percentile generated from running the pythin file named as 'run_script.ipynb' for all the assets, and for each assets does the Kolmogorov-Smirnov test using function 'KSScoreValues', calculates the KS scores and then shows the comparison of KS score for version1 and version 2 for the simulation generated for TX20220427 and the Fall session using 'KSScorePlot' using 'KSScorePlot' Plots generated running the script 'KSScoreVersion1Version2' are used in generating the figure 1 in the report. Figure2, 5,6 are also generated from running this code.


 **NOTE for KSScoreVersion2Compare (script):**
 For solar and wind assets, Calls the percentile for all the assets, and for each assets does the Kolmogorov-Smirnov test using function 'KSScoreValues' and then shows the comparison of KS score for version 2 (TX20220427) for the smaller subset (36 solar, 115 wind assets) and all assets (226 solar and 264 wind assets) using 'KSScoreValues' and plot using function named 'KSScorePlot'. It generates the figure 3 in the report.

 **NOTE for EnergyScore (script):**
 plots energy score generated running the python file 'run_script.ipynb' for all the aggregated assets, for wind and solar assets for Version 1 and version 2 compare the energy score for the two version2 and gives the mean of the energy score and for how many days the version 2 works better than version 1. It generates the figure 2 in the report.

** NOTE for Brier score (script) for the event maximum solar generation:** 
Calls all the solar assets, and for each assets calculates the Brier scores for the event of maximum solar generation plot the histograms for the Brier score, and compares the solar assets for version1 and version2-Subset and version2 all assets in figure 7 in the report

** NOTE: for Brier Score for the event zero wind generation: **
Calls all the wind assets, and for each assets calculates the Brier scores for the event of zero wind generation plot the histograms for the Brier score, and compares the wind assets for version1,version2 subset assets and version2 all assets in figure 7 in the report
