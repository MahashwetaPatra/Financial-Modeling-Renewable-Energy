#!/usr/bin/env python
# coding: utf-8

# In[1]:


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
def GenCostIntegrationScen2( DifferenceLoadWindSolar, GenerationCostAll, RenewableCurtailmentAll, LoadSheddingAll, time):
    Thresold=mean(DifferenceLoadWindSolar)
    
    index=[]
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
            #plt.plot(time,ScenArray,'gray', label='Scenario', lw=0.5)
            index.append(k)
    #plt.plot(Thresold.T,'r', label='Average Difference', lw=2)
    print("The indices of the scenarios which are always above the mean of the scenarios",index)
    #plt.show()
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

    #fig = plt.figure(figsize=(15,3))
    #ax = fig.add_subplot(1,3,1)
    for k in sort_indexGenCostAll[950:1000]:
        ScenArray=[]
        for i in range(0,24):
            scen=DifferenceLoadWindSolar[time[i]][k]
            ScenArray.append(scen)
        #plt.plot(time,ScenArray,'gray', label='Scenario', lw=0.5)
    #plt.plot(Thresold.T,'r', label='Average Difference', lw=2)

    #ax = fig.add_subplot(1,3,2)
    for k in sort_index_curAll[950:1000]:
        ScenArray=[]
        for i in range(0,24):
            scen=DifferenceLoadWindSolar[time[i]][k]
            ScenArray.append(scen)
        #plt.plot(time,ScenArray,'gray', label='Scenario', lw=0.5)
    #plt.plot(Thresold.T,'r', label='Average Difference', lw=2)

    LoadShedSortedAll=[]
    for i in range(0,1000):
        a=LoadSheddingAll[i]
        LoadShedSortedAll.append(a)
    LoadShedSortedAll=np.nonzero(LoadShedSortedAll)

    #ax = fig.add_subplot(1,3,3)
    for k in LoadShedSortedAll:
        ScenArray=[]
        for i in range(0,24):
            scen=DifferenceLoadWindSolar[time[i]][k]
            ScenArray.append(scen)
        #plt.plot(time,ScenArray,'gray', label='Scenario', lw=0.5)
    #plt.plot(Thresold.T,'r', label='Average Difference', lw=2)

    ThresoldCompArray=[]
    for i in range(0,24):
        ThresoldComp=Thresold[time[i]]
        ThresoldCompArray.append(ThresoldComp)
    #print(ThresoldCompArray)

    SumThresold=np.sum(ThresoldCompArray)
    print(SumThresold)
    IntegrationScen=[]
    for k in sort_indexGenCostAll[950:1000]:
        ScenArray=[]
        for i in range(0,24):
            scen=DifferenceLoadWindSolar[time[i]][k]
            ScenArray.append(scen)
        IntegrationScen.append(np.sum(ScenArray))
    #print(IntegrationScen)

    print("The number of scenarios for which the integration sum over 24 hrs are bigger than the integration sum for the mean")
    sum(i > SumThresold for i in IntegrationScen)

    #fig = plt.figure(figsize=(5,4))
    #ax.tick_params(labelsize=15)
    IntegrationScen=[]
    ExtScenIdx=[]
    for k in sort_indexGenCostAll[0:1000]:
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
    fig = plt.figure(figsize=(6,5))
    gs = GridSpec(6, 6)
    ax_scatter = fig.add_subplot(gs[0:6, 0:6])
    ax_hist_x = fig.add_subplot(gs[0,0:6])
    ax_hist_y = fig.add_subplot(gs[0:6, 5])
    ax_scatter.tick_params(labelsize=15)
    IntegrationScen = np.array(IntegrationScen)
    HighGenCost = np.array(HighGenCost)
    ax_scatter.scatter(IntegrationScen,HighGenCost,s=9,color='darkgreen')
    lowInt =  IntegrationScen < 9500
    ax_scatter.scatter(IntegrationScen[lowInt],HighGenCost[lowInt],s=8,color='red')
    #ax.hist(GenerationCostAll)
    #ax.hist(HighGenCost, bins=10,color = "red")
    ax_scatter.set_xticklabels(ax_scatter.get_xticks(), rotation = 90, fontsize=10)
    ax_scatter.set_xlabel("Daily Production GWh",fontsize=13)
    ax_scatter.set_ylabel("Daily Generation Cost",fontsize=13)
    ax_scatter.axhline(y=np.quantile(HighGenCost,0.95),linewidth=0.5)

    ax_hist_x.hist(IntegrationScen,bins=20,alpha=0.4)
    #ax_hist_x.get_xaxis().set_visible(False)
    #ax_hist_x.get_yaxis().set_visible(False)
    ax_hist_x.axis('off')
    ax_hist_x.invert_yaxis()
    ax_hist_y.hist(HighGenCost,bins=20,orientation = 'horizontal',alpha=0.4)
    #ax_hist_y.get_xaxis().set_visible(False)
    #ax_hist_y.get_yaxis().set_visible(False)
    ax_hist_y.axis('off')
    ax_hist_y.invert_xaxis()
    #ax.hist(GenerationCostAll)
    #ax.hist(HighGenCost, bins=10,color = "red")
    return HighGenCost, IntegrationScen


# In[ ]:




