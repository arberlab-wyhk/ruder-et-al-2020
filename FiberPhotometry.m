%%Fiber photometry script adapted on the 180919 for plotting PCRT animals
%%straight during reaching

SpreadsheetRecording = readtable...
    ('Y:\User\temp\PCRt_retro_photometry_2\14.10.2019\animal2.csv');
SpreadsheetRecordingMovieTimepoints = readtable...
    ('Y:\User\temp\PCRt_retro_photometry_2\14.10.2019\animal2_MovieTimeStamps.csv');
%you need to know the number of frame from the MovieTimepoint file got
%through the cineplex file
Frames = 0;
for ii = 1:length(SpreadsheetRecordingMovieTimepoints.Var1)
    if strcmp(SpreadsheetRecordingMovieTimepoints.Var1{ii}, 'Frame Marker')%FrameMarker or Frame Marker 
        Frames = Frames + 1;
    end
end
%dFF is the dF/F from the plexon system and Raw is the original signal


FactorCorrect_dFF = length(SpreadsheetRecording.R_1)- Frames;
%in between the movies and the signal there is a different number of frame
%you need to remove the surplus frames form the signal


PhotometrySignal_dFF = SpreadsheetRecording.R_1(FactorCorrect_dFF+1:end);
%check which fiber you need to analyse R_1 or R_2
WindowBefore = 1;
WindowAfter = 5;
FrameRate= 60;

%ReachingStartFinal = round(ReachingStart*FrameRate);%when you have the
%time in ms
ReachingStartFinal = ReachingStart/FrameRate;
%divide by frame rate and no round if you already have frame for the start
%of the reaching and the end
%ReachingEndFinal = round(ReachingEnd*FrameRate);
ReachingEndFinal = ReachingEnd/FrameRate;

%cut out recordings of reachings with specified window for the dFF

for ii = 1:length(ReachingStart);%here ReachingStart when you have the number of frame as ReachingStart 
    %or ReachingStartFinal when you have the time in ms
    BehaviorRecording1_dFF(:,ii) = PhotometrySignal_dFF(ReachingStart(ii)-(WindowBefore*FrameRate):1:ReachingStart(ii)...
        +(WindowAfter*FrameRate));
end

%calculate std for when the reaching end occurs
%ReachingEndRelative = ReachingEnd - ReachingStart;
ReachingEndRelative = ReachingEndFinal - ReachingStartFinal;
%ReachingStartFinal and ReachingEndFinal if you start with the ReachingStart as number of frames
StdReachingEnd = std(ReachingEndRelative)/sqrt(length(ReachingEndRelative));
 
xCoordinates = [-((length(BehaviorRecording1_dFF)-1)/FrameRate)/6:1/FrameRate:(((length(BehaviorRecording1_dFF)-1)/FrameRate)-1)];


figure (1)

%rescale from frames to seconds 
hold on
plot(xCoordinates,BehaviorRecording1_dFF,'g--')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF,2), std(BehaviorRecording1_dFF,0,2)/sqrt(size(BehaviorRecording1_dFF,2)))

title('dFF not  normalized 111019 ')

figure (2)

%rescale from frames to seconds 
hold on
plot(xCoordinates,BehaviorRecording1_dFF,'g--')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF,2), std(BehaviorRecording1_dFF,0,2)/sqrt(size(BehaviorRecording1_dFF,2)))

title('dFF not  normalized 141019')

figure (3)

%rescale from frames to seconds 
hold on
plot(xCoordinates,BehaviorRecording1_dFF,'g--')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF,2), std(BehaviorRecording1_dFF,0,2)/sqrt(size(BehaviorRecording1_dFF,2)))

title('dFF not  normalized 141019')

