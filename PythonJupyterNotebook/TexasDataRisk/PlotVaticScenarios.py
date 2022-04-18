#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import pandas as pd
import bz2
import matplotlib.pyplot as plt
import dill as pickle
import numpy as np
from numpy import mean

from GenCostIntegrationScenario import *
from PlotScenarios import *
from numpy import mean
def PlotingScenarios(time, WindScenarios,SolarScenarios, LoadScenarios, date):
    WindMean=WindScenarios.mean()
    SolarMean=SolarScenarios.mean()
    LoadMean=LoadScenarios.mean()
    fig = plt.figure(figsize=(15,3))
    ax = fig.add_subplot(1,3,1)
    ax.set_ylabel("Wind-"+date,fontsize=15)
    ax = plotScens(time, WindScenarios, WindMean, ax=ax, legend=1)
    
    ax = fig.add_subplot(1,3,2)
    ax.set_ylabel("Solar-"+date,fontsize=15)
    ax = plotScens(time, SolarScenarios, SolarMean, ax=ax)
 
    ax = fig.add_subplot(1,3,3)
    ax.set_ylabel("Net Load-"+date,fontsize=15)
    ax = plotScens(time, LoadScenarios, LoadMean,ax=ax)
    
def PlotingVaticOutput(GenerationCostAll, LoadSheddingAll, RenewableCurtailmentAll, ReserveShortfallAll, date):
    #GenerationCostAll=VaticOutput['GenerationCostAll']
    #LoadSheddingAll=VaticOutput['LoadSheddingAll']
    #RenewableCurtailmentAll=VaticOutput['RenewableCurtailmentAll']
    
    fig = plt.figure(figsize=(15,3))
    ax = fig.add_subplot(1,5,1)
    ax.set_ylabel("Generation Cost-"+date,fontsize=15)
    ax.hist(GenerationCostAll, bins=20, color='lightblue',alpha=0.5)
    #plt.xlim(0, 300000)
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)

    ax = fig.add_subplot(1,5,2)
    ax.set_ylabel("Load Shedding-"+date,fontsize=15)
    ax.hist(LoadSheddingAll, bins=25, color='lightblue',alpha=0.5)
    plt.locator_params(axis="x", nbins=4)
    plt.ylim(0,100)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)

    ax = fig.add_subplot(1,5,3)
    ax.set_ylabel("Ren. Curtailment-"+date,fontsize=15)
    ax.hist(RenewableCurtailmentAll, bins=20, color='lightblue',alpha=0.5)
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)
    
    ax = fig.add_subplot(1,5,4)
    ax.set_ylabel("Reserve Shortfall-"+date,fontsize=15)
    ax.hist(ReserveShortfallAll, bins=20, color='lightblue',alpha=0.5)
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)
    
    ax_scatter = fig.add_subplot(1,5,5)
    ax.set_ylabel("Reserve Shortfall-"+date,fontsize=15)
    ax_scatter.scatter(GenerationCostAll, ReserveShortfallAll,s=8,color='blue')
    ax_scatter.set_xticklabels(ax_scatter.get_xticks(), rotation = 90, fontsize=10)
    ax_scatter.set_xlabel("Generation cost all",fontsize=13)
    ax_scatter.set_ylabel("Reserve shortfall",fontsize=13)
    correlationship=np.corrcoef(GenerationCostAll, ReserveShortfallAll, rowvar=False)
    print('correlation coefficient between generation cost and reserve short fall',correlationship[0][1])
    
def LoadShedHours(hours, LoadShed,date):
    fig = plt.figure(figsize=(15,3))
    ax = fig.add_subplot(1,2,1)
    DurationLoadShed=[]
    for i in range(0,24000,24):
        #print(i)
        a=LoadShed[i:i+23]
        #print(a)
        d=np.count_nonzero(a) 
        DurationLoadShed.append(d)
    ax.set_ylabel("Frequency-"+date,fontsize=15)
    ax.set_xlabel("Duration of Load Shed",fontsize=15)
    ax.hist(DurationLoadShed, bins=10,color = "b")
    plt.show
    plt.grid()
    ax.tick_params(labelsize=15)
