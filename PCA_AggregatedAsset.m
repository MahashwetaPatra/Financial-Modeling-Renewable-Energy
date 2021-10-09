tic
clc;close all; clear all;
T1=1:1:24;%Time steps
for zonetype=1:8
if zonetype==1
files1 = dir('Arroyo*.csv');% calls all the assets from a folder
files2 = dir('Cottonwood*.csv');% calls all the assets from a folder
files3 = dir('Cutlass*.csv');% calls all the assets from a folder
files4 = dir('Danciger*.csv');% calls all the assets from a folder
files5 = dir('Danish*.csv');% calls all the assets from a folder
files6 = dir('Fighting*.csv');% calls all the assets from a folder
files7 = dir('Flag*.csv');% calls all the assets from a folder
files8 = dir('Fort*.csv');% calls all the assets from a folder
files9 = dir('Inverter*.csv');% calls all the assets from a folder
files10= dir('Long*.csv');% calls all the assets from a folder
files11 = dir('Lunis*.csv');% calls all the assets from a folder
files12 = dir('Maleza*.csv');% calls all the assets from a folder
files13 = dir('Mustang*.csv');% calls all the assets from a folder
files14 = dir('Myrtle*.csv');% calls all the assets from a folder
files15 = dir('Ramsey*.csv');% calls all the assets from a folder
files16 = dir('San*.csv');% calls all the assets from a folder
files17 = dir('solar*.csv');% calls all the assets from a folder
files18 = dir('Space*.csv');% calls all the assets from a folder
files19 = dir('Sunshine*.csv');% calls all the assets from a folder
files20 = dir('Texana*.csv');% calls all the assets from a folder
files21 = dir('Thickgrass*.csv');% calls all the assets from a folder
files22 = dir('Wagyu*.csv');% calls all the assets from a folder
files23 = dir('Westoria*.csv');
files=[files1;files2;files3;files4;files5(1);files5(2);files5(3);files6;files7;files8;files9;files10(1);files10(2);files11(1);files11(2); files12;files13;files14;files15;files16; files17(1); files17(2);files17(3);files17(4);files17(5);files17(6);files17(7);files17(8);files17(9);files17(10);files18;files19;files20;files21;files22;files23];
elseif zonetype==2
    files1 = dir('Angelina*.csv');% calls all the assets from a folder
files2 = dir('Blue*.csv');% calls all the assets from a folder
files3 = dir('GSE*.csv');% calls all the assets from a folder
files4 = dir('Hopkins*.csv');% calls all the assets from a folder
files5 = dir('Kellam*.csv');% calls all the assets from a folder
files6 = dir('Pine*.csv');% calls all the assets from a folder
files7 = dir('solar*.csv');% calls all the assets from a folder
files8 = dir('Solemio*.csv');% calls all the assets from a folder

files=[files1;files2;files3;files4;files5;files6;files7(1);files7(2);files8];
elseif zonetype==3
files1 = dir('Aragorn*.csv');% calls all the assets from a folder
files2 = dir('Bestla*.csv');% calls all the assets from a folder
files3 = dir('Blackwater*.csv');% calls all the assets from a folder
files4 = dir('Bluebonnet*.csv');% calls all the assets from a folder
files5 = dir('Chatee*.csv');% calls all the assets from a folder
files6 = dir('County*.csv');% calls all the assets from a folder
files7 = dir('Desert*.csv');% calls all the assets from a folder
files8 = dir('EK*.csv');% calls all the assets from a folder
files9 = dir('Emerald*.csv');% calls all the assets from a folder
files10= dir('Eunice*.csv');% calls all the assets from a folder
files11 = dir('Fowler*.csv');% calls all the assets from a folder
files12 = dir('Gold*.csv');% calls all the assets from a folder
files13 = dir('Goodranch*.csv');% calls all the assets from a folder
files14 = dir('Greasewood*.csv');% calls all the assets from a folder
files15 = dir('Green*.csv');% calls all the assets from a folder
files16 = dir('Greyhound*.csv');% calls all the assets from a folder
files17 = dir('Hecate*.csv');% calls all the assets from a folder
files18 = dir('HOVEY*.csv');% calls all the assets from a folder
files19 = dir('IP*.csv');% calls all the assets from a folder
files20= dir('Juno*.csv');% calls all the assets from a folder
files21 = dir('King*.csv');% calls all the assets from a folder
files22 = dir('Lapetus*.csv');% calls all the assets from a folder
files23 = dir('Long*.csv');% calls all the assets from a folder
files24 = dir('M-Bar*.csv');% calls all the assets from a folder
files25 = dir('Morada*.csv');% calls all the assets from a folder
files26 = dir('Normande*.csv');% calls all the assets from a folder
files27 = dir('Oberon*.csv');% calls all the assets from a folder
files28 = dir('Owego*.csv');% calls all the assets from a folder
files29 = dir('Oxbow*.csv');% calls all the assets from a folder
files30= dir('Oxy*.csv');% calls all the assets from a folder
files31 = dir('Phoebe*.csv');% calls all the assets from a folder
files32 = dir('Ponwar*.csv');% calls all the assets from a folder
files33 = dir('Prospero*.csv');% calls all the assets from a folder
files34 = dir('Queen*.csv');% calls all the assets from a folder
files35 = dir('RE*.csv');% calls all the assets from a folder
files36 = dir('Red*.csv');% calls all the assets from a folder
files37 = dir('Reiher*.csv');% calls all the assets from a folder
files38 = dir('Rodeo*.csv');% calls all the assets from a folder
files39 = dir('Santa*.csv');% calls all the assets from a folder
files40= dir('Sisters*.csv');% calls all the assets from a folder
files41 = dir('Soda*.csv');% calls all the assets from a folder
files42 = dir('solar*.csv');% calls all the assets from a folder
files43 = dir('SP*.csv');% calls all the assets from a folder
files44 = dir('Taygete*.csv');% calls all the assets from a folder
files45 = dir('Tri*.csv');% calls all the assets from a folder
files46 = dir('Upton*.csv');% calls all the assets from a folder
files47 = dir('West*.csv');% calls all the assets from a folder
files48 = dir('Whatley*.csv');% calls all the assets from a folder

