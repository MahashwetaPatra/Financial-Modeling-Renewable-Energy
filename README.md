# Financial-Modeling-Renewable-Energy
This project assesses the intraday and DA scenarios from the ORFEUS-GHS model run on the ERCOT TAMU testbed. We assess the stochastic scenarios for wind and solar assets over the 4 intra-day blocks $I_1,\ldots,I_4$ each of which includes 6 hourly datapoints and for the day ahead. Assessment metrics include PCA analysis, K-means clustering, Energy Scores, Coverage, PIT Histogram and Brier scores

**PCA analysis (for dimension reduction) and K-means algorithm (for clustering algorithm) **

PCA_Assets.m is a function that does the PCA analysis. The input is the asset in Array. PCA_AllAssets3.m calls all the assets for a date, and for each assets calls the matlab function PCA_Assets.m, This is for doing the PCA for the asset and save the first four PCA factors and first four explained series in csv format for all the assets and for 365 days in a folder named Coefficient. 

PCA_AnimationAssets.m is for calculating the Animation video for the PCA factors in a time range using the output csv files generated by the PCA analysis. It calls the function PCA_Animation.m

PCA_AggregatedAsset.m shows the PC1 of individual assets and PC1 of the aggregated sum of all the assets for the eight zones. The aggregated sum quite well matches with the individual assets' overall shape for both the cases (solar \& wind)

IllustrationDAID.m shows that DA and intraday scenarios and forecasts, actual for any asset and date.

PCA_ExtremeScenario.m is for calculating the boundary of score phase space plot, i.e., showig the extreme scenarios 

TimeSeries05Dec.m is for calculating the time series of actual , forcast and mean and 2.75-97.5% scenario band for an asset on a day.

latent.m is a function that calculate the PCA factors when an array is passed as an input

run_script.ipynb is the Python notebook file to run that calculates the percentile for solar, wind and load. It calls the function generate_percentiles.py and scenario_models.py. RunEnergyScore.ipynb calculates the energy scores. generate_percentiles.py is the file that generate the percentile and save them in files. generate_ES2.py is the function that is called to generate the energy scores.

The notebook PITHistogramIntraDayWind.ipynb creates a variety of plots and numerical indicators of how well the scenarios cover the actuals on an hourly and daily basis for the wind data. It works with the percentile data and plots the heatmap, PIT histograms. PITHistogramIntraDaySolar.ipynb does the same for the solar data.

EnergyScore.m works on the energy score data. It calls energy score from all the aggregated assets, and plots it with date for load, solar, wind, all.
EnergyScoreZonalYear.m calls energy score for all the assets from different zones and plots the I_1, I_2, I_3, I_4 plots for solar, wind.

RepresentationScenario.m: Calls an asset, from a day and for that asset calculates representative scenarios using the K-means algorithm. The histogram from all scenarios and representative scenarios at different hours are compared and it matches well.