projectdir = ('Y:\User\temp\PCRt_retro_photometry_2\11.10.2019\')
for i=1:1
 saveas(figure(i),fullfile(projectdir,['figure' num2str(i) '.pdf']));
end
close all


%% to pool 2 recording days you need the ReachingEndRealtive and the BehaviorRecording1 
%%for the dF/F

%Pull the BehaviorRecording_ ddF from the different days as well as



BehaviorRecording1_dFF = [BehaviorRecording1_dFF_100919, BehaviorRecording1_dFF_120919, BehaviorRecording1_dFF_130919];
BehaviorRecordingRandom_dFF = [BehaviorRecordingRandom_dFF_100919, BehaviorRecordingRandom_dFF_120919, BehaviorRecordingRandom_dFF_130919];
FrameRate =60;
WindowBefore=1;
WindowAfter= 5;
%%random columns in matrix for plotting less trails

    ncol = 15
    x = randi(size(BehaviorRecording1_dFF,2),1,ncol);
    columns = BehaviorRecording1_dFF(:,x);


xCoordinates = [-((length(BehaviorRecording1_dFF)-1)/FrameRate)/6:1/FrameRate:(((length(BehaviorRecording1_dFF)-1)/FrameRate)-1)]; 

% dF/F signal

figure (4)
hold on
plot(xCoordinates,BehaviorRecording1_dFF,'g--')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF,2), std(BehaviorRecording1_dFF,0,2)/sqrt(size(BehaviorRecording1_dFF,2)))
title('dFF not  normalized 100919 130919 130919')

figure(5)
hold on
plot(xCoordinates,BehaviorRecording1_dFF,'g--')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF,2), std(BehaviorRecording1_dFF,0,2)/sqrt(size(BehaviorRecording1_dFF,2)))
title('dFF not  normalized 100919 120919 ')


projectdir = ('M:\cpivetta\111_Scripts\Photometry\PCRT_Photometry_analysis\PCRT_retro_photometry\pulledDays')
for i=1:4
 saveas(figure(i),fullfile(projectdir,['figure' num2str(i) '.pdf']));
end
close all






%% Plotting Random events

%%Plotting of random events as way of control over the signal fluctuation
%you need the BehavioralRecording1 and the PhotometrySignal_dFF

%create random ReachingStart events 
ReachingStart_random = randi([1,size(PhotometrySignal_dFF-360,1)],size(BehaviorRecording1_dFF,2),1);

for ii = 1:length(ReachingStart_random);%here ReachingStart when you have the number of frame as ReachingStart 
    %or ReachingStartFinal when you have the time in ms
    BehaviorRecordingRandom_dFF(:,ii) = PhotometrySignal_dFF(ReachingStart_random(ii)-(WindowBefore*FrameRate):1:ReachingStart_random(ii)...
        +(WindowAfter*FrameRate));
end




 
%rescale from frames to seconds  
xCoordinates = [-((length(BehaviorRecording1_dFF)-1)/FrameRate)/6:1/FrameRate:(((length(BehaviorRecording1_dFF)-1)/FrameRate)-1)]; 

figure (6)
hold on
plot(xCoordinates,BehaviorRecordingRandom_dFF,'g--')
shadedErrorBar(xCoordinates,mean(BehaviorRecordingRandom_dFF,2), std(BehaviorRecordingRandom_dFF,0,2)/sqrt(size(BehaviorRecordingRandom_dFF,2)),'k')
title('dFF not  normalized Random')

figure(7)
hold on
shadedErrorBar(xCoordinates,mean(BehaviorRecordingRandom_dFF,2), std(BehaviorRecordingRandom_dFF,0,2)/sqrt(size(BehaviorRecordingRandom_dFF,2)),'k')
plot(xCoordinates,mean(BehaviorRecordingRandom_dFF,2),'k')
hold on
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF,2), std(BehaviorRecording1_dFF,0,2)/sqrt(size(BehaviorRecording1_dFF,2)),'g')
plot(xCoordinates,mean(BehaviorRecording1_dFF,2),'g')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_OF,2), std(BehaviorRecording1_dFF_OF,0,2)/sqrt(size(BehaviorRecording1_dFF_OF,2)),'m')

title('dFF not  normalized Random (k) and 100919 120919 130919 (g)' )




projectdir = ('Y:\User\temp\PCRT_MdD_Phototmetry\PulledDays')
for i=1:7
 saveas(figure(i),fullfile(projectdir,['figure' num2str(i) '.pdf']));
end
close all

%% 
%%pull animals together
xCoordinates = [-((length(BehaviorRecording1_dFF_2)-1)/FrameRate)/6:1/FrameRate:(((length(BehaviorRecording1_dFF_2)-1)/FrameRate)-1)]; 

