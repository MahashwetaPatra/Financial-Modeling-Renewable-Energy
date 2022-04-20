#!/usr/bin/env python
# coding: utf-8

# In[1]:

import pandas as pd
import bz2
import dill as pickle
import csv
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec
from numpy import mean
import numpy as np
import math
import seaborn as sns
def GenCostIntegrationScen( DifferenceLoadWindSolar, Thresold, GenerationCostAll, RenewableCurtailmentAll, LoadSheddingAll, time, genThresh=9500,showHist=False):
    #Thresold=mean(DifferenceLoadWindSolar)
    if showHist==False:
        fig = plt.figure(figsize=(15,3))
        ax = fig.add_subplot(1,2,1)
        ax.tick_params(labelsize=15)
        ax.set_ylabel("Scenarios and Mean",fontsize=15)
        plt.plot(DifferenceLoadWindSolar.T,'gray', label='Difference', lw=0.5)
        plt.plot(Thresold.T,'r', label='Average Difference', lw=2)
        plt.xticks([0,6,12,18,24], ('0', '6', '12', '18', '24'), fontsize='11', horizontalalignment='right')
        plt.show
        plt.grid()
        ax.tick_params(labelsize=15)
    
        index=[]
        ax = fig.add_subplot(1,2,2)
        ax.tick_params(labelsize=15)
        ax.set_ylabel("Mean and Ext scenario",fontsize=15)
        for k in range(0,1000):
            ScenArray=[]
            for i in range(0,24):
                scen=DifferenceLoadWindSolar[time[i]][k]
                ScenArray.append(scen)
            check=(ScenArray-Thresold)
            CheckArray=[]
            for t in range(0,24):
                CheckArray.append(check[time[t]])
            if(all(x > 0 for x in CheckArray)):
                plt.plot(time,ScenArray,'gray', label='Scenario', lw=0.5)
                index.append(k)
        plt.plot(Thresold.T,'r', label='Average Difference', lw=2)
        plt.xticks([0,6,12,18,24], ('0', '6', '12', '18', '24'), fontsize='11', horizontalalignment='right')
        plt.show
        plt.grid()
        ax.tick_params(labelsize=15)
        print("The indices of the scenarios which are always above the mean of the scenarios",index)
        plt.show()
    GenCostSortedAll=[]
    LoadShedSortedAll=[]
    CurtailSortedAll=[]
    for i in range(0,1000):
        a=GenerationCostAll[i]
        b=RenewableCurtailmentAll[i]
        GenCostSortedAll.append(a)
        CurtailSortedAll.append(b)

    sort_indexGenCostAll = np.argsort(GenCostSortedAll)
    #print("Scenario indices that causes highest 5% generation cost:", sort_indexGenCostAll[950:1000])
    sort_index_curAll = np.argsort(CurtailSortedAll)
    #print("Scenario indices that causes highest 5% renewable curtailment:", sort_index_curAll[950:1000])

    if showHist==False:
        fig = plt.figure(figsize=(15,3))
        ax_scatter = fig.add_subplot(1,3,1)
        for k in sort_indexGenCostAll[950:1000]:
            ScenArray=[]
            for i in range(0,24):
                scen=DifferenceLoadWindSolar[time[i]][k]
                ScenArray.append(scen)
            plt.plot(time,ScenArray,'gray', label='Scenario', lw=0.5)
        plt.plot(Thresold.T,'r', label='Average Difference', lw=2)
        plt.xticks([0,6,12,18,24], ('0', '6', '12', '18', '24'), fontsize='11', horizontalalignment='right')
        plt.show
        plt.grid()
        ax_scatter.tick_params(labelsize=15)
        ax_scatter = fig.add_subplot(1,3,2)
        for k in sort_index_curAll[950:1000]:
            ScenArray=[]
            for i in range(0,24):
                scen=DifferenceLoadWindSolar[time[i]][k]
                ScenArray.append(scen)
            plt.plot(time,ScenArray,'gray', label='Scenario', lw=0.5)
        plt.plot(Thresold.T,'r', label='Average Difference', lw=2)
        plt.xticks([0,6,12,18,24], ('0', '6', '12', '18', '24'), fontsize='11', horizontalalignment='right')
        plt.show
        plt.grid()
        ax_scatter.tick_params(labelsize=15)
        LoadShedSortedAll=[]
        for i in range(0,1000):
            a=LoadSheddingAll[i]
            LoadShedSortedAll.append(a)
        LoadShedSortedAll=np.nonzero(LoadShedSortedAll)

        ax_scatter = fig.add_subplot(1,3,3)
        for k in LoadShedSortedAll:
            ScenArray=[]
            for i in range(0,24):
                scen=DifferenceLoadWindSolar[time[i]][k]
                ScenArray.append(scen)
            plt.plot(time,ScenArray,'gray', label='Scenario', lw=0.5)
        plt.plot(Thresold.T,'r', label='Average Difference', lw=2)
        plt.xticks([0,6,12,18,24], ('0', '6', '12', '18', '24'), fontsize='11', horizontalalignment='right')
        plt.show
        plt.grid()
        ax_scatter.tick_params(labelsize=15)
    ThresoldCompArray=[]
    for i in range(0,24):
        ThresoldComp=Thresold[time[i]]
        ThresoldCompArray.append(ThresoldComp)
    #print(ThresoldCompArray)

    SumThresold=np.sum(ThresoldCompArray)
    #print("Daily production GWh for the mean,",SumThresold)
    IntegrationScen=[]
    for k in sort_indexGenCostAll[950:1000]:
        ScenArray=[]
        for i in range(0,24):
            scen=DifferenceLoadWindSolar[time[i]][k]
            ScenArray.append(scen)
        IntegrationScen.append(np.sum(ScenArray))
    #print(IntegrationScen)

    #sum(i > SumThresold for i in IntegrationScen)
    #print("The number of scenarios for which the integration sum over 24 hrs are bigger than the integration sum for the mean",num)

    #fig = plt.figure(figsize=(5,4))
    IntegrationScen=[]
    ExtScenIdx=[]
    for k in range(0,1000):
        ScenArray=[]
        for i in range(0,24):
            scen=DifferenceLoadWindSolar[time[i]][k]
            ScenArray.append(scen)
        a=np.sum(ScenArray)
        IntegrationScen.append(a)
        ExtScenIdx.append(k)
        #plt.plot(time,ScenArray,'b', label='Scenario', lw=0.5)
    #plt.plot(Thresold.T,'r', label='Average Difference', lw=2)
    #print(IntegrationScen)
    NumExtScen=sum(i > SumThresold for i in IntegrationScen)
    #print(NumExtScen)
    HighGenCost=[]
    for i in ExtScenIdx:
        HighGenCost.append(GenCostSortedAll[i])
    #print("The higher generation cost are:", HighGenCost)
    if showHist == True:
        fig = plt.figure(figsize=(6,4))
        gs = GridSpec(6, 6)
        ax_scatter = fig.add_subplot(gs[0:6, 0:6])
        ax_hist_x = fig.add_subplot(gs[0,0:6])
        ax_hist_y = fig.add_subplot(gs[0:6, 5])
        ax_scatter.tick_params(labelsize=15)
        IntegrationScen = np.array(IntegrationScen)
        HighGenCost = np.array(HighGenCost)
        #sns.regplot(IntegrationScen,GenerationCostAll,color='darkgreen')
        #print('sizex',IntegrationScen.shape)
        #print('sizey',GenerationCostAll.shape )
        ax_scatter.scatter(IntegrationScen,GenerationCostAll,s=9,color='darkgreen')
        L=np.argsort(IntegrationScen)
        #print(L)
        lowInt=L[950:1000]
        #lowInt =  IntegrationScen < genThresh
        #sns.regplot(IntegrationScen[lowInt],GenerationCostAll[lowInt],color='red')
        ax_scatter.scatter(IntegrationScen[lowInt],GenerationCostAll[lowInt],s=8,color='red')
        #ax_scatter.set_xticklabels(ax_scatter.get_xticks(), rotation = 90, fontsize=10)
        ax_scatter.set_xlabel("Daily Production GWh",fontsize=13)
        ax_scatter.set_ylabel("Daily GenerationCost",fontsize=13)
        #sns.regplot(y=np.quantile(GenerationCostAll,0.95), color='blue')
        ax_scatter.axhline(y=np.quantile(GenerationCostAll,0.95),linewidth=1.0, color='blue')
        check=np.quantile(GenerationCostAll,0.95)
        #print('check',check)
        probability=2*((GenerationCostAll[lowInt] > check).sum())
        #print('Probability',probability)
        ax_hist_x.hist(IntegrationScen,bins=20,alpha=0.4)
        ax_hist_x.axis('off')
        ax_hist_x.invert_yaxis()
        ax_hist_y.hist(HighGenCost,bins=20,orientation = 'horizontal',alpha=0.4)
        ax_hist_y.axis('off')
        ax_hist_y.invert_xaxis()
    return HighGenCost, IntegrationScen, ax_scatter, probability


# In[ ]:




