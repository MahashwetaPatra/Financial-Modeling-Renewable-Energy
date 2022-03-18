tic
clc;close all; clear all;
%% Run this file to get the K-S score values for all dates for all three algorithms
%% Provide with the Input
RepScenario = input('Number of representative scenarios, e.g 100: ');
%hours = input('At what hour we want to check the histogram nature? for example 10?: ');
for i=1:10 % Month names are Jan, Feb, Mar, Apr, June, Aug, Sep, Oct, Nov, Dec
Month=input('Month name:','s') ;
RTSRepresentativeScenNetLoad(RepScenario, hours, Month)

end