figure(8)
hold on
shadedErrorBar(xCoordinates,mean(BehaviorRecordingRandom_dFF_2,2), std(BehaviorRecordingRandom_dFF_2,0,2)/sqrt(size(BehaviorRecordingRandom_dFF_2,2)),'k',1)
plot(xCoordinates,mean(BehaviorRecordingRandom_dFF_2,2),'k')
shadedErrorBar(xCoordinates,mean(BehaviorRecordingRandom_dFF_5,2), std(BehaviorRecordingRandom_dFF_5,0,2)/sqrt(size(BehaviorRecordingRandom_dFF_5,2)),'k',1)
plot(xCoordinates,mean(BehaviorRecordingRandom_dFF_5,2),'k')
shadedErrorBar(xCoordinates,mean(BehaviorRecordingRandom_dFF_4,2), std(BehaviorRecordingRandom_dFF_4,0,2)/sqrt(size(BehaviorRecordingRandom_dFF_4,2)),'k',1)
plot(xCoordinates,mean(BehaviorRecordingRandom_dFF_4,2),'k')
shadedErrorBar(xCoordinates,mean(BehaviorRecordingRandom_dFF_0,2), std(BehaviorRecordingRandom_dFF_0,0,2)/sqrt(size(BehaviorRecordingRandom_dFF_0,2)),'k',1)
plot(xCoordinates,mean(BehaviorRecordingRandom_dFF_0,2),'k')
hold on
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_2,2), std(BehaviorRecording1_dFF_2,0,2)/sqrt(size(BehaviorRecording1_dFF_2,2)),'g',1)
plot(xCoordinates,mean(BehaviorRecording1_dFF_2,2),'g')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_5,2), std(BehaviorRecording1_dFF_5,0,2)/sqrt(size(BehaviorRecording1_dFF_5,2)),'g',1)
plot(xCoordinates,mean(BehaviorRecording1_dFF_5,2),'g')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_4,2), std(BehaviorRecording1_dFF_4,0,2)/sqrt(size(BehaviorRecording1_dFF_4,2)),'g',1)
plot(xCoordinates,mean(BehaviorRecording1_dFF_4,2),'g')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_0,2), std(BehaviorRecording1_dFF_0,0,2)/sqrt(size(BehaviorRecording1_dFF_0,2)),'g',1)
plot(xCoordinates,mean(BehaviorRecording1_dFF_0,2),'g')
hold on
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_OF_2,2), std(BehaviorRecording1_dFF_OF_2,0,2)/sqrt(size(BehaviorRecording1_dFF_OF_2,2)),'m',1)
plot(xCoordinates,mean(BehaviorRecording1_dFF_OF_2,2),'m')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_OF_5,2), std(BehaviorRecording1_dFF_OF_5,0,2)/sqrt(size(BehaviorRecording1_dFF_OF_5,2)),'m',1)
plot(xCoordinates,mean(BehaviorRecording1_dFF_OF_5,2),'m')
% shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_OF_4,2), std(BehaviorRecording1_dFF_OF_4,0,2)/sqrt(size(BehaviorRecording1_dFF_OF_4,2)),'g',1)
% plot(xCoordinates,mean(BehaviorRecording1_dFF_4,2),'g')
shadedErrorBar(xCoordinates,mean(BehaviorRecording1_dFF_OF_0,2), std(BehaviorRecording1_dFF_0,0,2)/sqrt(size(BehaviorRecording1_dFF_OF_0,2)),'m',1)
plot(xCoordinates,mean(BehaviorRecording1_dFF_OF_0,2),'m')



title('dFF not  normalized Random (k) and animals 2 5 4 0 (g) OF(m)' )
hold on
vline(0)

%% Normalization within an animal between 0 and 1 to pull animals together afterward

data.Random0 =BehaviorRecordingRandom_dFF_0;
data.Random2 =BehaviorRecordingRandom_dFF_2;
data.Random4 =BehaviorRecordingRandom_dFF_4;
data.Random5 =BehaviorRecordingRandom_dFF_5;

dataOF.OF0 =BehaviorRecording1_dFF_OF_0;
dataOF.OF2 =BehaviorRecording1_dFF_OF_2;
dataOF.OF4 =BehaviorRecording1_dFF_OF_4;
dataOF.OF5 =BehaviorRecording1_dFF_OF_5;

