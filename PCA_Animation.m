% NOTE: This is for calculating the Animation video for the PCA factors in a time range
%       using the output csv files generated by the PCA analysis
% HIST:  - 1o Oct, 2021: Created by Patra
%=========================================================================
function PCA_Animation=PCA_Animation(year, startdate, enddate, assettype, Assetnumber, PCAfactor, framerate)
T1=1:1:24; %Time steps
coeff1=[];
Array=readtable(strcat('Coefficients/',assettype,'_coefficient.csv'));
column=Assetnumber+1;
PCA_Animation = figure;
videoname=strcat(assettype,PCAfactor,year,'.avi');
writerObj = VideoWriter(videoname); % Name it.
writerObj.FrameRate = framerate; % How many frames per second.
open(writerObj);
for date=startdate:enddate
    i=(date-1)*96+2;
    j=i+23;
    if contains(PCAfactor, 'coefficient1')
        coeff1=Array{i:j,column};
    elseif contains(PCAfactor, 'coefficient2')
        i=i+24;j=j+24;
        coeff1=Array{i:j,column};
    elseif contains(PCAfactor, 'coefficient3')
        i=i+48;j=j+48;
        coeff1=Array{i:j,column};
    elseif contains(PCAfactor, 'coefficient4')
        i=i+72;j=j+72;
        coeff1=Array{i:j,column};
    end
    x = T1; % Note the transpose.
    y = coeff1;
    pause(0.1);
    figure(PCA_Animation); % Makes sure you use your desired frame.
    plot(x,y,'.-b');
    ylim([-0.6 0.65])
    xlabel('Time (hours)')
    ylabel('Energy')
    title(strcat('AssetNumber',num2str(Assetnumber),'date',num2str(date)))
    frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
    writeVideo(writerObj, frame);   
end
hold off
close(writerObj); % Saves the movie.