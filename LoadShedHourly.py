#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import pandas as pd
import bz2
import dill as pickle
import pandas as pd
import csv
import matplotlib.pyplot as plt
from numpy import mean
import numpy as np
import math
def LoadShedHours(hours, LoadShed):
    fig = plt.figure(figsize=(15,3))
    ax = fig.add_subplot(1,3,1)
    ax.set_ylabel("Load shedding",fontsize=15)
    ax.set_xlabel("hours",fontsize=15)
    plt.plot(hours,LoadShed,'.b')
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)
    
    DurationLoadShed=[]
    for i in range(0,1000):
        a=LoadShed[i]
        d=np.count_nonzero(a) 
        DurationLoadShed.append(d)
    ax = fig.add_subplot(1,3,2)
    ax.set_ylabel("Frequency",fontsize=15)
    ax.set_xlabel("Duration of Load Shed",fontsize=15)
    ax.hist(DurationLoadShed, bins=10, color='lightblue')
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)

    array2 = np.nonzero(DurationLoadShed)
    b=np.array(DurationLoadShed)[np.array(DurationLoadShed)>4]
    ExtIdx=np.where(np.array(DurationLoadShed)>3)
    print(ExtIdx)

    NumScen=[]
    for i in range(0,24):
        a=np.where(np.array(hours)==i)
        #print(a)
        #print(len(sum(np.nonzero(np.array(LoadShed)[a]))))
        NumScen.append(len(sum(np.nonzero(np.array(LoadShed)[a]))))
    print(NumScen)
    ax = fig.add_subplot(1,3,3)
    ax.set_ylabel("Num of Scens having Load Shed",fontsize=15)
    ax.set_xlabel("hours",fontsize=15)
    plt.plot(NumScen,'.-b', label='Num of Scens having Load Shed', lw=1.5)
    plt.locator_params(axis="x", nbins=4)
    plt.grid(linewidth=0.25)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=12)