dataReaching.Reaching0 =BehaviorRecording1_dFF_0;
dataReaching.Reaching2 =BehaviorRecording1_dFF_2;
dataReaching.Reaching4 =BehaviorRecording1_dFF_4;
dataReaching.Reaching5 =BehaviorRecording1_dFF_5;

%Find the max and min across all trails of all behavior till you have one
%value for each animal for all the bahavior

fn = fieldnames(dataReaching);%dataReaching
for k=1:numel(fn)
        for i = 1: size(dataReaching.(fn{k}),2)
            Minimum_dFF = min(dataReaching.(fn{k}));
            Maximum_dFF = max(dataReaching.(fn{k}));
        end
   Minimum_Reaching{k} = Minimum_dFF;
   Maximum_Reaching{k} = Maximum_dFF;
end

fn = fieldnames(dataOF);%dataOF 
for k=1:numel(fn)
        for i = 1: size(dataOF.(fn{k}),2)
            Minimum_dFF = min(dataOF.(fn{k}));
            Maximum_dFF = max(dataOF.(fn{k}));
        end
   Minimum_OF{k} = Minimum_dFF;
   Maximum_OF{k} = Maximum_dFF;
end

fn = fieldnames(dataRandom);% dataRandom
for k=1:numel(fn)
        for i = 1: size(dataRandom.(fn{k}),2)
            Minimum_dFF = min(dataRandom.(fn{k}));
            Maximum_dFF = max(dataRandom.(fn{k}));
        end
   Minimum_Random{k} = Minimum_dFF;
   Maximum_Random{k} = Maximum_dFF;
end

MeanMaxReaching = cellfun(@mean,Maximum_Reaching,'Un',1)
MeanMinReaching = cellfun(@mean,Minimum_Reaching,'Un',1)
MeanMaxRandom = cellfun(@mean,Maximum_Random,'Un',1)
MeanMinRandom = cellfun(@mean,Minimum_Random,'Un',1)
MeanMaxOF = cellfun(@mean,Maximum_OF,'Un',1)
MeanMinOF = cellfun(@mean,Minimum_OF,'Un',1)

% 
MeanMaxReaching = cellfun(@mean,Maximum_Reaching,'Un',0)
MeanMinReaching = cellfun(@mean,Minimum_Reaching,'Un',0)
MeanMaxRandom = cellfun(@mean,Maximum_Random,'Un',0)
MeanMinRandom = cellfun(@mean,Minimum_Random,'Un',0)
MeanMaxOF = cellfun(@mean,Maximum_OF,'Un',0)
MeanMinOF = cellfun(@mean,Minimum_OF,'Un',0)

MeanMaxOF(1)=[] %delete MdD animal2 OF

%when you need to delete one element
AbsMinimum = min(cell2mat([MeanMinOF, MeanMinReaching, MeanMinRandom]))
AbsMaximum = min(cell2mat([MeanMaxOF, MeanMaxReaching, MeanMaxRandom]))


AbsMinimum = min(vertcat(MeanMinReaching, MeanMinRandom, MeanMinOF ))
AbsMaximum = max(vertcat(MeanMaxReaching, MeanMaxRandom, MeanMaxOF ))

%find the mean (Minimum) and mean (Maximum)



%Normaliza data Reaching
fn = fieldnames(dataReaching);
for ii = 1 : numel(fn);
    for kk = 1: size(dataReaching.(fn{ii}),2); 
       RelativeTrace_dFF_Reaching_all{ii}(:,kk) = (dataReaching.(fn{ii})(:,kk)-AbsMinimum(ii))/(AbsMaximum(ii)-AbsMinimum(ii));
    end
end


 
%Normalize data OF  
fn = fieldnames(dataOF);
 for ii = 1 :  numel(fn);
    for kk = 1: size(dataOF.(fn{ii}),2) 
       RelativeTrace_dFF_OF_all {ii}(:,kk)= (dataOF.(fn{ii})(:,kk)-AbsMinimum(ii))/(AbsMaximum(ii)-AbsMinimum(ii));
    end
end
   
 
 
 %Normalize data Random
