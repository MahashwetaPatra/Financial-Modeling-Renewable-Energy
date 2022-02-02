%
% NOTE:     investigate to what extent are 
%           the PCA factors of individual assets similar 
%           to the PCA of the aggregated sum
%=========================================================================
tic
clc;close all; clear all;
T1=1:1:24;%Time steps
Array = readtable("solar_meta_new.xlsx");
Zones=Array{:,8};
ZonesNorth=[];ZonesSouth=[];ZonesCoast=[];ZonesEast=[];ZonesFarWest=[];ZonesNorthCentral=[];ZonesSouthCentral=[];ZonesWest=[];
for z=1:size(Zones)
    if contains(Zones(z), 'NORTH CENTRAL')
        a=convertCharsToStrings(Array{z,1});
        file=dir(strcat(a,'.csv'));
        ZonesNorthCentral=[ZonesNorthCentral;file];
    elseif contains(Zones(z), 'SOUTH CENTRAL')
        a=convertCharsToStrings(Array{z,1});
        file=dir(strcat(a,'.csv'));
        ZonesSouthCentral=[ZonesSouthCentral;file];
    elseif contains(Zones(z), 'NORTH')
        a=convertCharsToStrings(Array{z,1});
        filename=strcat(a,'.csv');
        file=dir(filename);
        ZonesNorth=[ZonesNorth;file];
    elseif contains(Zones(z), 'SOUTHERN')
        a=convertCharsToStrings(Array{z,1});
        file=dir(strcat(a,'.csv'));
        ZonesSouth=[ZonesSouth;file];
    elseif contains(Zones(z), 'COAST')
        a=convertCharsToStrings(Array{z,1});
        file=dir(strcat(a,'.csv'));
        ZonesCoast=[ZonesCoast;file];
    elseif contains(Zones(z), 'EAST')
        a=convertCharsToStrings(Array{z,1});
        file=dir(strcat(a,'.csv'));
        ZonesEast=[ZonesEast;file];
    elseif contains(Zones(z), 'FAR WEST')
        a=convertCharsToStrings(Array{z,1});
        file=dir(strcat(a,'.csv'));
        ZonesFarWest=[ZonesFarWest;file];
    elseif contains(Zones(z), 'WEST')
        a=convertCharsToStrings(Array{z,1});
        file=dir(strcat(a,'.csv'));
        ZonesWest=[ZonesWest;file];
    end
end
PCA_Aggregated(size(ZonesFarWest),ZonesFarWest,'FarWest');
PCA_Aggregated(size(ZonesEast),ZonesEast,'East');
PCA_Aggregated(size(ZonesWest),ZonesWest,'West');
PCA_Aggregated(size(ZonesCoast),ZonesCoast,'Coast');
PCA_Aggregated(size(ZonesSouth),ZonesSouth,'South');
PCA_Aggregated(size(ZonesNorthCentral),ZonesNorthCentral,'NorthCentral');
PCA_Aggregated(size(ZonesSouthCentral),ZonesSouthCentral,'SouthCentral');
PCA_Aggregated(size(ZonesNorth),ZonesNorth,'North');
toc
