#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import pandas as pd
import bz2
import dill as pickle
import pandas as pd
import csv
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec
from numpy import mean
import numpy as np
import math
def Ploting(time, WindScenarios,WindForecast,WindMean,SolarScenarios,SolarForecast,SolarMean, LoadScenarios,LoadForecast,LoadMean, VaticOutput, LoadShedHou):

    fig = plt.figure(figsize=(15,3))
    ax = fig.add_subplot(1,3,1)
    ax.set_ylabel("Wind Scenarios",fontsize=15)
    ax = plotScens(time, WindScenarios,WindForecast,WindMean, ax=ax)
    plt.grid(linewidth=0.25)
    ax.tick_params(labelsize=15)

    #plt.plot( WindScenarios.T,'gray')
    #plt.plot(time,WindForecast,'green')
    #plt.plot(time, WindMean,'r')
    plt.xticks([0,6,12,18,24], ('0', '6', '12', '18', '24'), fontsize='11', horizontalalignment='right')
    plt.show
    plt.grid()
    ax.tick_params(labelsize=15)

    ax = fig.add_subplot(1,3,2)
    ax.set_ylabel("Solar Scenarios",fontsize=15)
    ax = plotScens(time, SolarScenarios,SolarForecast,SolarMean, ax=ax)

    #ci9 = np.quantile(SolarScenarios, 0.9, axis=0)
    #ci975 = np.quantile(SolarScenarios, 0.975, axis=0)
    #ci995 = np.quantile(SolarScenarios, 0.995, axis=0)
    #ci1 = np.quantile(SolarScenarios, 0.1, axis=0)
    #ci025 = np.quantile(SolarScenarios, 0.025, axis=0)
    #ci005 = np.quantile(SolarScenarios, 0.005, axis=0)
    #ax.fill_between(time, ci005, ci995, color='gray', alpha=.1)
    #ax.fill_between(time, ci025, ci975, color='b', alpha=.2)
    #ax.fill_between(time, ci1, ci9, color='b', alpha=.3)
    #plt.plot(time,SolarForecast,'-o',color='darkorange',linewidth=2,markersize=8)
    #plt.plot(time, SolarMean,'--b')
    #plt.xticks([0,6,12,18,24], ('0', '6', '12', '18', '24'), fontsize='11', horizontalalignment='right')


    #plt.plot(SolarScenarios.T,'gray')
    #plt.plot(time,SolarForecast,'green')
    #plt.plot(time, SolarMean,'r')
    #plt.show
    plt.grid(linewidth=0.25)
    ax.tick_params(labelsize=15)

    ax = fig.add_subplot(1,3,3)
    ax.set_ylabel("Load Scenarios",fontsize=15)
    #plt.plot(LoadScenarios.T,'gray')
    ci95 = np.quantile(LoadScenarios, 0.95, axis=0)
    ci99 = np.quantile(LoadScenarios, 0.99, axis=0)
    ci1 = np.quantile(LoadScenarios, 0.01, axis=0)
    ci5 = np.quantile(LoadScenarios, 0.05, axis=0)
    ax.fill_between(time, ci1, ci99, color='b', alpha=.1)
    ax.fill_between(time, ci5, ci95, color='b', alpha=.2)
    ax = plotScens(time, LoadScenarios,LoadForecast,LoadMean, ax=ax)
    #plt.plot(time,LoadForecast,'-o',color='green',linewidth=2,markersize=10)
    #plt.plot(time, LoadMean,'--rx')
    plt.xticks([0,6,12,18,24], ('0', '6', '12', '18', '24'), fontsize='11', horizontalalignment='right')
    plt.show
    #plt.grid()
    ax.tick_params(labelsize=15)

    VaticOutput = pd.read_csv("VaticOutput.csv")
    GenerationCostAll=VaticOutput['GenerationCostAll']
    LoadSheddingAll=VaticOutput['LoadSheddingAll']
    RenewableCurtailmentAll=VaticOutput['RenewableCurtailmentAll']
    #print(GenerationCost)
    #print(np.fromiter(GenerationCost, dtype=int))
    fig = plt.figure(figsize=(15,3))
    ax = fig.add_subplot(1,3,1)
    ax.set_ylabel("Generation Cost",fontsize=15)
    ax.hist(GenerationCostAll, bins=20, color='lightblue')
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)

    ax = fig.add_subplot(1,3,2)
    ax.set_ylabel("Load Shedding",fontsize=15)
    ax.hist(LoadSheddingAll, bins=20, color='lightblue')
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)

    ax = fig.add_subplot(1,3,3)
    ax.set_ylabel("Renewable Curtailment",fontsize=15)
    ax.hist(RenewableCurtailmentAll, bins=20, color='lightblue')
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)
    #ax.tick_params(labelsize=15)
    from GenCostIntegrationScenario2 import *
    from LoadShedHourly import *
    DifferenceLoadWindSolar=LoadScenarios-WindScenarios-SolarScenarios
    HighGenCost, IntegrationScen=GenCostIntegrationScen2(DifferenceLoadWindSolar, GenerationCostAll, RenewableCurtailmentAll, LoadSheddingAll, time)
    DifferenceLoadWindSolar=WindScenarios
    HighGenCost, IntegrationScen=GenCostIntegrationScen2(DifferenceLoadWindSolar, GenerationCostAll, RenewableCurtailmentAll, LoadSheddingAll, time)
    DifferenceLoadWindSolar=SolarScenarios
    HighGenCost, IntegrationScen=GenCostIntegrationScen2(DifferenceLoadWindSolar, GenerationCostAll, RenewableCurtailmentAll, LoadSheddingAll, time)
    LoadShedHour = pd.read_csv("LoadShedHour.csv")
    hours=LoadShedHour['hours']
    LoadShed=LoadShedHour['LoadShed']
    LoadShedHours(hours, LoadShed)