files_sub=[files1;files2;files3;files4;files5; files6;files7;files8;files9;files10;files11;files12;files13;files14(1);files14(2);files15;files16(1);files16(2);files17;files18;files19;files20;files21;files22;files23;files24;files25;files26;files27; files28; files29;files30;files31;files32;files33(1);files33(2);files34;files35(1);files35(2);files35(3);files36];
files=[files_sub;files37;files38;files39;files40;files41;files42(1);files42(2);files43(1);files43(2);files43(3);files43(4);files44(1);files44(2);files45;files46;files47;files48;]
elseif zonetype==4
    files1 = dir('Agate*.csv');% calls all the assets from a folder
files2 = dir('Angus*.csv');% calls all the assets from a folder
files3 = dir('Double*.csv');% calls all the assets from a folder
files4 = dir('French*.csv');% calls all the assets from a folder
files5 = dir('Hallmark*.csv');% calls all the assets from a folder
files6 = dir('Hill*.csv');% calls all the assets from a folder
files7 = dir('Horseshoe*.csv');% calls all the assets from a folder
files8 = dir('Howle*.csv');% calls all the assets from a folder
files9 = dir('Lily*.csv');% calls all the assets from a folder
files10= dir('Markum*.csv');% calls all the assets from a folder
files11 = dir('Mercury*.csv');% calls all the assets from a folder
files12 = dir('Murphy*.csv');% calls all the assets from a folder
files13 = dir('Neeley*.csv');% calls all the assets from a folder
files14 = dir('Noble*.csv');% calls all the assets from a folder
files15 = dir('Owens*.csv');% calls all the assets from a folder
files16 = dir('North*.csv');% calls all the assets from a folder
files17 = dir('Radian*.csv');% calls all the assets from a folder
files18 = dir('Roseland*.csv');% calls all the assets from a folder
files19 = dir('Signal*.csv');% calls all the assets from a folder
files20= dir('Spanish*.csv');% calls all the assets from a folder
files21 = dir('Spectrum*.csv');% calls all the assets from a folder
files22 = dir('Strategic*.csv');% calls all the assets from a folder
files23 = dir('Sun*.csv');% calls all the assets from a folder
files24 = dir('Vision*.csv');% calls all the assets from a folder
files25 = dir('Wang*.csv');% calls all the assets from a folder

files=[files1;files2;files3;files4;files5;files6;files7;files8;files9;files10;files11;files12;files13;files14;files15;files16; files17(1);files17(2);files18;files19;files20;files21;files22;files23(1);files23(2);files24;files25];
elseif zonetype==5
    files1 = dir('Adamstown*.csv');% calls all the assets from a folder
files2 = dir('Bacon*.csv');% calls all the assets from a folder
files3 = dir('Castro*.csv');% calls all the assets from a folder
files4 = dir('Citrine*.csv');% calls all the assets from a folder
files5 = dir('Coniglio*.csv');% calls all the assets from a folder
files6 = dir('Juno*.csv');% calls all the assets from a folder
files7 = dir('Delilah*.csv');% calls all the assets from a folder
files8 = dir('Elrond*.csv');% calls all the assets from a folder
files9 = dir('Frye*.csv');% calls all the assets from a folder
files10= dir('Impact*.csv');% calls all the assets from a folder
files11 = dir('Lueders*.csv');% calls all the assets from a folder
files12 = dir('Misae*.csv');% calls all the assets from a folder
files13 = dir('Nazareth*.csv');% calls all the assets from a folder
files14 = dir('Obsidian*.csv');% calls all the assets from a folder
files15 = dir('Opal*.csv');% calls all the assets from a folder
files16 = dir('Phoenix*.csv');% calls all the assets from a folder
files17 = dir('Quantum*.csv');% calls all the assets from a folder
files18 = dir('Rippey*.csv');% calls all the assets from a folder
files19 = dir('Samson*.csv');% calls all the assets from a folder
files20 = dir('Sandine*.csv');% calls all the assets from a folder
files21 = dir('Shorthorn*.csv');% calls all the assets from a folder
files22 = dir('Texas*.csv');% calls all the assets from a folder
files23 = dir('Tyson*.csv');
files24 = dir('Wake*.csv');
files=[files1;files2;files3;files4;files5;files6;files7(1);files7(2);files8;files9;files10;files11; files12(1);files12(2);files13;files14;files15;files16; files17(1); files17(2);files18;files19(1);files19(2);files19(3);files20;files21;files22;files23;files24];
elseif zonetype==6
    files1 = dir('Garnet*.csv');% calls all the assets from a folder