fn = fieldnames(dataRandom);    
 for ii = 1 :  numel(fn);   
    for kk = 1: size(dataRandom.(fn{ii}),2) 
       RelativeTrace_dFF_Random_all {ii}(:,kk)= (dataRandom.(fn{ii})(:,kk)-AbsMinimum(ii))/(AbsMaximum(ii)-AbsMinimum(ii));
    end
 end


%plot figure of the signal as relative from 0 to 1 dF/F signal of all
%animals together
figure (1)
hold on
for j = 1: length(RelativeTrace_dFF_Reaching_all)
    %shadedErrorBar(xCoordinates,mean(RelativeTrace_dFF_Reaching_all{j},2), std(RelativeTrace_dFF_Reaching_all{j},0,2)/sqrt(size(RelativeTrace_dFF_Reaching_all{j},2)),'k',1)
    plot(xCoordinates,mean(RelativeTrace_dFF_Reaching_all{j},2),'k')
    axis([-WindowBefore WindowAfter 0.1 0.9])
  
end

hold on
for j = 1: length(RelativeTrace_dFF_OF_all)
    %shadedErrorBar(xCoordinates,mean(RelativeTrace_dFF_OF_all{j},2), std(RelativeTrace_dFF_OF_all{j},0,2)/sqrt(size(RelativeTrace_dFF_OF_all{j},2)),'k',1)
    plot(xCoordinates,mean(RelativeTrace_dFF_OF_all{j},2),'m')
    axis([-WindowBefore WindowAfter 0.1 0.9])
end

hold on
for j = 1: length(RelativeTrace_dFF_Random_all)
    %shadedErrorBar(xCoordinates,mean(RelativeTrace_dFF_Random_all{j},2), std(RelativeTrace_dFF_Random_all{j},0,2)/sqrt(size(RelativeTrace_dFF_Random_all{j},2)),'k',1)
    plot(xCoordinates,mean(RelativeTrace_dFF_Random_all{j},2),'b')
    axis([-WindowBefore WindowAfter 0.1 0.9 ])
end

title('PCRT MdD Photometry animal 0 2 4 5 (Reaching g)(OF m)(Random b))')

figure (2)
%mean of animals pooled and error bar

MeanRelativeTrace_Reaching_allAnimals = mean(cell2mat(cellfun(@(x) mean(x, 2), RelativeTrace_dFF_Reaching_all, 'Un', 0)),2);
MeanRelativeTrace_Reaching_allAnimalsStE = std(cell2mat(cellfun(@(x) mean(x, 2), RelativeTrace_dFF_Reaching_all, 'Un', 0)),[], 2)/sqrt(length(RelativeTrace_dFF_Reaching_all));
MeanRelativeTrace_OF_allAnimals = mean(cell2mat(cellfun(@(x) mean(x, 2), RelativeTrace_dFF_OF_all, 'Un', 0)),2);
MeanRelativeTrace_OF_allAnimalsStE = std(cell2mat(cellfun(@(x) mean(x, 2), RelativeTrace_dFF_OF_all, 'Un', 0)),[], 2)/sqrt(length(RelativeTrace_dFF_OF_all));
MeanRelativeTrace_Random_allAnimals = mean(cell2mat(cellfun(@(x) mean(x, 2), RelativeTrace_dFF_Random_all, 'Un', 0)),2);
MeanRelativeTrace_Random_allAnimalsStE = std(cell2mat(cellfun(@(x) mean(x, 2), RelativeTrace_dFF_Random_all, 'Un', 0)),[], 2)/sqrt(length(RelativeTrace_dFF_Random_all));




hold on
shadedErrorBar(xCoordinates, MeanRelativeTrace_Reaching_allAnimals, MeanRelativeTrace_Reaching_allAnimalsStE, 'g')
shadedErrorBar(xCoordinates, MeanRelativeTrace_OF_allAnimals, MeanRelativeTrace_OF_allAnimalsStE, 'm')
shadedErrorBar(xCoordinates, MeanRelativeTrace_Random_allAnimals, MeanRelativeTrace_Random_allAnimalsStE, 'b')




projectdir = ('Y:\User\temp\PCRT_retro_Photometry\pulledDays\3.PulledDays_animal2NoOF')
for i=1:2
 saveas(figure(i),fullfile(projectdir,['figure' num2str(i) '.fig']));
end
close all







