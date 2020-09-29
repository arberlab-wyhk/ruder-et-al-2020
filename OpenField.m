function [LocomotorParametersMeans, LocomotorParameters, speed] = OpenField(FrameRate, FrameDef, AcTime, TrackTableUse, CalibrationCam, savingFile)
%This function extracts a number of different locomotor parameters from
%an open field experiment by cutting the the extracted trajectories into 
%defined locomotor episodes / bouts.Parameters assessed are maximum speed, 
%maximum speed (highest 5), Stability / Curvature, Time of a locomotor 
%bout, Time the animal is moving, Tracklength, Distance of a locomotor 
%bout.
% Inputs: A (data), FrameRate (acquired Frequency in frames/sec), FrameDef 
%(How long should one locomotor be at the minimum in frames/sec?), AcTime 
%(How long should the analyzed time window be?) 
%Outputs: LocomotorParameters (averages or values for the described
%locomotor parameters)

if TrackTableUse == 1
    [fileName, filePath] = uigetfile('*');
    load(fileName);
    A = table2array(TrackTable);
else
    [fileName, ~] = uigetfile('*');
    A = xlsread(fileName);
end


%data import and concatenating to a common size
FramesRec = AcTime * 60*FrameRate;
A(FramesRec+1:length(A),:) = [];

%extraction, smoothing & calculation of speed trajectory
if TrackTableUse == 1
    x = smooth(A(:,1), 10)*CalibrationCam;
    y = smooth(A(:,2), 10)*CalibrationCam;
else
    x = smooth(A(:,4), 10);
    y = smooth(A(:,5), 10);
end
xx = (diff(x)).^2;
yy = (diff(y)).^2;
speed = sqrt(xx + yy)*FrameRate;

%Extraction of locomotor bouts according to speed and time constants
NonRunningEpisodes = find(speed<5);
speed(NonRunningEpisodes)=0;                                                         
id = cumsum(speed==0)+1;                  
mask = speed > 0;          
%make an array with all locomotor bouts & extract more than 200ms
out = accumarray(id(mask),speed(mask),[],@(x) {x});
out = out(~cellfun('isempty',out));
out = out(cellfun(@sum,out)>0);
out = out(cellfun(@length, out)>= FrameDef);
LocomotorBouts = out(cellfun(@length,out)>= FrameDef);

%Extract x-y coordinates of locomotor bouts
out_2 = accumarray(id(mask),x(mask),[],@(x) {x});
out_3 = accumarray(id(mask),y(mask),[],@(x) {x});
out_2 = out_2(~cellfun('isempty',out_2));
out_3 = out_3(~cellfun('isempty',out_3));
out_2 = out_2(cellfun(@sum, out_2)>0);
out_3 = out_3(cellfun(@sum, out_3)>0);
out_2 = out_2(cellfun(@length, out_2)>= FrameDef);
out_3 = out_3(cellfun(@length, out_3)>= FrameDef);
out_2 = cellfun(@(x) x - x(1), out_2, 'Un', 0);
out_3 = cellfun(@(x) x - x(1), out_3, 'Un', 0);
LocomotorBoutsXY = cellfun(@(x,y)[x y], out_2, out_3,'Un',0);

%Calculations for Stability / Curvature
Curvature1 = cellfun(@(x) x(1:end-2,:), LocomotorBoutsXY, 'Un', 0);
Curvature2 = cellfun(@(x) x(2:end-1,:), LocomotorBoutsXY, 'Un', 0);
Curvature3 = cellfun(@(x) x(3:end,:), LocomotorBoutsXY, 'Un', 0);

det_1 = cellfun(@(x,y) [x(:,1) x(:,2)] - [y(:,1) y(:,2)], Curvature1,Curvature2, 'Un',0);
det_2 = cellfun(@(x,y) [x(:,1) x(:,2)] - [y(:,1) y(:,2)], Curvature3,Curvature2, 'Un',0);
det_3 = cellfun(@(x) num2cell(x,2),det_1, 'Un', 0);
det_4 = cellfun(@(x) num2cell(x,2),det_2, 'Un', 0);
det_5 = cellfun(@(x,y) cellfun(@(a,b) abs(det([a;b])), x,y, 'Un', 0), det_3,det_4, 'Un', 0);
det_6 = cellfun(@(x) cell2mat(x), det_5, 'Un', 0);

dot_1 = cellfun(@(x,y) cellfun(@(a,b) dot(a,b), x,y, 'Un', 0), det_3,det_4, 'Un', 0);
dot_2 = cellfun(@(x) cell2mat(x), dot_1, 'Un', 0);

angle_1 = cellfun(@(x,y) atan2(x, y), det_6, dot_2, 'Un', 0);
angle_2 = cellfun(@(x) x*(180/pi), angle_1, 'Un', 0);

%Calculations and metrics of locomotor bouts
Curvature = mean(cell2mat(cellfun(@(x) std(x), angle_2, 'Un', 0)));
maxSpeed2 = sort(cell2mat(cellfun(@(x)max(x),out, 'Un',0)), 'descend');
maxSpeed = mean(maxSpeed2);
maxSpeed5 = mean(maxSpeed2(1:5));
Speed5 = LocomotorBouts(ismember(cell2mat(cellfun(@(x)max(x),LocomotorBouts, 'Un',0)), maxSpeed2(1:5)));
timeLocomotorBout = mean(cellfun(@length, LocomotorBouts))/FrameRate;
timeLocomoting = sum(cellfun(@length, LocomotorBouts))/FramesRec;
tracklength = sum(sqrt(xx + yy));
distance = mean(cell2mat(cellfun(@(x)sum(x/FrameRate),LocomotorBouts, 'Un',0)));
LocomotorParametersMeans = table(maxSpeed, maxSpeed5, Curvature, timeLocomotorBout, timeLocomoting, tracklength, distance);

NameFields = {'Maximum_Speed', 'Maximum_Speed_Top5', 'Curvature', 'Time_Locomotor_Bouts', 'Time_in_Locomotion', 'Tracklength', 'Distance'};
LocomotorParameters = struct(NameFields{1}, maxSpeed2, NameFields{2}, maxSpeed2(1:5),...
    NameFields{3}, cell2mat(cellfun(@(x) std(x), angle_2, 'Un', 0)), NameFields{4}, cellfun(@length, LocomotorBouts)/FrameRate,...
    NameFields{5}, timeLocomoting, NameFields{6}, tracklength, NameFields{7},cell2mat(cellfun(@(x)sum(x/FrameRate),LocomotorBouts, 'Un',0)));


%saving
if savingFile == 1
    save(strcat(filePath, 'ResultsOpenFieldParameters'), 'LocomotorParameters', 'LocomotorParametersMeans', 'speed')
end


%Plotting
figure
subplot(3,2,1)
plot(x,y);
title('open field track')
subplot(3,2,2)
edgesSpeed = 5:5:30;
histogram(maxSpeed2, edgesSpeed, 'Normalization', 'probability')
title('speed distribution')
xlabel ('cm/s')
subplot(3,2,3)
edgesTime = 0.2:0.3:2;
histogram((cellfun(@length, LocomotorBouts)/100), edgesTime, 'Normalization', 'probability');
title('length running events')
xlabel('seconds')
subplot(3,2,4)
circle([0 0],distance,1000);
hold on;
cellfun(@(x,y)plot(x,y), out_2, out_3 ,'Un',0);
axis([-30 30 -30 30])
subplot(3,2,5:6)
hold on
cellfun(@(x)plot(x,'k'),Speed5, 'Un',0);