files2 = dir('Pflugerville*.csv');% calls all the assets from a folder
files3 = dir('Smithland*.csv');% calls all the assets from a folder
files4 = dir('solar*.csv');% calls all the assets from a folder

files=[files1;files2(1);files2(2);files3;files4(1); files4(2);files4(3);files4(4);files4(5);files4(6)];
elseif zonetype==7
    files1 = dir('Arroyo*.csv');% calls all the assets from a folder
files2 = dir('Atascosa*.csv');% calls all the assets from a folder
files3 = dir('Brightside*.csv');% calls all the assets from a folder
files4 = dir('Corazon*.csv');% calls all the assets from a folder
files5 = dir('Diamondback*.csv');% calls all the assets from a folder
files6 = dir('Dove*.csv');% calls all the assets from a folder
files7 = dir('El*.csv');% calls all the assets from a folder
files8 = dir('Fronton*.csv');% calls all the assets from a folder
files9 = dir('Half*.csv');% calls all the assets from a folder
files10= dir('Horizon*.csv');% calls all the assets from a folder
files11 = dir('Morrow*.csv');% calls all the assets from a folder
files12 = dir('Rayos*.csv');% calls all the assets from a folder
files13 = dir('Robles*.csv');% calls all the assets from a folder
files14 = dir('Shakes*.csv');% calls all the assets from a folder
files15 = dir('Starr*.csv');% calls all the assets from a folder
files16 = dir('Stillwater*.csv');% calls all the assets from a folder
files17 = dir('Trevino*.csv');% calls all the assets from a folder
files18 = dir('Tulsita*.csv');% calls all the assets from a folder
files19 = dir('Vancount*.csv');% calls all the assets from a folder

files=[files1;files2;files3;files4;files5;files6;files7(1);files7(2);files8;files9;files10;files11(1); files11(2);files12;files13;files14;files15;files16; files17;files18;files19];
elseif zonetype==8
    files1 = dir('Angelo*.csv');% calls all the assets from a folder
files2 = dir('Anson*.csv');% calls all the assets from a folder
files3 = dir('Basalt*.csv');% calls all the assets from a folder
files4 = dir('Blue*.csv');% calls all the assets from a folder
files5 = dir('Bravepost*.csv');% calls all the assets from a folder
files6 = dir('Brushy*.csv');% calls all the assets from a folder
files7 = dir('Charbray*.csv');% calls all the assets from a folder
files8 = dir('Concho*.csv');% calls all the assets from a folder
files9 = dir('Crowded*.csv');% calls all the assets from a folder
files10= dir('Dexter*.csv');% calls all the assets from a folder
files11 = dir('Flatland*.csv');% calls all the assets from a folder
files12 = dir('Fluorite*.csv');% calls all the assets from a folder
files13 = dir('Galloway*.csv');% calls all the assets from a folder
files14 = dir('Holstein*.csv');% calls all the assets from a folder
files15 = dir('Indigo*.csv');% calls all the assets from a folder
files16 = dir('Knickerbocker*.csv');% calls all the assets from a folder
files17 = dir('Kochab*.csv');% calls all the assets from a folder
files18 = dir('Lumina*.csv');% calls all the assets from a folder
files19 = dir('March*.csv');% calls all the assets from a folder
files20= dir('Norton*.csv');% calls all the assets from a folder
files21 = dir('Prickly*.csv');% calls all the assets from a folder
files22 = dir('Rambler*.csv');% calls all the assets from a folder
files23 = dir('solar*.csv');% calls all the assets from a folder
files24 = dir('Tom*.csv');% calls all the assets from a folder
files25 = dir('Ulysses*.csv');% calls all the assets from a folder
files26 = dir('Zier*.csv');% calls all the assets from a folder

files=[files1;files2(1);files2(2);files2(3);files3;files4(1);files4(2);files5; files6;files7;files8;files9;files10;files11;files12;files13;files14(1);files14(2);files15;files16; files17;files18;files19;files20;files21;files22;files23;files24;files25;files26];

end
PCA_Aggregated(zonetype,files);
end
toc