def PlotingScenariosLoadShed(time, WindScenarios,SolarScenarios, LoadScenarios, LoadShedIndex, date):
    WindMean=WindScenarios.mean()
    SolarMean=SolarScenarios.mean()
    LoadMean=LoadScenarios.mean()
    fig = plt.figure(figsize=(15,3))
    ax = fig.add_subplot(1,3,1)
    ax.set_ylabel("Wind-"+date,fontsize=15)
    ax = plotScens(time, WindScenarios, WindMean, ax=ax, legend=1)
    plt.plot( WindScenarios.loc[LoadShedIndex].T,'black')
        
    ax = fig.add_subplot(1,3,2)
    ax.set_ylabel("Solar-"+date,fontsize=15)
    ax = plotScens(time, SolarScenarios, SolarMean, ax=ax)
    plt.plot( SolarScenarios.loc[LoadShedIndex].T,'black')
        
    ax = fig.add_subplot(1,3,3)
    ax.set_ylabel("Net Load-"+date,fontsize=15)
    ax = plotScens(time, LoadScenarios, LoadMean,ax=ax)
    plt.plot( LoadScenarios.loc[LoadShedIndex].T,'black')
def PlotingVaticOutputExtreme(GenerationCostAll, LoadSheddingAll, RenewableCurtailmentAll, ReserveShortfallAll, ShortFall, date):
    
    #GenerationCostAll=VaticOutput['GenerationCostAll']
    #LoadSheddingAll=VaticOutput['LoadSheddingAll']
    #RenewableCurtailmentAll=VaticOutput['RenewableCurtailmentAll']
    
    fig = plt.figure(figsize=(15,3))
    ax = fig.add_subplot(1,5,1)
    ax.set_ylabel("Generation Cost-"+date,fontsize=15)
    ax.hist(GenerationCostAll, bins=20, color='lightblue',alpha=0.5)
    #ax.hist(ExtremeCost, bins=20, color='red',alpha=0.5)
    #ax.axhline(x=np.quantile(GenerationCostAll,0.95),linewidth=1.0, color='blue')  
    #plt.xlim(0, 300000)
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)

    ax = fig.add_subplot(1,5,2)
    ax.set_ylabel("Load Shedding-"+date,fontsize=15)
    ax.hist(LoadSheddingAll, bins=25, color='lightblue',alpha=0.5)
    plt.locator_params(axis="x", nbins=4)
    plt.ylim(0,100)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)

    ax = fig.add_subplot(1,5,3)
    ax.set_ylabel("Ren. Curtailment-"+date,fontsize=15)
    ax.hist(RenewableCurtailmentAll, bins=20, color='lightblue',alpha=0.5)
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)
    
    ax = fig.add_subplot(1,5,4)
    ax.set_ylabel("Reserve Shortfall-"+date,fontsize=15)
    ax.hist(ReserveShortfallAll, bins=20, color='lightblue',alpha=0.5)
    ax.hist(ShortFall, bins=20, color='red',alpha=0.5)
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)
    
    ax_scatter = fig.add_subplot(1,5,5)
    ax.set_ylabel("Reserve Shortfall-"+date,fontsize=15)
    ax_scatter.scatter(GenerationCostAll, ReserveShortfallAll,s=8,color='blue')
    ax_scatter.set_xticklabels(ax_scatter.get_xticks(), rotation = 90, fontsize=10)
    ax_scatter.set_xlabel("Generation cost all",fontsize=13)
    ax_scatter.set_ylabel("Reserve shortfall",fontsize=13)
    correlationship=np.corrcoef(GenerationCostAll, ReserveShortfallAll, rowvar=False)
    print('correlation coefficient between generation cost and reserve short fall',correlationship[0][1])

