#!/usr/bin/env python
# coding: utf-8

# In[ ]:


from GenCostIntegrationScenario2 import *
from LoadShedHourly import *
class VaticOutputScenario:
    def plotScens(xTime, yScens,yFrcst,yMean, ax=None, legend=0, **plt_kwargs):
        if ax is None:
            ax = plt.gca()

        ci9 = np.quantile(yScens, 0.9, axis=0)
        ci975 = np.quantile(yScens, 0.975, axis=0)
        ci995 = np.quantile(yScens, 0.995, axis=0)
        ciMax = np.max(yScens,axis=0)
        ci1 = np.quantile(yScens, 0.1, axis=0)
        ci025 = np.quantile(yScens, 0.025, axis=0)
        ci005 = np.quantile(yScens, 0.005, axis=0)
        ciMin = np.min(yScens, axis=0)
        ax.fill_between(xTime, ci005, ci995, color='gray', alpha=.15)
        ax.fill_between(xTime, ci025, ci975, color='b', alpha=.2, label=r'CI $95\%$')
        ax.fill_between(xTime, ci1, ci9, color='b', alpha=.2)
        ax.fill_between(xTime, ciMin, ciMax,color='gray',alpha=0.07)
        ax.plot(xTime,yFrcst,'-o',color='darkorange',linewidth=2,markersize=8,label='Forecast')
        ax.plot(xTime, yMean,'--b', label='Mean')
        ax.set_xlim(left=-0.25,right=23.25)
        ax.set_xticks([0,6,12,18,24])
        ax.set_xticklabels(('0', '6', '12', '18', '24'), fontsize='12', horizontalalignment='right') 
        if legend > 0:
            ax.legend(fontsize=12)
        #ax.plot(x, y, **plt_kwargs) ## example plot here
        return(ax)
    def Ploting(time, WindScenarios,WindForecast,WindMean,SolarScenarios,SolarForecast,SolarMean, LoadScenarios,LoadForecast,LoadMean, VaticOutput, LoadShedHour):
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
        DifferenceLoadWindSolar=LoadScenarios-WindScenarios-SolarScenarios
        HighGenCost, IntegrationScen=GenCostIntegrationScen2(DifferenceLoadWindSolar, GenerationCostAll, RenewableCurtailmentAll, LoadSheddingAll, time)
        DifferenceLoadWindSolar=WindScenarios
        HighGenCost, IntegrationScen=GenCostIntegrationScen2(DifferenceLoadWindSolar, GenerationCostAll, RenewableCurtailmentAll, LoadSheddingAll, time)
        DifferenceLoadWindSolar=SolarScenarios
        HighGenCost, IntegrationScen=GenCostIntegrationScen2(DifferenceLoadWindSolar, GenerationCostAll, RenewableCurtailmentAll, LoadSheddingAll, time)

        hours=LoadShedHour['hours']
        LoadShed=LoadShedHour['LoadShed']
        LoadShedHours(hours, LoadShed)
