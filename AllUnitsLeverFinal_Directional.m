function Results = AllUnitsLeverFinal_Directional(Before, After, BinSize, Alignment, FreqCutOff, TimesStd, Plotting, LoadingSelect)

% load fileName Matlab structure that follows the following organization:
% Animals --> Sessions --> Behaviors --> individual Spike Times +
% Behaviors

if LoadingSelect == 1
    [fileName, ~] = uigetfile('*.mat');
    load(fileName)
else
    load('Directional_ALL_ANIMALS_GOOD_SITE_correctedNeurons.mat')
end

%create matrices that will be filled with binned frequency values
%surrounded around your behavior of interest

HistogramAllUnitsReachLateral = [];
HistogramAllUnitsMeanSubtractedReachLateral = [];
HistogramAllUnitsMeanSubtractedReachSingleLateral = {};
AllUnitsReachSingleTimepointsLateral = {};
HistogramAllUnitsStdReachLateral = [];
HistogramAllUnitsLowReachLateral = [];

HistogramAllUnitsReachMedial = [];
HistogramAllUnitsMeanSubtractedReachMedial = [];
HistogramAllUnitsMeanSubtractedReachSingleMedial = {};
AllUnitsReachSingleTimepointsMedial = {};
HistogramAllUnitsStdReachMedial = [];
HistogramAllUnitsLowReachMedial = [];

HistogramAllUnitsReach = [];
HistogramAllUnitsMeanSubtractedReach = [];
HistogramAllUnitsMeanSubtractedReachSingle = {};
AllUnitsReachSingleTimepoints = {};
HistogramAllUnitsStdReach = [];
HistogramAllUnitsLowReach = [];

HistogramAllUnitsReachRand = [];
HistogramAllUnitsMeanSubtractedReachRand = [];
HistogramAllUnitsMeanSubtractedReachRandSingle = {};
AllUnitsReachSingleTimepointsRand = {};
HistogramAllUnitsStdReachRand = [];
HistogramAllUnitsLowReachRand = [];

HistogramAllUnitsSpaghetti = [];
HistogramAllUnitsMeanSubtractedSpaghetti = [];
HistogramAllUnitsMeanSubtractedSpaghettiSingle = {};
HistogramAllUnitsStdSpaghetti = [];
HistogramAllUnitsLowSpaghetti = [];

HistogramAllUnitsSpaghettiRand = [];
HistogramAllUnitsMeanSubtractedSpaghettiRand = [];
HistogramAllUnitsMeanSubtractedSpaghettiSingleRand = {};
HistogramAllUnitsStdSpaghettiRand = [];
HistogramAllUnitsLowSpaghettiRand = [];

% HistogramAllUnitsOpen = [];
% HistogramAllUnitsMeanSubtractedOpen = [];
% HistogramAllUnitsMeanSubtractedOpenSingle = {};
% HistogramAllUnitsStdOpen = [];
% HistogramAllUnitsLowOpen = [];
% 
% HistogramAllUnitsOpenRand = [];
% HistogramAllUnitsMeanSubtractedOpenRand = [];
% HistogramAllUnitsMeanSubtractedOpenRandSingle = {};
% HistogramAllUnitsStdOpenRand = [];
% HistogramAllUnitsLowOpenRand = [];

ReachSpikeNamesAllLateral = {};
ReachSpikeNamesAllMedial = {};
ReachSpikeNamesAll = {};
% OpenSpikeNamesAll = {};
SpaghettiSpikeNamesAll = {};
LengthBehaviorReachAllLateral = {};
LengthBehaviorReachAllMedial = {};
LengthBehaviorReachAll = {};
% LengthBehaviorOpenAll = {};
LengthBehaviorSpaghettiAll = {};

% loop through all animals, all sessions, and all behaviors to execute all
% possible analysis of lever pressing, pellet reaching, open field and
% random behavior assignment
for i = 1:length(fieldnames(PCRt_recordings))
    Animals = fieldnames(PCRt_recordings);
    Animal1 = cell2mat(Animals(i));
    for ii = 1:length(fieldnames(PCRt_recordings.(Animal1)))
        Sessions = fieldnames(PCRt_recordings.(Animal1));
        Session1 = cell2mat(Sessions(ii));
        if isempty(PCRt_recordings.(Animal1).(Session1))
            continue
        end
        for iii = 1:length(fieldnames(PCRt_recordings.(Animal1).(Session1)))
            Behaviors = fieldnames(PCRt_recordings.(Animal1).(Session1));
            Behavior1 = cell2mat(Behaviors(iii));
%             elseif strcmp(Behavior1, 'OpenField')
%                 data = PCRt_recordings.(Animal1).(Session1).(Behavior1);
%                 %execute the scripts to analyze Open Field Locomotion events
%                 %for values specified in data
%                 [OpenHist, OpenHistMeanSubtracted, OpenHistMeanSubtractedSingle, OpenHistBaselineStd, OpenSpikeNames, SignificanceHelpOpen, LengthBehaviorOpen] = FiringPlotOpenHist(data,Before, After, BinSize, 200, 40, 50);
%                 [OpenHistRand, OpenHistRandMeanSubtracted, OpenHistRandMeanSubtractedSingle, OpenHistRandBaselineStd, OpenRandSpikeNames, SignificanceHelpOpenRand] = FiringPlotOpenHistRand(data,Before, After, BinSize, 200, 40, 50);
%                 if ~isempty(OpenHist)
%                     HistogramAllUnitsMeanSubtractedOpenSingle{[size(HistogramAllUnitsMeanSubtractedOpenSingle,2)+1]} = OpenHistMeanSubtractedSingle;
%                     HistogramAllUnitsMeanSubtractedOpenRandSingle{[size(HistogramAllUnitsMeanSubtractedOpenRandSingle,2)+1]} = OpenHistRandMeanSubtractedSingle;
%                     LengthBehaviorOpenAll{[size(LengthBehaviorOpenAll,2)+1]} = LengthBehaviorOpen; 
%                     if isempty(HistogramAllUnitsOpen)
%                         HistogramAllUnitsOpen([size(HistogramAllUnitsOpen,1)+1:size(OpenHist,1)],:) = OpenHist;
%                         HistogramAllUnitsOpenRand([size(HistogramAllUnitsOpenRand,1)+1:size(OpenHistRand,1)],:) = OpenHistRand;
%                         HistogramAllUnitsMeanSubtractedOpen([size(HistogramAllUnitsMeanSubtractedOpen,1)+1:size(OpenHistMeanSubtracted,1)],:) = OpenHistMeanSubtracted;
%                         HistogramAllUnitsMeanSubtractedOpenRand([size(HistogramAllUnitsMeanSubtractedOpenRand,1)+1:size(OpenHistRandMeanSubtracted,1)],:) = OpenHistRandMeanSubtracted;
%                         HistogramAllUnitsStdOpen([length(HistogramAllUnitsStdOpen)+1:length(OpenHistBaselineStd)]) = OpenHistBaselineStd';
%                         HistogramAllUnitsStdOpenRand([length(HistogramAllUnitsStdOpenRand)+1:length(OpenHistRandBaselineStd)]) = OpenHistRandBaselineStd';
%                         HistogramAllUnitsLowOpen([length(HistogramAllUnitsLowOpen)+1:length(SignificanceHelpOpen)]) = SignificanceHelpOpen';
%                         HistogramAllUnitsLowOpenRand([length(HistogramAllUnitsLowOpenRand)+1:length(SignificanceHelpOpenRand)]) = SignificanceHelpOpenRand';
%                         for kkk = 1:length(OpenSpikeNames)
%                             OpenSpikeNamesAll{length(OpenSpikeNames(1:kkk)),1} = Animal1;
%                             OpenSpikeNamesAll{length(OpenSpikeNames(1:kkk)),2} = Session1;
%                             OpenSpikeNamesAll{length(OpenSpikeNames(1:kkk)),3} = OpenSpikeNames{kkk};
%                         end
%                     else
%                         HistogramAllUnitsOpen([size(HistogramAllUnitsOpen,1)+1:(size(HistogramAllUnitsOpen,1))+size(OpenHist,1)],:) = OpenHist;
%                         HistogramAllUnitsOpenRand([size(HistogramAllUnitsOpenRand,1)+1:(size(HistogramAllUnitsOpenRand,1))+size(OpenHistRand,1)],:) = OpenHistRand;
%                         HistogramAllUnitsMeanSubtractedOpen([size(HistogramAllUnitsMeanSubtractedOpen,1)+1:(size(HistogramAllUnitsMeanSubtractedOpen,1))+size(OpenHistMeanSubtracted,1)],:) = OpenHistMeanSubtracted;
%                         HistogramAllUnitsMeanSubtractedOpenRand([size(HistogramAllUnitsMeanSubtractedOpenRand,1)+1:(size(HistogramAllUnitsMeanSubtractedOpenRand,1))+size(OpenHistRandMeanSubtracted,1)],:) = OpenHistRandMeanSubtracted;
%                         HistogramAllUnitsStdOpen([length(HistogramAllUnitsStdOpen)+1:(length(HistogramAllUnitsStdOpen))+length(OpenHistBaselineStd)]) = OpenHistBaselineStd';
%                         HistogramAllUnitsStdOpenRand([length(HistogramAllUnitsStdOpenRand)+1:(length(HistogramAllUnitsStdOpenRand))+length(OpenHistRandBaselineStd)]) = OpenHistRandBaselineStd';
%                         HistogramAllUnitsLowOpen([length(HistogramAllUnitsLowOpen)+1:(length(HistogramAllUnitsLowOpen))+length(SignificanceHelpOpen)]) = SignificanceHelpOpen';
%                         HistogramAllUnitsLowOpenRand([length(HistogramAllUnitsLowOpenRand)+1:(length(HistogramAllUnitsLowOpenRand))+length(SignificanceHelpOpenRand)]) = SignificanceHelpOpenRand';
%                         LengthSpikeNames = length(OpenSpikeNamesAll);
%                         for kkk = 1:length(OpenSpikeNames)
%                             OpenSpikeNamesAll{LengthSpikeNames+length(OpenSpikeNamesAll(1:kkk)),1} = Animal1;
%                             OpenSpikeNamesAll{LengthSpikeNames+length(OpenSpikeNamesAll(1:kkk)),2} = Session1;
%                             OpenSpikeNamesAll{LengthSpikeNames+length(OpenSpikeNamesAll(1:kkk)),3} = OpenSpikeNames{kkk};
%                         end
%                     end
%                 else
%                     continue
%                 end
            if strcmp(Behavior1, 'PelletReachingS')
                data = PCRt_recordings.(Animal1).(Session1).(Behavior1);
                if ~isempty(data)
                    % execute the script to analyze Pellet Reaching events
                    % for values specified in data
                    if isfield(data, 'ReachingStartLateral')
                        if length(data.ReachingStartLateral) > 3
                            [ReachHistLateral, ReachHistMeanSubtractedLateral, ReachHistMeanSubtractedSingleLateral, ReachHistBaselineStdLateral, ReachSpikeNamesLateral, SignificanceHelpReachLateral, LengthBehaviorReachLateral, BehaviorSpikesNormLateral] = FiringPlotReachHistLateral(data,Before, After, BinSize, Alignment);
                        end
                    end
                    if isfield(data, 'ReachingStartMedial')
                        if length(data.ReachingStartMedial) > 3
                            [ReachHistMedial, ReachHistMeanSubtractedMedial, ReachHistMeanSubtractedSingleMedial, ReachHistBaselineStdMedial, ReachSpikeNamesMedial, SignificanceHelpReachMedial, LengthBehaviorReachMedial, BehaviorSpikesNormMedial] = FiringPlotReachHistMedial(data,Before, After, BinSize, Alignment);
                        end
                    end
                    [ReachHistRand, ReachHistRandMeanSubtracted, ReachHistRandMeanSubtractedSingle, ReachHistRandBaselineStd, ReachRandSpikeNames, SignificanceHelpReachRand, BehaviorSpikesNormRand] = FiringPlotReachHistRand(data,Before, After, BinSize);
                    [ReachHist, ReachHistMeanSubtracted, ReachHistMeanSubtractedSingle, ReachHistBaselineStd, ReachSpikeNames, SignificanceHelpReach, LengthBehaviorReach, BehaviorSpikesNorm] =  FiringPlotReachHistLateral(data, Before, After, BinSize, Alignment);
                    if isfield(data, 'SpaghettiHandsOn')
                        [SpaghettiHist, SpaghettiHistMeanSubtracted, SpaghettiHistMeanSubtractedSingle, SpaghettiHistBaselineStd, SpaghettiSpikeNames, SignificanceHelpSpaghetti, LengthBehaviorSpaghetti] =  FiringPlotSpaghettiHist(data, Before, After, BinSize);
                        [SpaghettiHistRand, SpaghettiHistMeanSubtractedRand, SpaghettiHistMeanSubtractedSingleRand, SpaghettiHistBaselineStdRand, SpaghettiSpikeNamesRand, SignificanceHelpSpaghettiRand, LengthBehaviorSpaghettiRand] =  FiringPlotSpaghettiHistRand(data, Before, After, BinSize);
                    elseif isfield(data, 'EatOn')
                        [SpaghettiHist, SpaghettiHistMeanSubtracted, SpaghettiHistMeanSubtractedSingle, SpaghettiHistBaselineStd, SpaghettiSpikeNames, SignificanceHelpSpaghetti, LengthBehaviorSpaghetti] =  FiringPlotSpaghettiHist(data, Before, After, BinSize);
                        [SpaghettiHistRand, SpaghettiHistMeanSubtractedRand, SpaghettiHistMeanSubtractedSingleRand, SpaghettiHistBaselineStdRand, SpaghettiSpikeNamesRand, SignificanceHelpSpaghettiRand, LengthBehaviorSpaghettiRand] =  FiringPlotSpaghettiHistRand(data, Before, After, BinSize);
                    end
                    if ~isempty(ReachHist)
                        if isfield(data, 'ReachingStartLateral')
                            if length(data.ReachingStartLateral) > 3
                                HistogramAllUnitsMeanSubtractedReachSingleLateral{[size(HistogramAllUnitsMeanSubtractedReachSingleLateral,2)+1]} = ReachHistMeanSubtractedSingleLateral;
                                AllUnitsReachSingleTimepointsLateral{[size(AllUnitsReachSingleTimepointsLateral,2)+1]} = BehaviorSpikesNormLateral;
                                LengthBehaviorReachAllLateral{[size(LengthBehaviorReachAllLateral,2)+1]} = LengthBehaviorReachLateral;
                            end
                        end
                        if isfield(data, 'ReachingStartMedial')
                            if length(data.ReachingStartMedial) > 3
                                HistogramAllUnitsMeanSubtractedReachSingleMedial{[size(HistogramAllUnitsMeanSubtractedReachSingleMedial,2)+1]} = ReachHistMeanSubtractedSingleMedial;
                                AllUnitsReachSingleTimepointsMedial{[size(AllUnitsReachSingleTimepointsMedial,2)+1]} = BehaviorSpikesNormMedial;
                                LengthBehaviorReachAllMedial{[size(LengthBehaviorReachAllMedial,2)+1]} = LengthBehaviorReachMedial;
                            end
                        end
                        HistogramAllUnitsMeanSubtractedReachSingle{[size(HistogramAllUnitsMeanSubtractedReachSingle,2)+1]} = ReachHistMeanSubtractedSingle;
                        AllUnitsReachSingleTimepoints{[size(AllUnitsReachSingleTimepoints,2)+1]} = BehaviorSpikesNorm;
                        HistogramAllUnitsMeanSubtractedReachRandSingle{[size(HistogramAllUnitsMeanSubtractedReachRandSingle,2)+1]} = ReachHistRandMeanSubtractedSingle;
                        AllUnitsReachSingleTimepointsRand{[size(AllUnitsReachSingleTimepointsRand,2)+1]} = BehaviorSpikesNormRand; 
                        LengthBehaviorReachAll{[size(LengthBehaviorReachAll,2)+1]} = LengthBehaviorReach; 
                        if isempty(HistogramAllUnitsReach)
                            if isfield(data, 'ReachingStartLateral')
                                if length(data.ReachingStartLateral) > 3
                                    HistogramAllUnitsReachLateral([size(HistogramAllUnitsReachLateral,1)+1:size(ReachHistLateral,1)],:) = ReachHistLateral;
                                    HistogramAllUnitsMeanSubtractedReachLateral([size(HistogramAllUnitsMeanSubtractedReachLateral,1)+1:size(ReachHistMeanSubtractedLateral,1)],:) = ReachHistMeanSubtractedLateral;
                                    HistogramAllUnitsStdReachLateral([length(HistogramAllUnitsStdReachLateral)+1:length(ReachHistBaselineStdLateral)]) = ReachHistBaselineStdLateral';
                                    HistogramAllUnitsLowReachLateral([length(HistogramAllUnitsLowReachLateral)+1:length(SignificanceHelpReachLateral)]) = SignificanceHelpReachLateral';
                                    for kkk = 1:length(ReachSpikeNamesLateral)
                                        ReachSpikeNamesAllLateral{length(ReachSpikeNamesLateral(1:kkk)),1} = Animal1;
                                        ReachSpikeNamesAllLateral{length(ReachSpikeNamesLateral(1:kkk)),2} = Session1;
                                        ReachSpikeNamesAllLateral{length(ReachSpikeNamesLateral(1:kkk)),3} = ReachSpikeNamesLateral{kkk};
                                    end
                                end
                            end
                            if isfield(data, 'ReachingStartMedial')
                                if length(data.ReachingStartMedial) > 3
                                    HistogramAllUnitsReachMedial([size(HistogramAllUnitsReachMedial,1)+1:size(ReachHistMedial,1)],:) = ReachHistMedial;
                                    HistogramAllUnitsMeanSubtractedReachMedial([size(HistogramAllUnitsMeanSubtractedReachMedial,1)+1:size(ReachHistMeanSubtractedMedial,1)],:) = ReachHistMeanSubtractedMedial;
                                    HistogramAllUnitsStdReachMedial([length(HistogramAllUnitsStdReachMedial)+1:length(ReachHistBaselineStdMedial)]) = ReachHistBaselineStdMedial';
                                    HistogramAllUnitsLowReachMedial([length(HistogramAllUnitsLowReachMedial)+1:length(SignificanceHelpReachMedial)]) = SignificanceHelpReachMedial';
                                    for kkk = 1:length(ReachSpikeNamesMedial)
                                        ReachSpikeNamesAllMedial{length(ReachSpikeNamesMedial(1:kkk)),1} = Animal1;
                                        ReachSpikeNamesAllMedial{length(ReachSpikeNamesMedial(1:kkk)),2} = Session1;
                                        ReachSpikeNamesAllMedial{length(ReachSpikeNamesMedial(1:kkk)),3} = ReachSpikeNamesMedial{kkk};
                                    end
                                end
                            end
                            HistogramAllUnitsReach([size(HistogramAllUnitsReach,1)+1:size(ReachHist,1)],:) = ReachHist;
                            HistogramAllUnitsReachRand([size(HistogramAllUnitsReachRand,1)+1:size(ReachHistRand,1)],:) = ReachHistRand;
                            HistogramAllUnitsMeanSubtractedReach([size(HistogramAllUnitsMeanSubtractedReach,1)+1:size(ReachHistMeanSubtracted,1)],:) = ReachHistMeanSubtracted;
                            HistogramAllUnitsMeanSubtractedReachRand([size(HistogramAllUnitsMeanSubtractedReachRand,1)+1:size(ReachHistRandMeanSubtracted,1)],:) = ReachHistRandMeanSubtracted;
                            HistogramAllUnitsStdReach([length(HistogramAllUnitsStdReach)+1:length(ReachHistBaselineStd)]) = ReachHistBaselineStd';
                            HistogramAllUnitsStdReachRand([length(HistogramAllUnitsStdReachRand)+1:length(ReachHistRandBaselineStd)]) = ReachHistRandBaselineStd';
                            HistogramAllUnitsLowReach([length(HistogramAllUnitsLowReach)+1:length(SignificanceHelpReach)]) = SignificanceHelpReach';
                            HistogramAllUnitsLowReachRand([length(HistogramAllUnitsLowReachRand)+1:length(SignificanceHelpReachRand)]) = SignificanceHelpReachRand';
                            for kkk = 1:length(ReachSpikeNames)
                                ReachSpikeNamesAll{length(ReachSpikeNames(1:kkk)),1} = Animal1;
                                ReachSpikeNamesAll{length(ReachSpikeNames(1:kkk)),2} = Session1;
                                ReachSpikeNamesAll{length(ReachSpikeNames(1:kkk)),3} = ReachSpikeNames{kkk};
                            end
                        else
                            if isfield(data, 'ReachingStartLateral')
                                if length(data.ReachingStartLateral) > 3
                                    HistogramAllUnitsReachLateral([size(HistogramAllUnitsReachLateral,1)+1:(size(HistogramAllUnitsReachLateral,1))+size(ReachHistLateral,1)],:) = ReachHistLateral;
                                    HistogramAllUnitsMeanSubtractedReachLateral([size(HistogramAllUnitsMeanSubtractedReachLateral,1)+1:(size(HistogramAllUnitsMeanSubtractedReachLateral,1))+size(ReachHistMeanSubtractedLateral,1)],:) = ReachHistMeanSubtractedLateral;
                                    HistogramAllUnitsStdReachLateral([length(HistogramAllUnitsStdReachLateral)+1:(length(HistogramAllUnitsStdReachLateral))+length(ReachHistBaselineStdLateral)]) = ReachHistBaselineStdLateral';
                                    HistogramAllUnitsLowReachLateral([length(HistogramAllUnitsLowReachLateral)+1:(length(HistogramAllUnitsLowReachLateral))+length(SignificanceHelpReachLateral)]) = SignificanceHelpReachLateral';
                                    ReachLengthSpikeNamesLateral = length(ReachSpikeNamesAllLateral);
                                    for kkk = 1:length(ReachSpikeNamesLateral)
                                        ReachSpikeNamesAllLateral{ReachLengthSpikeNamesLateral+length(ReachSpikeNamesLateral(1:kkk)),1} = Animal1;
                                        ReachSpikeNamesAllLateral{ReachLengthSpikeNamesLateral+length(ReachSpikeNamesLateral(1:kkk)),2} = Session1;
                                        ReachSpikeNamesAllLateral{ReachLengthSpikeNamesLateral+length(ReachSpikeNamesLateral(1:kkk)),3} = ReachSpikeNamesLateral{kkk};
                                    end
                                end
                            end
                            if isfield(data, 'ReachingStartMedial')
                                if length(data.ReachingStartMedial) > 3 
                                    HistogramAllUnitsReachMedial([size(HistogramAllUnitsReachMedial,1)+1:(size(HistogramAllUnitsReachMedial,1))+size(ReachHistMedial,1)],:) = ReachHistMedial;
                                    HistogramAllUnitsMeanSubtractedReachMedial([size(HistogramAllUnitsMeanSubtractedReachMedial,1)+1:(size(HistogramAllUnitsMeanSubtractedReachMedial,1))+size(ReachHistMeanSubtractedMedial,1)],:) = ReachHistMeanSubtractedMedial;
                                    HistogramAllUnitsStdReachMedial([length(HistogramAllUnitsStdReachMedial)+1:(length(HistogramAllUnitsStdReachMedial))+length(ReachHistBaselineStdMedial)]) = ReachHistBaselineStdMedial';
                                    HistogramAllUnitsLowReachMedial([length(HistogramAllUnitsLowReachMedial)+1:(length(HistogramAllUnitsLowReachMedial))+length(SignificanceHelpReachMedial)]) = SignificanceHelpReachMedial';
                                    ReachLengthSpikeNamesMedial = length(ReachSpikeNamesAllMedial);
                                    for kkk = 1:length(ReachSpikeNamesMedial)
                                        ReachSpikeNamesAllMedial{ReachLengthSpikeNamesMedial+length(ReachSpikeNamesMedial(1:kkk)),1} = Animal1;
                                        ReachSpikeNamesAllMedial{ReachLengthSpikeNamesMedial+length(ReachSpikeNamesMedial(1:kkk)),2} = Session1;
                                        ReachSpikeNamesAllMedial{ReachLengthSpikeNamesMedial+length(ReachSpikeNamesMedial(1:kkk)),3} = ReachSpikeNamesMedial{kkk};
                                    end
                                end
                            end
                            HistogramAllUnitsReach([size(HistogramAllUnitsReach,1)+1:(size(HistogramAllUnitsReach,1))+size(ReachHist,1)],:) = ReachHist;
                            HistogramAllUnitsReachRand([size(HistogramAllUnitsReachRand,1)+1:(size(HistogramAllUnitsReachRand,1))+size(ReachHistRand,1)],:) = ReachHistRand;
                            HistogramAllUnitsMeanSubtractedReach([size(HistogramAllUnitsMeanSubtractedReach,1)+1:(size(HistogramAllUnitsMeanSubtractedReach,1))+size(ReachHistMeanSubtracted,1)],:) = ReachHistMeanSubtracted;
                            HistogramAllUnitsMeanSubtractedReachRand([size(HistogramAllUnitsMeanSubtractedReachRand,1)+1:(size(HistogramAllUnitsMeanSubtractedReachRand,1))+size(ReachHistRandMeanSubtracted,1)],:) = ReachHistRandMeanSubtracted;
                            HistogramAllUnitsStdReach([length(HistogramAllUnitsStdReach)+1:(length(HistogramAllUnitsStdReach))+length(ReachHistBaselineStd)]) = ReachHistBaselineStd';
                            HistogramAllUnitsStdReachRand([length(HistogramAllUnitsStdReachRand)+1:(length(HistogramAllUnitsStdReachRand))+length(ReachHistRandBaselineStd)]) = ReachHistRandBaselineStd'; 
                            HistogramAllUnitsLowReach([length(HistogramAllUnitsLowReach)+1:(length(HistogramAllUnitsLowReach))+length(SignificanceHelpReach)]) = SignificanceHelpReach';
                            HistogramAllUnitsLowReachRand([length(HistogramAllUnitsLowReachRand)+1:(length(HistogramAllUnitsLowReachRand))+length(SignificanceHelpReachRand)]) = SignificanceHelpReachRand'; 
                            ReachLengthSpikeNames = length(ReachSpikeNamesAll); 
                            for kkk = 1:length(ReachSpikeNames)
                                ReachSpikeNamesAll{ReachLengthSpikeNames+length(ReachSpikeNames(1:kkk)),1} = Animal1;
                                ReachSpikeNamesAll{ReachLengthSpikeNames+length(ReachSpikeNames(1:kkk)),2} = Session1;
                                ReachSpikeNamesAll{ReachLengthSpikeNames+length(ReachSpikeNames(1:kkk)),3} = ReachSpikeNames{kkk};
                            end
                            
                        end
                    else
                        continue
                    end
                    if ~isempty(SpaghettiHist)
                        HistogramAllUnitsMeanSubtractedSpaghettiSingle{[size(HistogramAllUnitsMeanSubtractedSpaghettiSingle,2)+1]} = SpaghettiHistMeanSubtractedSingle;
                        HistogramAllUnitsMeanSubtractedSpaghettiSingleRand{[size(HistogramAllUnitsMeanSubtractedSpaghettiSingleRand,2)+1]} = SpaghettiHistMeanSubtractedSingleRand;
                        LengthBehaviorSpaghettiAll{[size(LengthBehaviorSpaghettiAll,2)+1]} = LengthBehaviorSpaghetti;
                        if isempty(HistogramAllUnitsSpaghetti)
                            HistogramAllUnitsSpaghetti([size(HistogramAllUnitsSpaghetti,1)+1:size(SpaghettiHist,1)],:) = SpaghettiHist;
                            HistogramAllUnitsSpaghettiRand([size(HistogramAllUnitsSpaghettiRand,1)+1:size(SpaghettiHistRand,1)],:) = SpaghettiHistRand;
                            HistogramAllUnitsMeanSubtractedSpaghetti([size(HistogramAllUnitsMeanSubtractedSpaghetti,1)+1:size(SpaghettiHistMeanSubtracted,1)],:) = SpaghettiHistMeanSubtracted;
                            HistogramAllUnitsMeanSubtractedSpaghettiRand([size(HistogramAllUnitsMeanSubtractedSpaghettiRand,1)+1:size(SpaghettiHistMeanSubtractedRand,1)],:) = SpaghettiHistMeanSubtractedRand;
                            HistogramAllUnitsStdSpaghetti([length(HistogramAllUnitsStdSpaghetti)+1:length(SpaghettiHistBaselineStd)]) = SpaghettiHistBaselineStd';
                            HistogramAllUnitsStdSpaghettiRand([length(HistogramAllUnitsStdSpaghettiRand)+1:length(SpaghettiHistBaselineStdRand)]) = SpaghettiHistBaselineStdRand';
                            HistogramAllUnitsLowSpaghetti([length(HistogramAllUnitsLowSpaghetti)+1:length(SignificanceHelpSpaghetti)]) = SignificanceHelpSpaghetti';
                            HistogramAllUnitsLowSpaghettiRand([length(HistogramAllUnitsLowSpaghettiRand)+1:length(SignificanceHelpSpaghettiRand)]) = SignificanceHelpSpaghettiRand';
                            for kkk = 1:length(SpaghettiSpikeNames)
                                SpaghettiSpikeNamesAll{length(SpaghettiSpikeNames(1:kkk)),1} = Animal1;
                                SpaghettiSpikeNamesAll{length(SpaghettiSpikeNames(1:kkk)),2} = Session1;
                                SpaghettiSpikeNamesAll{length(SpaghettiSpikeNames(1:kkk)),3} = SpaghettiSpikeNames{kkk};
                            end
                        else
                            HistogramAllUnitsSpaghetti([size(HistogramAllUnitsSpaghetti,1)+1:(size(HistogramAllUnitsSpaghetti,1))+size(SpaghettiHist,1)],:) = SpaghettiHist;
                            HistogramAllUnitsSpaghettiRand([size(HistogramAllUnitsSpaghettiRand,1)+1:(size(HistogramAllUnitsSpaghettiRand,1))+size(SpaghettiHistRand,1)],:) = SpaghettiHistRand;
                            HistogramAllUnitsMeanSubtractedSpaghetti([size(HistogramAllUnitsMeanSubtractedSpaghetti,1)+1:(size(HistogramAllUnitsMeanSubtractedSpaghetti,1))+size(SpaghettiHistMeanSubtracted,1)],:) = SpaghettiHistMeanSubtracted;
                            HistogramAllUnitsMeanSubtractedSpaghettiRand([size(HistogramAllUnitsMeanSubtractedSpaghettiRand,1)+1:(size(HistogramAllUnitsMeanSubtractedSpaghettiRand,1))+size(SpaghettiHistMeanSubtractedRand,1)],:) = SpaghettiHistMeanSubtractedRand;
                            HistogramAllUnitsStdSpaghetti([length(HistogramAllUnitsStdSpaghetti)+1:(length(HistogramAllUnitsStdSpaghetti))+length(SpaghettiHistBaselineStd)]) = SpaghettiHistBaselineStd';
                            HistogramAllUnitsStdSpaghettiRand([length(HistogramAllUnitsStdSpaghettiRand)+1:(length(HistogramAllUnitsStdSpaghettiRand))+length(SpaghettiHistBaselineStdRand)]) = SpaghettiHistBaselineStdRand';
                            HistogramAllUnitsLowSpaghetti([length(HistogramAllUnitsLowSpaghetti)+1:(length(HistogramAllUnitsLowSpaghetti))+length(SignificanceHelpSpaghetti)]) = SignificanceHelpSpaghetti';
                            HistogramAllUnitsLowSpaghettiRand([length(HistogramAllUnitsLowSpaghettiRand)+1:(length(HistogramAllUnitsLowSpaghettiRand))+length(SignificanceHelpSpaghettiRand)]) = SignificanceHelpSpaghettiRand';
                            SpaghettiLengthSpikeNames = length(SpaghettiSpikeNamesAll);
                            for kkk = 1:length(SpaghettiSpikeNames)
                                SpaghettiSpikeNamesAll{SpaghettiLengthSpikeNames+length(SpaghettiSpikeNames(1:kkk)),1} = Animal1;
                                SpaghettiSpikeNamesAll{SpaghettiLengthSpikeNames+length(SpaghettiSpikeNames(1:kkk)),2} = Session1;
                                SpaghettiSpikeNamesAll{SpaghettiLengthSpikeNames+length(SpaghettiSpikeNames(1:kkk)),3} = SpaghettiSpikeNames{kkk};
                            end
                            
                        end
                    else
                        continue
                    end
                end
            end
        end
    end
end

%you now should have matrices with all units ever recorded with a row
%length of your time from before until After and a column length of all
%your recorded units (this is called HistogramAllUnits...). Additionally
%you have the same matrix with mean subtracted values already as well as a
%matrix that gives you the average standard deviation in a baseline period
%of -7 until -2 seconds before the behavior event for every unit. 

%unpacking the single trials from their individual sessions


AllUnitsSingleReachLateral = {};
AllUnitsSingleReachTimepointsLateral = {};
AllUnitsSingleReachMedial = {};
AllUnitsSingleReachTimepointsMedial = {};
AllUnitsSingleReach = {};
AllUnitsSingleReachTimepoints = {};
AllUnitsSingleReachRand = {};
AllUnitsSingleReachTimepointsRand = {};
AllUnitsSingleSpaghetti = {};
AllUnitsSingleSpaghettiRand = {};
%AllUnitsSingleOpen = {};
%AllUnitsSingleOpenRand = {};
LengthBehaviorReachAllUnitsLateral = {};
LengthBehaviorReachAllUnitsMedial = {};
LengthBehaviorReachAllUnits = {};
LengthBehaviorSpaghettiAllUnits = {};
%LengthBehaviorOpenAllUnits = {};
%LengthBehaviorOpenRandAllUnits = {};


for ii = 1:length(HistogramAllUnitsMeanSubtractedReachSingleLateral)
    AllUnitsSingleReachLateral(size(AllUnitsSingleReachLateral,2)+1 : (size(HistogramAllUnitsMeanSubtractedReachSingleLateral{ii},2)+size(AllUnitsSingleReachLateral,2))) = HistogramAllUnitsMeanSubtractedReachSingleLateral{ii};
    AllUnitsSingleReachTimepointsLateral(size(AllUnitsSingleReachTimepointsLateral,2)+1 : (size(AllUnitsReachSingleTimepointsLateral{ii},2)+size(AllUnitsSingleReachTimepointsLateral,2))) = AllUnitsReachSingleTimepointsLateral{ii};
    LengthBehaviorReachAllUnitsLateral(size(LengthBehaviorReachAllUnitsLateral,2)+1 : (size(LengthBehaviorReachAllLateral{ii},2)+size(LengthBehaviorReachAllUnitsLateral,2))) = LengthBehaviorReachAllLateral{ii};
end

for ii = 1:length(HistogramAllUnitsMeanSubtractedReachSingleMedial)
    AllUnitsSingleReachMedial(size(AllUnitsSingleReachMedial,2)+1 : (size(HistogramAllUnitsMeanSubtractedReachSingleMedial{ii},2)+size(AllUnitsSingleReachMedial,2))) = HistogramAllUnitsMeanSubtractedReachSingleMedial{ii};
    AllUnitsSingleReachTimepointsMedial(size(AllUnitsSingleReachTimepointsMedial,2)+1 : (size(AllUnitsReachSingleTimepointsMedial{ii},2)+size(AllUnitsSingleReachTimepointsMedial,2))) = AllUnitsReachSingleTimepointsMedial{ii};
    LengthBehaviorReachAllUnitsMedial(size(LengthBehaviorReachAllUnitsMedial,2)+1 : (size(LengthBehaviorReachAllMedial{ii},2)+size(LengthBehaviorReachAllUnitsMedial,2))) = LengthBehaviorReachAllMedial{ii};
end

for ii = 1:length(HistogramAllUnitsMeanSubtractedReachSingle)
    AllUnitsSingleReach(size(AllUnitsSingleReach,2)+1 : (size(HistogramAllUnitsMeanSubtractedReachSingle{ii},2)+size(AllUnitsSingleReach,2))) = HistogramAllUnitsMeanSubtractedReachSingle{ii};
    AllUnitsSingleReachTimepoints(size(AllUnitsSingleReachTimepoints,2)+1 : (size(AllUnitsReachSingleTimepoints{ii},2)+size(AllUnitsSingleReachTimepoints,2))) = AllUnitsReachSingleTimepoints{ii};
    LengthBehaviorReachAllUnits(size(LengthBehaviorReachAllUnits,2)+1 : (size(LengthBehaviorReachAll{ii},2)+size(LengthBehaviorReachAllUnits,2))) = LengthBehaviorReachAll{ii};
end

for ii = 1:length(HistogramAllUnitsMeanSubtractedReachRandSingle)
    AllUnitsSingleReachRand(size(AllUnitsSingleReachRand,2)+1 : (size(HistogramAllUnitsMeanSubtractedReachRandSingle{ii},2)+size(AllUnitsSingleReachRand,2))) = HistogramAllUnitsMeanSubtractedReachRandSingle{ii};
    AllUnitsSingleReachTimepointsRand(size(AllUnitsSingleReachTimepointsRand,2)+1 : (size(AllUnitsReachSingleTimepointsRand{ii},2)+size(AllUnitsSingleReachTimepointsRand,2))) = AllUnitsReachSingleTimepointsRand{ii};
end

for ii = 1:length(HistogramAllUnitsMeanSubtractedSpaghettiSingle)
    AllUnitsSingleSpaghetti(size(AllUnitsSingleSpaghetti,2)+1 : (size(HistogramAllUnitsMeanSubtractedSpaghettiSingle{ii},2)+size(AllUnitsSingleSpaghetti,2))) = HistogramAllUnitsMeanSubtractedSpaghettiSingle{ii};
    LengthBehaviorSpaghettiAllUnits(size(LengthBehaviorSpaghettiAllUnits,2)+1 : (size(LengthBehaviorSpaghettiAll{ii},2)+size(LengthBehaviorSpaghettiAllUnits,2))) = LengthBehaviorSpaghettiAll{ii};
end

for ii = 1:length(HistogramAllUnitsMeanSubtractedSpaghettiSingleRand)
    AllUnitsSingleSpaghettiRand(size(AllUnitsSingleSpaghettiRand,2)+1 : (size(HistogramAllUnitsMeanSubtractedSpaghettiSingleRand{ii},2)+size(AllUnitsSingleSpaghettiRand,2))) = HistogramAllUnitsMeanSubtractedSpaghettiSingleRand{ii};
end


% for ii = 1:length(HistogramAllUnitsMeanSubtractedOpenSingle)
%     AllUnitsSingleOpen(size(AllUnitsSingleOpen,2)+1 : (size(HistogramAllUnitsMeanSubtractedOpenSingle{ii},2)+size(AllUnitsSingleOpen,2))) = HistogramAllUnitsMeanSubtractedOpenSingle{ii};
%     LengthBehaviorOpenAllUnits(size(LengthBehaviorOpenAllUnits,2)+1 : (size(LengthBehaviorOpenAll{ii},2)+size(LengthBehaviorOpenAllUnits,2))) = LengthBehaviorOpenAll{ii};
% end
% 
% for ii = 1:length(HistogramAllUnitsMeanSubtractedOpenRandSingle)
%     AllUnitsSingleOpenRand(size(AllUnitsSingleOpenRand,2)+1 : (size(HistogramAllUnitsMeanSubtractedOpenRandSingle{ii},2)+size(AllUnitsSingleOpenRand,2))) = HistogramAllUnitsMeanSubtractedOpenRandSingle{ii};
% end


%finding the maximum peak of each unit to later sort according to that

% for i = 1:size(HistogramAllUnitsOpen,1)
%     MaxPosHelpOpen = find(abs(HistogramAllUnitsOpen(i,:)) == max(abs(HistogramAllUnitsOpen(i,:))));
%     MaxPosHelpOpenRand = find(abs(HistogramAllUnitsOpenRand(i,:)) == max(abs(HistogramAllUnitsOpenRand(i,:))));
%     if length(MaxPosHelpOpen) > 1
%         MaxPosOpen(i) = MaxPosHelpOpen(1);
%     else
%         MaxPosOpen(i) = MaxPosHelpOpen;
%     end
%     if length(MaxPosHelpOpenRand) > 1
%         MaxPosOpenRand(i) = MaxPosHelpOpenRand(1);
%     else
%         MaxPosOpenRand(i) = MaxPosHelpOpenRand;
%     end
% end


for i = 1:size(HistogramAllUnitsReachLateral,1)
    MaxPosHelpReachLateral = find(abs(HistogramAllUnitsReachLateral(i,:)) == max(abs(HistogramAllUnitsReachLateral(i,:))));
    if length(MaxPosHelpReachLateral) > 1
        MaxPosReachLateral(i) = MaxPosHelpReachLateral(1);
    else
        MaxPosReachLateral(i) = MaxPosHelpReachLateral;
    end
end

for i = 1:size(HistogramAllUnitsReachMedial,1)
    MaxPosHelpReachMedial = find(abs(HistogramAllUnitsReachMedial(i,:)) == max(abs(HistogramAllUnitsReachMedial(i,:))));
    if length(MaxPosHelpReachMedial) > 1
        MaxPosReachMedial(i) = MaxPosHelpReachMedial(1);
    else
        MaxPosReachMedial(i) = MaxPosHelpReachMedial;
    end
end

for i = 1:size(HistogramAllUnitsReach,1)
    MaxPosHelpReach = find(abs(HistogramAllUnitsReach(i,:)) == max(abs(HistogramAllUnitsReach(i,:))));
    if length(MaxPosHelpReach) > 1
        MaxPosReach(i) = MaxPosHelpReach(1);
    else
        MaxPosReach(i) = MaxPosHelpReach;
    end
end

for i = 1:size(HistogramAllUnitsReachRand,1)
    MaxPosHelpReachRand = find(abs(HistogramAllUnitsReachRand(i,:)) == max(abs(HistogramAllUnitsReachRand(i,:))));
    if length(MaxPosHelpReachRand) > 1
        MaxPosReachRand(i) = MaxPosHelpReachRand(1);
    else
        MaxPosReachRand(i) = MaxPosHelpReachRand;
    end
end


for i = 1:size(HistogramAllUnitsSpaghetti,1)
    MaxPosHelpSpaghetti = find(abs(HistogramAllUnitsSpaghetti(i,:)) == max(abs(HistogramAllUnitsSpaghetti(i,:))));
    if length(MaxPosHelpSpaghetti) > 1
        MaxPosSpaghetti(i) = MaxPosHelpSpaghetti(1);
    else
        MaxPosSpaghetti(i) = MaxPosHelpSpaghetti;
    end
end


for i = 1:size(HistogramAllUnitsSpaghettiRand,1)
    MaxPosHelpSpaghettiRand = find(abs(HistogramAllUnitsSpaghettiRand(i,:)) == max(abs(HistogramAllUnitsSpaghettiRand(i,:))));
    if length(MaxPosHelpSpaghettiRand) > 1
        MaxPosSpaghettiRand(i) = MaxPosHelpSpaghettiRand(1);
    else
        MaxPosSpaghettiRand(i) = MaxPosHelpSpaghettiRand;
    end
end


%find indices of the those peaks 
[~, sortIndReachRand] = sort(MaxPosReachRand);
[~, sortIndReachLateral] = sort(MaxPosReachLateral);
[~, sortIndReachMedial] = sort(MaxPosReachMedial);
[~, sortIndReach] = sort(MaxPosReach);
[~, sortIndSpaghetti] = sort(MaxPosSpaghetti);
[~, sortIndSpaghettiRand] = sort(MaxPosSpaghettiRand);
% [~, sortIndOpenRand] = sort(MaxPosOpenRand);
% [~, sortIndOpen] = sort(MaxPosOpen);



%sort all Histogram matrices according to the biggest peak

for i = 1:length(sortIndReachLateral)
    HistogramAllUnitsSortedReachLateral(i,:) = HistogramAllUnitsReachLateral(sortIndReachLateral(i),:);
    HistogramAllUnitsMeanSubtractedSortedReachLateral(i,:) = HistogramAllUnitsMeanSubtractedReachLateral(sortIndReachLateral(i),:);
    ReachSpikeNamesAllSortedLateral(i,:) = ReachSpikeNamesAllLateral(sortIndReachLateral(i),:);
    HistogramAllUnitsStdReachSortedLateral(i) = HistogramAllUnitsStdReachLateral(sortIndReachLateral(i));
    HistogramAllUnitsLowReachSortedLateral(i) = HistogramAllUnitsLowReachLateral(sortIndReachLateral(i));
    AllUnitsSingleReachSortedLateral(i) = AllUnitsSingleReachLateral(sortIndReachLateral(i));
    AllUnitsSingleReachTimepointsSortedLateral(i) = AllUnitsSingleReachTimepointsLateral(sortIndReachLateral(i));
    LengthBehaviorReachAllUnitsSortedLateral(i) = LengthBehaviorReachAllUnitsLateral(sortIndReachLateral(i));
end


for i = 1:length(sortIndReachMedial)
    HistogramAllUnitsSortedReachMedial(i,:) = HistogramAllUnitsReachMedial(sortIndReachMedial(i),:);
    HistogramAllUnitsMeanSubtractedSortedReachMedial(i,:) = HistogramAllUnitsMeanSubtractedReachMedial(sortIndReachMedial(i),:);
    ReachSpikeNamesAllSortedMedial(i,:) = ReachSpikeNamesAllMedial(sortIndReachMedial(i),:);
    HistogramAllUnitsStdReachSortedMedial(i) = HistogramAllUnitsStdReachMedial(sortIndReachMedial(i));
    HistogramAllUnitsLowReachSortedMedial(i) = HistogramAllUnitsLowReachMedial(sortIndReachMedial(i));
    AllUnitsSingleReachSortedMedial(i) = AllUnitsSingleReachMedial(sortIndReachMedial(i));
    AllUnitsSingleReachTimepointsSortedMedial(i) = AllUnitsSingleReachTimepointsMedial(sortIndReachMedial(i));
    LengthBehaviorReachAllUnitsSortedMedial(i) = LengthBehaviorReachAllUnitsMedial(sortIndReachMedial(i));
end

for i = 1:length(sortIndReach)
    HistogramAllUnitsSortedReach(i,:) = HistogramAllUnitsReach(sortIndReach(i),:);
    HistogramAllUnitsMeanSubtractedSortedReach(i,:) = HistogramAllUnitsMeanSubtractedReach(sortIndReach(i),:);
    ReachSpikeNamesAllSorted(i,:) = ReachSpikeNamesAll(sortIndReach(i),:);
    HistogramAllUnitsStdReachSorted(i) = HistogramAllUnitsStdReach(sortIndReach(i));
    HistogramAllUnitsLowReachSorted(i) = HistogramAllUnitsLowReach(sortIndReach(i));
    AllUnitsSingleReachSorted(i) = AllUnitsSingleReach(sortIndReach(i));
    AllUnitsSingleReachTimepointsSorted(i) = AllUnitsSingleReachTimepoints(sortIndReach(i));
    LengthBehaviorReachAllUnitsSorted(i) = LengthBehaviorReachAllUnits(sortIndReach(i));
end


for i = 1:length(sortIndReachRand)
    HistogramAllUnitsSortedReachRand(i,:) = HistogramAllUnitsReachRand(sortIndReachRand(i),:);
    HistogramAllUnitsMeanSubtractedSortedReachRand(i,:) = HistogramAllUnitsMeanSubtractedReachRand(sortIndReachRand(i),:);
    ReachSpikeNamesAllSortedRand(i,:) = ReachSpikeNamesAll(sortIndReachRand(i),:);
    HistogramAllUnitsStdReachSortedRand(i) = HistogramAllUnitsStdReachRand(sortIndReachRand(i));
    HistogramAllUnitsLowReachSortedRand(i) = HistogramAllUnitsLowReachRand(sortIndReachRand(i));
    AllUnitsSingleReachSortedRand(i) = AllUnitsSingleReachRand(sortIndReachRand(i));
    AllUnitsSingleReachTimepointsSortedRand(i) = AllUnitsSingleReachTimepointsRand(sortIndReachRand(i));
end

for i = 1:length(sortIndSpaghetti)
    HistogramAllUnitsSortedSpaghetti(i,:) = HistogramAllUnitsSpaghetti(sortIndSpaghetti(i),:);
    HistogramAllUnitsMeanSubtractedSortedSpaghetti(i,:) = HistogramAllUnitsMeanSubtractedSpaghetti(sortIndSpaghetti(i),:);
    SpaghettiSpikeNamesAllSorted(i,:) = SpaghettiSpikeNamesAll(sortIndSpaghetti(i),:);
    HistogramAllUnitsStdSpaghettiSorted(i) = HistogramAllUnitsStdSpaghetti(sortIndSpaghetti(i));
    HistogramAllUnitsLowSpaghettiSorted(i) = HistogramAllUnitsLowSpaghetti(sortIndSpaghetti(i));
    AllUnitsSingleSpaghettiSorted(i) = AllUnitsSingleSpaghetti(sortIndSpaghetti(i));
    LengthBehaviorSpaghettiAllUnitsSorted(i) = LengthBehaviorSpaghettiAllUnits(sortIndSpaghetti(i));
end


for i = 1:length(sortIndSpaghettiRand)
    HistogramAllUnitsSortedSpaghettiRand(i,:) = HistogramAllUnitsSpaghettiRand(sortIndSpaghettiRand(i),:);
    HistogramAllUnitsMeanSubtractedSortedSpaghettiRand(i,:) = HistogramAllUnitsMeanSubtractedSpaghettiRand(sortIndSpaghettiRand(i),:);
    SpaghettiSpikeNamesAllSortedRand(i,:) = SpaghettiSpikeNamesAll(sortIndSpaghettiRand(i),:);
    HistogramAllUnitsStdSpaghettiSortedRand(i) = HistogramAllUnitsStdSpaghettiRand(sortIndSpaghettiRand(i));
    HistogramAllUnitsLowSpaghettiSortedRand(i) = HistogramAllUnitsLowSpaghettiRand(sortIndSpaghettiRand(i));
    AllUnitsSingleSpaghettiSortedRand(i) = AllUnitsSingleSpaghettiRand(sortIndSpaghettiRand(i));
end


% for i = 1:length(sortIndOpen)
%     HistogramAllUnitsSortedOpen(i,:) = HistogramAllUnitsOpen(sortIndOpen(i),:);
%     HistogramAllUnitsMeanSubtractedSortedOpen(i,:) = HistogramAllUnitsMeanSubtractedOpen(sortIndOpen(i),:);
%     OpenSpikeNamesAllSorted(i,:) = OpenSpikeNamesAll(sortIndOpen(i),:);
%     HistogramAllUnitsStdOpenSorted(i) = HistogramAllUnitsStdOpen(sortIndOpen(i));
%     HistogramAllUnitsLowOpenSorted(i) = HistogramAllUnitsLowOpen(sortIndOpen(i));
%     AllUnitsSingleOpenSorted(i) = AllUnitsSingleOpen(sortIndOpen(i));
%     LengthBehaviorOpenAllUnitsSorted(i) = LengthBehaviorOpenAllUnits(sortIndOpen(i));
% end
% 
% for i = 1:length(sortIndOpenRand)
%     HistogramAllUnitsSortedOpenRand(i,:) = HistogramAllUnitsOpenRand(sortIndOpenRand(i),:);
%     HistogramAllUnitsMeanSubtractedSortedOpenRand(i,:) = HistogramAllUnitsMeanSubtractedOpenRand(sortIndOpenRand(i),:);
%     OpenSpikeNamesAllSortedRand(i,:) = OpenSpikeNamesAll(sortIndOpenRand(i),:);
%     HistogramAllUnitsStdOpenSortedRand(i) = HistogramAllUnitsStdOpenRand(sortIndOpenRand(i));
%     HistogramAllUnitsLowOpenSortedRand(i) = HistogramAllUnitsLowOpenRand(sortIndOpenRand(i));
%     AllUnitsSingleOpenSortedRand(i) = AllUnitsSingleOpenRand(sortIndOpenRand(i));
% end

%this is important for plotting later with heat plot colors
edgesReachLateral = linspace(0,length(HistogramAllUnitsSortedReachLateral),length(HistogramAllUnitsSortedReachLateral)+1);
edgesReachMedial = linspace(0,length(HistogramAllUnitsSortedReachMedial),length(HistogramAllUnitsSortedReachMedial)+1);
edgesReach = linspace(0,length(HistogramAllUnitsSortedReach),length(HistogramAllUnitsSortedReach)+1);
edgesReachRand = linspace(0,length(HistogramAllUnitsSortedReachRand),length(HistogramAllUnitsSortedReachRand)+1);
edgesSpaghetti = linspace(0,length(HistogramAllUnitsSortedSpaghetti),length(HistogramAllUnitsSortedSpaghetti)+1);
edgesSpaghettiRand = linspace(0,length(HistogramAllUnitsSortedSpaghettiRand),length(HistogramAllUnitsSortedSpaghettiRand)+1);
% edgesOpen = linspace(0,length(HistogramAllUnitsSortedOpen),length(HistogramAllUnitsSortedOpen)+1);
% edgesOpenRand = linspace(0,length(HistogramAllUnitsSortedOpenRand),length(HistogramAllUnitsSortedOpenRand)+1);
ColorParula = parula;


% low frequencies to delete as they anyway will not be able to contribute
% to any significant behavioral relationship (is this really true?? and
% which frequency to use??)

% for i = 1:size(HistogramAllUnitsMeanSubtractedSorted,1)
%     ToDelete(i) = sum(abs(HistogramAllUnitsMeanSubtractedSorted(i,:)/HistogramAllUnitsStdSorted(i))>TimesStd)>0;
%     if ToDelete(i)>0
%         if ToDeleteFreq(i)>0
%             HistogramAllUnitsMeanSubtractedCorr(size(HistogramAllUnitsMeanSubtractedCorr,1)+1,:) = HistogramAllUnitsMeanSubtractedSorted(i,:);
%             LeverSpikeNamesAllSortedCorr(size(LeverSpikeNamesAllSortedCorr,1)+1,:) = LeverSpikeNamesAllSorted(i,:);
%         end
%     end
% end

ToDeleteFreqReachLateral = max(HistogramAllUnitsSortedReachLateral(:,abs(Before/BinSize)+(-2.5/BinSize)+1:abs(Before/BinSize)+(+2.5/BinSize)), [], 2)>FreqCutOff;
NeuronsContributingReachLateral = sum(ToDeleteFreqReachLateral);
NeuronsContributingReachNamesLateral = ReachSpikeNamesAllSortedLateral(ToDeleteFreqReachLateral,:);
HistogramAllUnitsMeanSubtractedCorrReachLateral = [];
ReachSpikeNamesAllSortedCorrLateral = {};
for i = 1:size(HistogramAllUnitsMeanSubtractedSortedReachLateral,1)
    ToDeleteReachLateral(i) = sum(HistogramAllUnitsMeanSubtractedSortedReachLateral(i,(1/BinSize)*abs((Before+1.5)):(1/BinSize)*abs((After+0.5)))>(TimesStd*HistogramAllUnitsStdReachSortedLateral(i)))>0;
    if ToDeleteReachLateral(i)>0
        if HistogramAllUnitsLowReachSortedLateral(i)>0
            if ToDeleteFreqReachLateral(i)>0
                HistogramAllUnitsMeanSubtractedCorrReachLateral(size(HistogramAllUnitsMeanSubtractedCorrReachLateral,1)+1,:) = HistogramAllUnitsMeanSubtractedSortedReachLateral(i,:);
                ReachSpikeNamesAllSortedCorrLateral(size(ReachSpikeNamesAllSortedCorrLateral,1)+1,:) = ReachSpikeNamesAllSortedLateral(i,:);
            end
        end
    end
end


ToDeleteFreqReachMedial = max(HistogramAllUnitsSortedReachMedial(:,abs(Before/BinSize)+(-2.5/BinSize)+1:abs(Before/BinSize)+(+2.5/BinSize)), [], 2)>FreqCutOff;
NeuronsContributingReachMedial = sum(ToDeleteFreqReachMedial);
NeuronsContributingReachNamesMedial = ReachSpikeNamesAllSortedMedial(ToDeleteFreqReachMedial,:);
HistogramAllUnitsMeanSubtractedCorrReachMedial = [];
ReachSpikeNamesAllSortedCorrMedial = {};
for i = 1:size(HistogramAllUnitsMeanSubtractedSortedReachMedial,1)
    ToDeleteReachMedial(i) = sum(HistogramAllUnitsMeanSubtractedSortedReachMedial(i,(1/BinSize)*abs((Before+1.5)):(1/BinSize)*abs((After+0.5)))>(TimesStd*HistogramAllUnitsStdReachSortedMedial(i)))>0;
    if ToDeleteReachMedial(i)>0
        if HistogramAllUnitsLowReachSortedMedial(i)>0
            if ToDeleteFreqReachMedial(i)>0
                HistogramAllUnitsMeanSubtractedCorrReachMedial(size(HistogramAllUnitsMeanSubtractedCorrReachMedial,1)+1,:) = HistogramAllUnitsMeanSubtractedSortedReachMedial(i,:);
                ReachSpikeNamesAllSortedCorrMedial(size(ReachSpikeNamesAllSortedCorrMedial,1)+1,:) = ReachSpikeNamesAllSortedMedial(i,:);
            end
        end
    end
end



ToDeleteFreqReach = max(HistogramAllUnitsSortedReach(:,abs(Before/BinSize)+(-2.5/BinSize)+1:abs(Before/BinSize)+(+2.5/BinSize)), [], 2)>FreqCutOff;
NeuronsContributingReach = sum(ToDeleteFreqReach);
NeuronsContributingReachNames = ReachSpikeNamesAllSorted(ToDeleteFreqReach,:);
HistogramAllUnitsMeanSubtractedCorrReach = [];
ReachSpikeNamesAllSortedCorr = {};
for i = 1:size(HistogramAllUnitsMeanSubtractedSortedReach,1)
    ToDeleteReach(i) = sum(HistogramAllUnitsMeanSubtractedSortedReach(i,(1/BinSize)*abs((Before+1.5)):(1/BinSize)*abs((After+0.5)))>(TimesStd*HistogramAllUnitsStdReachSorted(i)))>0;
    if ToDeleteReach(i)>0
        if HistogramAllUnitsLowReachSorted(i)>0
            if ToDeleteFreqReach(i)>0
                HistogramAllUnitsMeanSubtractedCorrReach(size(HistogramAllUnitsMeanSubtractedCorrReach,1)+1,:) = HistogramAllUnitsMeanSubtractedSortedReach(i,:);
                ReachSpikeNamesAllSortedCorr(size(ReachSpikeNamesAllSortedCorr,1)+1,:) = ReachSpikeNamesAllSorted(i,:);
            end
        end
    end
end



ToDeleteFreqReachRand = max(HistogramAllUnitsSortedReachRand(:,abs(Before/BinSize)+(-2.5/BinSize)+1:abs(Before/BinSize)+(+2.5/BinSize)), [], 2)>FreqCutOff;
NeuronsContributingReachRand = sum(ToDeleteFreqReachRand);
NeuronsContributingReachRandNames = ReachSpikeNamesAllSortedRand(ToDeleteFreqReachRand,:);
HistogramAllUnitsMeanSubtractedCorrReachRand = [];
ReachSpikeNamesAllSortedCorrRand = {};
for i = 1:size(HistogramAllUnitsMeanSubtractedSortedReachRand,1)
    ToDeleteReachRand(i) = sum(HistogramAllUnitsMeanSubtractedSortedReachRand(i,(1/BinSize)*abs((Before+1.5)):(1/BinSize)*abs((After+0.5)))>(TimesStd*HistogramAllUnitsStdReachSortedRand(i)))>0;
    if ToDeleteReachRand(i)>0
        if HistogramAllUnitsLowReachSortedRand(i)>0
            if ToDeleteFreqReachRand(i)>0
                HistogramAllUnitsMeanSubtractedCorrReachRand(size(HistogramAllUnitsMeanSubtractedCorrReachRand,1)+1,:) = HistogramAllUnitsMeanSubtractedSortedReachRand(i,:);
                ReachSpikeNamesAllSortedCorrRand(size(ReachSpikeNamesAllSortedCorrRand,1)+1,:) = ReachSpikeNamesAllSortedRand(i,:);
            end
        end
    end
end


ToDeleteFreqSpaghetti = max(HistogramAllUnitsSortedSpaghetti(:,abs(Before/BinSize)+(-2.5/BinSize)+1:abs(Before/BinSize)+(+2.5/BinSize)), [], 2)>FreqCutOff;
NeuronsContributingSpaghetti = sum(ToDeleteFreqSpaghetti);
NeuronsContributingSpaghettiNames = SpaghettiSpikeNamesAllSorted(ToDeleteFreqSpaghetti,:);
HistogramAllUnitsMeanSubtractedCorrSpaghetti = [];
SpaghettiSpikeNamesAllSortedCorr = {};
for i = 1:size(HistogramAllUnitsMeanSubtractedSortedSpaghetti,1)
    ToDeleteSpaghetti(i) = sum(HistogramAllUnitsMeanSubtractedSortedSpaghetti(i,(1/BinSize)*abs((Before+1.5)):(1/BinSize)*abs((After+0.5)))>(TimesStd*HistogramAllUnitsStdSpaghettiSorted(i)))>0;
    if ToDeleteSpaghetti(i)>0
        if HistogramAllUnitsLowSpaghettiSorted(i)>0
            if ToDeleteFreqSpaghetti(i)>0
                HistogramAllUnitsMeanSubtractedCorrSpaghetti(size(HistogramAllUnitsMeanSubtractedCorrSpaghetti,1)+1,:) = HistogramAllUnitsMeanSubtractedSortedSpaghetti(i,:);
                SpaghettiSpikeNamesAllSortedCorr(size(SpaghettiSpikeNamesAllSortedCorr,1)+1,:) = SpaghettiSpikeNamesAllSorted(i,:);
            end
        end
    end
end

ToDeleteFreqSpaghettiRand = max(HistogramAllUnitsSortedSpaghettiRand(:,abs(Before/BinSize)+(-2.5/BinSize)+1:abs(Before/BinSize)+(+2.5/BinSize)), [], 2)>FreqCutOff;
NeuronsContributingSpaghettiRand = sum(ToDeleteFreqSpaghettiRand);
NeuronsContributingSpaghettiNamesRand = SpaghettiSpikeNamesAllSortedRand(ToDeleteFreqSpaghettiRand,:);
HistogramAllUnitsMeanSubtractedCorrSpaghettiRand = [];
SpaghettiSpikeNamesAllSortedCorrRand = {};
for i = 1:size(HistogramAllUnitsMeanSubtractedSortedSpaghettiRand,1)
    ToDeleteSpaghettiRand(i) = sum(HistogramAllUnitsMeanSubtractedSortedSpaghettiRand(i,(1/BinSize)*abs((Before+1.5)):(1/BinSize)*abs((After+0.5)))>(TimesStd*HistogramAllUnitsStdSpaghettiSortedRand(i)))>0;
    if ToDeleteSpaghettiRand(i)>0
        if HistogramAllUnitsLowSpaghettiSortedRand(i)>0
            if ToDeleteFreqSpaghettiRand(i)>0
                HistogramAllUnitsMeanSubtractedCorrSpaghettiRand(size(HistogramAllUnitsMeanSubtractedCorrSpaghettiRand,1)+1,:) = HistogramAllUnitsMeanSubtractedSortedSpaghettiRand(i,:);
                SpaghettiSpikeNamesAllSortedCorrRand(size(SpaghettiSpikeNamesAllSortedCorrRand,1)+1,:) = SpaghettiSpikeNamesAllSortedRand(i,:);
            end
        end
    end
end

% ToDeleteFreqOpen = max(HistogramAllUnitsSortedOpen(:,abs(Before/BinSize)+(-2.5/BinSize)+1:abs(Before/BinSize)+(+2.5/BinSize)), [], 2)>FreqCutOff;
% NeuronsContributingOpen = sum(ToDeleteFreqOpen);
% NeuronsContributingOpenNames = OpenSpikeNamesAllSorted(ToDeleteFreqOpen,:);
% HistogramAllUnitsMeanSubtractedCorrOpen = [];
% OpenSpikeNamesAllSortedCorr = {};
% for i = 1:size(HistogramAllUnitsMeanSubtractedSortedOpen,1)
%     ToDeleteOpen(i) = sum(HistogramAllUnitsMeanSubtractedSortedOpen(i,(1/BinSize)*abs((Before+1.5)):(1/BinSize)*abs((After+0.5)))>(TimesStd*HistogramAllUnitsStdOpenSorted(i)))>0;
%     if ToDeleteOpen(i)>0
%         if HistogramAllUnitsLowOpenSorted(i)>0
%             if ToDeleteFreqOpen(i)>0
%                 HistogramAllUnitsMeanSubtractedCorrOpen(size(HistogramAllUnitsMeanSubtractedCorrOpen,1)+1,:) = HistogramAllUnitsMeanSubtractedSortedOpen(i,:);
%                 OpenSpikeNamesAllSortedCorr(size(OpenSpikeNamesAllSortedCorr,1)+1,:) = OpenSpikeNamesAllSorted(i,:);
%             end
%         end
%     end
% end
% 
% 
% ToDeleteFreqOpenRand = max(HistogramAllUnitsSortedOpenRand(:,abs(Before/BinSize)+(-2.5/BinSize)+1:abs(Before/BinSize)+(+2.5/BinSize)), [], 2)>FreqCutOff;
% NeuronsContributingOpenRand = sum(ToDeleteFreqOpenRand);
% NeuronsContributingOpenRandNames = OpenSpikeNamesAllSortedRand(ToDeleteFreqOpenRand,:);
% HistogramAllUnitsMeanSubtractedCorrOpenRand = [];
% OpenSpikeNamesAllSortedCorrRand = {};
% for i = 1:size(HistogramAllUnitsMeanSubtractedSortedOpenRand,1)
%     ToDeleteOpenRand(i) = sum(HistogramAllUnitsMeanSubtractedSortedOpenRand(i,(1/BinSize)*abs((Before+1.5)):(1/BinSize)*abs((After+0.5)))>(TimesStd*HistogramAllUnitsStdOpenSortedRand(i)))>0;
%     if ToDeleteOpenRand(i)>0
%         if HistogramAllUnitsLowOpenSortedRand(i)>0
%             if ToDeleteFreqOpenRand(i)>0
%                 HistogramAllUnitsMeanSubtractedCorrOpenRand(size(HistogramAllUnitsMeanSubtractedCorrOpenRand,1)+1,:) = HistogramAllUnitsMeanSubtractedSortedOpenRand(i,:);
%                 OpenSpikeNamesAllSortedCorrRand(size(OpenSpikeNamesAllSortedCorrRand,1)+1,:) = OpenSpikeNamesAllSortedRand(i,:);
%             end
%         end
%     end
% end

% putting resulting matrices of Sorted binned frequencies
% (HistogramAllUnitsSorted), sorted names (...SpikeNamesAllSorted), sorted
% mean subtracted binned frequencies (HistogramAllUnitsMeanSubtracted)
% and then sorted binned frequencies with 2 Std above mean deflection
% (HistogramAllUnitsMeanSubtractedCorr) plus its names
% (...SpikeNamesAllSortedCorr)

Results.HistogramLeverReachLateral = HistogramAllUnitsSortedReachLateral;
Results.HistogramLeverReachMeanSubtractedSingleLateral = AllUnitsSingleReachSortedLateral;
Results.AllUnitsSingleReachTimepointsSortedLateral = AllUnitsSingleReachTimepointsSortedLateral;
Results.LeverLengthBehaviorReachLateral = LengthBehaviorReachAllUnitsSortedLateral;
Results.LeverReachStdLateral = HistogramAllUnitsStdReachSortedLateral;
Results.HistogramLeverReachNamesLateral = ReachSpikeNamesAllSortedLateral;
Results.HistogramLeverMeanSubtractedReachLateral = HistogramAllUnitsMeanSubtractedSortedReachLateral;
Results.HistogramLeverMeanSubtractedCorrReachLateral = HistogramAllUnitsMeanSubtractedCorrReachLateral;
Results.HistogramLeverMeanSubtractedCorrReachNamesLateral = ReachSpikeNamesAllSortedCorrLateral;
Results.NeuronsContributingReachLateral = NeuronsContributingReachLateral;
Results.NeuronsContributingReachNamesLateral = NeuronsContributingReachNamesLateral;

Results.HistogramLeverReachMedial = HistogramAllUnitsSortedReachMedial;
Results.HistogramLeverReachMeanSubtractedSingleMedial = AllUnitsSingleReachSortedMedial;
Results.AllUnitsSingleReachTimepointsSortedMedial = AllUnitsSingleReachTimepointsSortedMedial;
Results.LeverLengthBehaviorReachMedial = LengthBehaviorReachAllUnitsSortedMedial;
Results.LeverReachStdMedial = HistogramAllUnitsStdReachSortedMedial;
Results.HistogramLeverReachNamesMedial = ReachSpikeNamesAllSortedMedial;
Results.HistogramLeverMeanSubtractedReachMedial = HistogramAllUnitsMeanSubtractedSortedReachMedial;
Results.HistogramLeverMeanSubtractedCorrReachMedial = HistogramAllUnitsMeanSubtractedCorrReachMedial;
Results.HistogramLeverMeanSubtractedCorrReachNamesMedial = ReachSpikeNamesAllSortedCorrMedial;
Results.NeuronsContributingReachMedial = NeuronsContributingReachMedial;
Results.NeuronsContributingReachNamesMedial = NeuronsContributingReachNamesMedial;

Results.HistogramLeverReach = HistogramAllUnitsSortedReach;
Results.HistogramLeverReachMeanSubtractedSingle = AllUnitsSingleReachSorted;
Results.AllUnitsSingleReachTimepointsSorted = AllUnitsSingleReachTimepointsSorted;
Results.LeverLengthBehaviorReach = LengthBehaviorReachAllUnitsSorted;
Results.LeverReachStd = HistogramAllUnitsStdReachSorted;
Results.HistogramLeverReachNames = ReachSpikeNamesAllSorted;
Results.HistogramLeverMeanSubtractedReach = HistogramAllUnitsMeanSubtractedSortedReach;
Results.HistogramLeverMeanSubtractedCorrReach = HistogramAllUnitsMeanSubtractedCorrReach;
Results.HistogramLeverMeanSubtractedCorrReachNames = ReachSpikeNamesAllSortedCorr;
Results.NeuronsContributingReach = NeuronsContributingReach;
Results.NeuronsContributingReachNames = NeuronsContributingReachNames;

Results.HistogramLeverReachRand = HistogramAllUnitsSortedReachRand;
Results.HistogramLeverReachRandMeanSubtractedSingle = AllUnitsSingleReachSortedRand;
Results.AllUnitsSingleReachTimepointsSortedRand = AllUnitsSingleReachTimepointsSortedRand;
Results.HistogramLeverReachRandNames = ReachSpikeNamesAllSortedRand;
Results.HistogramLeverMeanSubtractedReachRand = HistogramAllUnitsMeanSubtractedSortedReachRand;
Results.HistogramLeverMeanSubtractedCorrReachRand = HistogramAllUnitsMeanSubtractedCorrReachRand;
Results.HistogramLeverMeanSubtractedCorrReachRandNames = ReachSpikeNamesAllSortedCorrRand;
Results.NeuronsContributingReachRand = NeuronsContributingReachRand;
Results.NeuronsContributingReachRandNames = NeuronsContributingReachRandNames;

Results.HistogramLeverSpaghetti = HistogramAllUnitsSortedSpaghetti;
Results.HistogramLeverSpaghettiMeanSubtractedSingle = AllUnitsSingleSpaghettiSorted;
Results.LeverLengthBehaviorSpaghetti = LengthBehaviorSpaghettiAllUnitsSorted;
Results.LeverSpaghettiStd = HistogramAllUnitsStdSpaghettiSorted;
Results.HistogramLeverSpaghettiNames = SpaghettiSpikeNamesAllSorted;
Results.HistogramLeverMeanSubtractedSpaghetti = HistogramAllUnitsMeanSubtractedSortedSpaghetti;
Results.HistogramLeverMeanSubtractedCorrSpaghetti = HistogramAllUnitsMeanSubtractedCorrSpaghetti;
Results.HistogramLeverMeanSubtractedCorrSpaghettiNames = SpaghettiSpikeNamesAllSortedCorr;
Results.NeuronsContributingSpaghetti = NeuronsContributingSpaghetti;
Results.NeuronsContributingSpaghettiNames = NeuronsContributingSpaghettiNames;


Results.HistogramLeverSpaghettiRand = HistogramAllUnitsSortedSpaghettiRand;
Results.HistogramLeverSpaghettiMeanSubtractedSingleRand = AllUnitsSingleSpaghettiSortedRand;
Results.LeverSpaghettiStdRand = HistogramAllUnitsStdSpaghettiSortedRand;
Results.HistogramLeverSpaghettiNamesRand = SpaghettiSpikeNamesAllSortedRand;
Results.HistogramLeverMeanSubtractedSpaghettiRand = HistogramAllUnitsMeanSubtractedSortedSpaghettiRand;
Results.HistogramLeverMeanSubtractedCorrSpaghettiRand = HistogramAllUnitsMeanSubtractedCorrSpaghettiRand;
Results.HistogramLeverMeanSubtractedCorrSpaghettiNamesRand = SpaghettiSpikeNamesAllSortedCorrRand;
Results.NeuronsContributingSpaghettiRand = NeuronsContributingSpaghettiRand;
Results.NeuronsContributingSpaghettiNamesRand = NeuronsContributingSpaghettiNamesRand;

% Results.HistogramLeverOpen = HistogramAllUnitsSortedOpen;
% Results.HistogramLeverOpenMeanSubtractedSingle = AllUnitsSingleOpenSorted;
% Results.LeverLengthBehaviorOpen = LengthBehaviorOpenAllUnitsSorted;
% Results.LeverOpenStd = HistogramAllUnitsStdOpenSorted;
% Results.HistogramOpenNames = OpenSpikeNamesAllSorted;
% Results.HistogramLeverMeanSubtractedOpen = HistogramAllUnitsMeanSubtractedSortedOpen;
% Results.HistogramLeverMeanSubtractedCorrOpen = HistogramAllUnitsMeanSubtractedCorrOpen;
% Results.HistogramLeverMeanSubtractedCorrOpenNames = OpenSpikeNamesAllSortedCorr;
% Results.NeuronsContributingOpen = NeuronsContributingOpen;
% Results.NeuronsContributingOpenNames = NeuronsContributingOpenNames;
% 
% Results.HistogramLeverOpenRand = HistogramAllUnitsSortedOpenRand;
% Results.HistogramLeverOpenRandMeanSubtractedSingle = AllUnitsSingleOpenSortedRand;
% Results.HistogramOpenRandNames = OpenSpikeNamesAllSortedRand;
% Results.HistogramLeverMeanSubtractedOpenRand = HistogramAllUnitsMeanSubtractedSortedOpenRand;
% Results.HistogramLeverMeanSubtractedCorrOpenRand = HistogramAllUnitsMeanSubtractedCorrOpenRand;
% Results.HistogramLeverMeanSubtractedCorrOpenRandNames = OpenSpikeNamesAllSortedCorrRand;
% Results.NeuronsContributingOpenRand = NeuronsContributingOpenRand;
% Results.NeuronsContributingOpenRandNames = NeuronsContributingOpenRandNames;

if Plotting == 1
    %plotting of heat plots from above mentioned matrices for Lever Pressing
    % figure 
    % hold on
    % for i = 1:size(HistogramAllUnitsSorted,1)
    %     MinValue = min(min(HistogramAllUnitsSorted(i,:)));
    %     MaxValue = max(max(HistogramAllUnitsSorted(i,:)));
    %     ColorVector = linspace(MinValue, MaxValue, length(parula));
    %     for ii = 1:length(HistogramAllUnitsSorted(i,:))
    %         [~, ColorInd] = min(abs(ColorVector - HistogramAllUnitsSorted(i,ii)));
    %         rectangle('Position', [edges(ii) ((i-1)/size(HistogramAllUnitsSorted,1)) 1 (1/size(HistogramAllUnitsSorted,1))], 'FaceColor', ColorParula(ColorInd,:), 'EdgeColor', 'none')
    %     end
    % end
    % 
    % print -painters -depsc 

    % figure
    % hold on
    % for i = 1:size(HistogramAllUnitsMeanSubtractedSorted,1)
    %     MinValue = min(min(HistogramAllUnitsMeanSubtractedSorted(i,:)));
    %     MaxValue = max(max(HistogramAllUnitsMeanSubtractedSorted(i,:)));
    %     ColorVector = linspace(MinValue, MaxValue, length(parula));
    %     for ii = 1:length(HistogramAllUnitsMeanSubtractedSorted(i,:))
    %         [~, ColorInd] = min(abs(ColorVector - HistogramAllUnitsMeanSubtractedSorted(i,ii)));
    %         rectangle('Position', [edges(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedSorted,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedSorted,1))], 'FaceColor', ColorParula(ColorInd,:), 'EdgeColor', 'none')
    %     end
    % end    
    % print -painters -depsc 
    



    %plotting of heat plots from above mentioned matrices for Pellet Reaching
    % figure 
    % hold on
    % for i = 1:size(HistogramAllUnitsSortedReach,1)
    %     MinValueReach = min(min(HistogramAllUnitsSortedReach(i,:)));
    %     MaxValueReach = max(max(HistogramAllUnitsSortedReach(i,:)));
    %     ColorVectorReach = linspace(MinValueReach, MaxValueReach, length(parula));
    %     for ii = 1:length(HistogramAllUnitsSortedReach(i,:))
    %         [~, ColorIndReach] = min(abs(ColorVectorReach - HistogramAllUnitsSortedReach(i,ii)));
    %         rectangle('Position', [edgesReach(ii) ((i-1)/size(HistogramAllUnitsSortedReach,1)) 1 (1/size(HistogramAllUnitsSortedReach,1))], 'FaceColor', ColorParula(ColorIndReach,:), 'EdgeColor', 'none')
    %     end
    % end
    %print -painters -depsc 
    % figure
    % hold on
    % for i = 1:size(HistogramAllUnitsMeanSubtractedSortedReach,1)
    %     MinValueReach = min(min(HistogramAllUnitsMeanSubtractedSortedReach(i,:)));
    %     MaxValueReach = max(max(HistogramAllUnitsMeanSubtractedSortedReach(i,:)));
    %     ColorVectorReach = linspace(MinValueReach, MaxValueReach, length(parula));
    %     for ii = 1:length(HistogramAllUnitsMeanSubtractedSortedReach(i,:))
    %         [~, ColorIndReach] = min(abs(ColorVectorReach - HistogramAllUnitsMeanSubtractedSortedReach(i,ii)));
    %         rectangle('Position', [edgesReach(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedSortedReach,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedSortedReach,1))], 'FaceColor', ColorParula(ColorIndReach,:), 'EdgeColor', 'none')
    %     end
    % end
    % print -painters -depsc
    
    
    edgesStdReach = linspace(0,length(HistogramAllUnitsMeanSubtractedCorrReach),length(HistogramAllUnitsMeanSubtractedCorrReach)+1);

    figure
    hold on
    for i = 1:size(HistogramAllUnitsMeanSubtractedCorrReach,1)
        MinValueReach = min(min(HistogramAllUnitsMeanSubtractedCorrReach(i,:)));
        MaxValueReach = max(max(HistogramAllUnitsMeanSubtractedCorrReach(i,:)));
        ColorVectorReach = linspace(MinValueReach, MaxValueReach, length(parula));
        for ii = 1:length(HistogramAllUnitsMeanSubtractedCorrReach(i,:))
            [~, ColorIndReach] = min(abs(ColorVectorReach - HistogramAllUnitsMeanSubtractedCorrReach(i,ii)));
            rectangle('Position', [edgesStdReach(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedCorrReach,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedCorrReach,1))], 'FaceColor', ColorParula(ColorIndReach,:), 'EdgeColor', 'none')
        end
    end
    print -painters -depsc
    
    
    
    edgesStdReachLateral = linspace(0,length(HistogramAllUnitsMeanSubtractedCorrReachLateral),length(HistogramAllUnitsMeanSubtractedCorrReachLateral)+1);

    figure
    hold on
    for i = 1:size(HistogramAllUnitsMeanSubtractedCorrReachLateral,1)
        MinValueReachLateral = min(min(HistogramAllUnitsMeanSubtractedCorrReachLateral(i,:)));
        MaxValueReachLateral = max(max(HistogramAllUnitsMeanSubtractedCorrReachLateral(i,:)));
        ColorVectorReachLateral = linspace(MinValueReachLateral, MaxValueReachLateral, length(parula));
        for ii = 1:length(HistogramAllUnitsMeanSubtractedCorrReachLateral(i,:))
            [~, ColorIndReachLateral] = min(abs(ColorVectorReachLateral - HistogramAllUnitsMeanSubtractedCorrReachLateral(i,ii)));
            rectangle('Position', [edgesStdReachLateral(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedCorrReachLateral,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedCorrReachLateral,1))], 'FaceColor', ColorParula(ColorIndReachLateral,:), 'EdgeColor', 'none')
        end
    end
    print -painters -depsc
    
    
    edgesStdReachMedial = linspace(0,length(HistogramAllUnitsMeanSubtractedCorrReachMedial),length(HistogramAllUnitsMeanSubtractedCorrReachMedial)+1);

    figure
    hold on
    for i = 1:size(HistogramAllUnitsMeanSubtractedCorrReachMedial,1)
        MinValueReachMedial = min(min(HistogramAllUnitsMeanSubtractedCorrReachMedial(i,:)));
        MaxValueReachMedial = max(max(HistogramAllUnitsMeanSubtractedCorrReachMedial(i,:)));
        ColorVectorReachMedial = linspace(MinValueReachMedial, MaxValueReachMedial, length(parula));
        for ii = 1:length(HistogramAllUnitsMeanSubtractedCorrReachMedial(i,:))
            [~, ColorIndReachMedial] = min(abs(ColorVectorReachMedial - HistogramAllUnitsMeanSubtractedCorrReachMedial(i,ii)));
            rectangle('Position', [edgesStdReachMedial(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedCorrReachMedial,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedCorrReachMedial,1))], 'FaceColor', ColorParula(ColorIndReachMedial,:), 'EdgeColor', 'none')
        end
    end
    print -painters -depsc


    %plotting of heat plots from above mentioned matrices for Pellet Reaching
    % figure 
    % hold on
    % for i = 1:size(HistogramAllUnitsSortedSpaghetti,1)
    %     MinValueSpaghetti = min(min(HistogramAllUnitsSortedSpaghetti(i,:)));
    %     MaxValueSpaghetti = max(max(HistogramAllUnitsSortedSpaghetti(i,:)));
    %     ColorVectorSpaghetti = linspace(MinValueSpaghetti, MaxValueSpaghetti, length(parula));
    %     for ii = 1:length(HistogramAllUnitsSortedSpaghetti(i,:))
    %         [~, ColorIndSpaghetti] = min(abs(ColorVectorSpaghetti - HistogramAllUnitsSortedSpaghetti(i,ii)));
    %         rectangle('Position', [edgesSpaghetti(ii) ((i-1)/size(HistogramAllUnitsSortedSpaghetti,1)) 1 (1/size(HistogramAllUnitsSortedSpaghetti,1))], 'FaceColor', ColorParula(ColorIndSpaghetti,:), 'EdgeColor', 'none')
    %     end
    % end
    %print -painters -depsc 
    % figure
    % hold on
    % for i = 1:size(HistogramAllUnitsMeanSubtractedSortedSpaghetti,1)
    %     MinValueSpaghetti = min(min(HistogramAllUnitsMeanSubtractedSortedSpaghetti(i,:)));
    %     MaxValueSpaghetti = max(max(HistogramAllUnitsMeanSubtractedSortedSpaghetti(i,:)));
    %     ColorVectorSpaghetti = linspace(MinValueSpaghetti, MaxValueSpaghetti, length(parula));
    %     for ii = 1:length(HistogramAllUnitsMeanSubtractedSortedSpaghetti(i,:))
    %         [~, ColorIndSpaghetti] = min(abs(ColorVectorSpaghetti - HistogramAllUnitsMeanSubtractedSortedSpaghetti(i,ii)));
    %         rectangle('Position', [edgesSpaghetti(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedSortedSpaghetti,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedSortedSpaghetti,1))], 'FaceColor', ColorParula(ColorIndSpaghetti,:), 'EdgeColor', 'none')
    %     end
    % end
    % print -painters -depsc
    edgesStdSpaghetti = linspace(0,length(HistogramAllUnitsMeanSubtractedCorrSpaghetti),length(HistogramAllUnitsMeanSubtractedCorrSpaghetti)+1);

    figure
    hold on
    for i = 1:size(HistogramAllUnitsMeanSubtractedCorrSpaghetti,1)
        MinValueSpaghetti = min(min(HistogramAllUnitsMeanSubtractedCorrSpaghetti(i,:)));
        MaxValueSpaghetti = max(max(HistogramAllUnitsMeanSubtractedCorrSpaghetti(i,:)));
        ColorVectorSpaghetti = linspace(MinValueSpaghetti, MaxValueSpaghetti, length(parula));
        for ii = 1:length(HistogramAllUnitsMeanSubtractedCorrSpaghetti(i,:))
            [~, ColorIndSpaghetti] = min(abs(ColorVectorSpaghetti - HistogramAllUnitsMeanSubtractedCorrSpaghetti(i,ii)));
            rectangle('Position', [edgesStdSpaghetti(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedCorrSpaghetti,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedCorrSpaghetti,1))], 'FaceColor', ColorParula(ColorIndSpaghetti,:), 'EdgeColor', 'none')
        end
    end
    print -painters -depsc 


    




    %plotting of heat plots from above mentioned matrices for Open Field
    %Locomotion events
    % figure 
    % hold on
    % for i = 1:size(HistogramAllUnitsSortedOpen,1)
    %     MinValueOpen = min(min(HistogramAllUnitsSortedOpen(i,:)));
    %     MaxValueOpen = max(max(HistogramAllUnitsSortedOpen(i,:)));
    %     ColorVectorOpen = linspace(MinValueOpen, MaxValueOpen, length(parula));
    %     for ii = 1:length(HistogramAllUnitsSortedOpen(i,:))
    %         [~, ColorIndOpen] = min(abs(ColorVectorOpen - HistogramAllUnitsSortedOpen(i,ii)));
    %         rectangle('Position', [edgesOpen(ii) ((i-1)/size(HistogramAllUnitsSortedOpen,1)) 1 (1/size(HistogramAllUnitsSortedOpen,1))], 'FaceColor', ColorParula(ColorIndOpen,:), 'EdgeColor', 'none')
    %     end
    % end
    %print -painters -depsc 
    % figure
    % hold on
    % for i = 1:size(HistogramAllUnitsMeanSubtractedSortedOpen,1)
    %     MinValueOpen = min(min(HistogramAllUnitsMeanSubtractedSortedOpen(i,:)));
    %     MaxValueOpen = max(max(HistogramAllUnitsMeanSubtractedSortedOpen(i,:)));
    %     ColorVectorOpen = linspace(MinValueOpen, MaxValueOpen, length(parula));
    %     for ii = 1:length(HistogramAllUnitsMeanSubtractedSortedOpen(i,:))
    %         [~, ColorIndOpen] = min(abs(ColorVectorOpen - HistogramAllUnitsMeanSubtractedSortedOpen(i,ii)));
    %         rectangle('Position', [edgesOpen(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedSortedOpen,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedSortedOpen,1))], 'FaceColor', ColorParula(ColorIndOpen,:), 'EdgeColor', 'none')
    %     end
    % end    
    % print -painters -depsc                 
%     edgesStdOpen = linspace(0,length(HistogramAllUnitsMeanSubtractedCorrOpen),length(HistogramAllUnitsMeanSubtractedCorrOpen)+1);
% 
%     figure
%     hold on
%     for i = 1:size(HistogramAllUnitsMeanSubtractedCorrOpen,1)
%         MinValueOpen = min(min(HistogramAllUnitsMeanSubtractedCorrOpen(i,:)));
%         MaxValueOpen = max(max(HistogramAllUnitsMeanSubtractedCorrOpen(i,:)));
%         ColorVectorOpen = linspace(MinValueOpen, MaxValueOpen, length(parula));
%         for ii = 1:length(HistogramAllUnitsMeanSubtractedCorrOpen(i,:))
%             [~, ColorIndOpen] = min(abs(ColorVectorOpen - HistogramAllUnitsMeanSubtractedCorrOpen(i,ii)));
%             rectangle('Position', [edgesStdOpen(ii) ((i-1)/size(HistogramAllUnitsMeanSubtractedCorrOpen,1)) 1 (1/size(HistogramAllUnitsMeanSubtractedCorrOpen,1))], 'FaceColor', ColorParula(ColorIndOpen,:), 'EdgeColor', 'none')
%         end
%     end
%     print -painters -depsc 



    %plotting Histograms of which time bins the peaks are located mostly for Lever 






    %plotting Histograms of which time bins the peaks are located mostly for Pellet 

    HistogramReach = Results.HistogramLeverMeanSubtractedCorrReach;

    for i = 1:size(HistogramReach,1)
        [~, idxMax(i)] = max(HistogramReach(i,:));
    end

    edgesHistogram = [0:BinSize*150:((After-Before)/BinSize)];
    MeanHistcounts = mean(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));
    StdHistcounts = std(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));

    figure
    histogram(idxMax, edgesHistogram, 'Normalization','probability')
    % hline(MeanHistcounts, 'k-')
    % hline(MeanHistcounts+StdHistcounts, 'k--')
    % hline(MeanHistcounts-StdHistcounts, 'k--')
    
    
    
    
    HistogramReachLateral = Results.HistogramLeverMeanSubtractedCorrReachLateral;

    for i = 1:size(HistogramReachLateral,1)
        [~, idxMax(i)] = max(HistogramReachLateral(i,:));
    end

    edgesHistogram = [0:BinSize*150:((After-Before)/BinSize)];
    MeanHistcounts = mean(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));
    StdHistcounts = std(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));

    figure
    histogram(idxMax, edgesHistogram, 'Normalization','probability')
    % hline(MeanHistcounts, 'k-')
    % hline(MeanHistcounts+StdHistcounts, 'k--')
    % hline(MeanHistcounts-StdHistcounts, 'k--')
    
    
    HistogramReachMedial = Results.HistogramLeverMeanSubtractedCorrReachMedial;

    for i = 1:size(HistogramReachMedial,1)
        [~, idxMax(i)] = max(HistogramReachMedial(i,:));
    end

    edgesHistogram = [0:BinSize*150:((After-Before)/BinSize)];
    MeanHistcounts = mean(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));
    StdHistcounts = std(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));

    figure
    histogram(idxMax, edgesHistogram, 'Normalization','probability')
    % hline(MeanHistcounts, 'k-')
    % hline(MeanHistcounts+StdHistcounts, 'k--')
    % hline(MeanHistcounts-StdHistcounts, 'k--')



    %plotting Histograms of which time bins the peaks are located mostly for Pellet 

    HistogramSpaghetti = Results.HistogramLeverMeanSubtractedCorrSpaghetti;

    for i = 1:size(HistogramSpaghetti,1)
        [~, idxMax(i)] = max(HistogramSpaghetti(i,:));
    end

    edgesHistogram = [0:BinSize*150:((After-Before)/BinSize)];
    MeanHistcounts = mean(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));
    StdHistcounts = std(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));

    figure
    histogram(idxMax, edgesHistogram, 'Normalization','probability')
    % hline(MeanHistcounts, 'k-')
    % hline(MeanHistcounts+StdHistcounts, 'k--')
    % hline(MeanHistcounts-StdHistcounts, 'k--')




    %plotting Histograms of which time bins the peaks are located mostly for
    %Locomotion

    % HistogramOpen = Results.HistogramLeverMeanSubtractedCorrOpen;
    % 
    % for i = 1:size(HistogramOpen,1)
    %     [~, idxMax(i)] = max(HistogramOpen(i,:));
    % end
    % 
    % edgesHistogram = [0:BinSize*100:((After-Before)/BinSize)];
    % MeanHistcounts = mean(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));
    % StdHistcounts = std(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));
    % 
    % figure
    % histogram(idxMax, edgesHistogram, 'Normalization','probability')
    % hline(MeanHistcounts, 'k-')
    % hline(MeanHistcounts+StdHistcounts, 'k--')
    % hline(MeanHistcounts-StdHistcounts, 'k--')
    % 
    % 
    % 
    % %plotting Histograms of which time bins the peaks are located mostly for
    % %Random
    % 
    % HistogramRand = Results.HistogramLeverMeanSubtractedCorrRand;
    % 
    % for i = 1:size(HistogramRand,1)
    %     [~, idxMax(i)] = max(HistogramRand(i,:));
    % end
    % 
    % edgesHistogram = [0:BinSize*100:((After-Before)/BinSize)];
    % MeanHistcounts = mean(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));
    % StdHistcounts = std(histcounts(idxMax, edgesHistogram, 'Normalization','probability'));
    % 
    % figure
    % histogram(idxMax, edgesHistogram, 'Normalization','probability')
    % hline(MeanHistcounts, 'k-')
    % hline(MeanHistcounts+StdHistcounts, 'k--')
    % hline(MeanHistcounts-StdHistcounts, 'k--')
end

                
%the Lever Pressing, Pellet Reaching, Open Field and Random functions used above               
               




function [OpenHist, OpenHistMeanSubtracted, OpenHistMeanSubtractedSingle, OpenHistBaselineStd, OpenSpikeNames, OpenSignificanceHelp, LengthBehaviorOpen] =  FiringPlotOpenHist(data, Before, After, BinSize, FrameRate, FrameDef, SpeedCut)

% This function takes exported Plexon data exported from Neuroexplorer
% reads it and analyzes them according to the Behavior
% (leverpresses in this case). It will return a 1D spike raster plot
% aligned to the lever press, a population average of the firing frequency
% in the same range, and a histogram plot showing the spikes per Bin

%% Data import and selection of Spikes and subsequent writing into cell array

ResultsLever = struct();
% extraction of Spikes by name definition
SpikeList = fieldnames(data);
SpikeList = SpikeList(~~(cellfun(@sum, strfind(SpikeList, 'SPK'))));
SpikeList = cell2mat(SpikeList(~(cellfun(@sum, strfind(SpikeList, '_')))));

SpikeTimes = struct();

% write single spikes into a structure and subsequently transform to a cell
for ii = 1:size(SpikeList,1)
    SpikeTimes.(SpikeList(ii,:)) = data.(SpikeList(ii,:));
end

if ~isfield(data, 'Start')
    data.Start = 0;
end

% Subtract Start variable for frame shift if needed
SpikeNames = fieldnames(SpikeTimes);
OpenSpikeNames = SpikeNames;
SpikeTimesHelp = struct2cell(SpikeTimes);
SpikeTimes = cellfun(@(x) x-data.Start, SpikeTimesHelp, 'Un', 0);
ResultsLever.SpikeTimes = SpikeTimes;

if ~isfield(data, 'Start')
    data.Stop = max(cell2mat(cellfun(@(x) max(x), SpikeTimes, 'Un', 0)));
end


%% Open Field data extraction
% extract Spikes around speed > 10 cm/s, time window defined by Before and
% after - x-y coordinate file needs to be in .xlsx (excel) format, needs
% to terminate on 'cm.xlsx' and needs to be in the same folder as the
% plx-file

% adapt smoothing for frame rate recording -- Ludwig!!
xx = (diff(smooth(data.x))).^2;
yy = (diff(smooth(data.y))).^2;
speed2 = sqrt(xx + yy)*FrameRate;

% cutoff for unreasonable high speeds, delete frame and equalize to one
% frame earlier
for i = 1:length(speed2)
    if speed2(i) > SpeedCut
        if i > 1
            speed2(i) = speed2(i-1);
        else
            speed2(i) = speed2(i+1);
        end
    end
end
speed = speed2;

%divide speed-vector into over under 10 cm/s 
NonRunningEpisodes = find(speed<10);
speed(NonRunningEpisodes)=0; 

%make an array with all locomotor bouts & extract more than 200ms
id = cumsum(speed==0)+1;                  
mask = speed > 0;
Indices1 = ([1:1:length(speed)])';
Indices1(NonRunningEpisodes)=0;
out = accumarray(id(mask),speed(mask),[],@(x) {x});
Indices2 = accumarray(id(mask),Indices1(mask),[],@(x) {x});
out = out(~cellfun('isempty',out));
Indices2 = Indices2(~cellfun('isempty',Indices2));
out = out(cellfun(@sum,out)>0);
Indices2 = Indices2(cellfun(@sum,Indices2)>0);
LocomotorBouts = out(cellfun(@length,out)>= FrameDef);

% LocomotorBoutsIndices = Indices2(cellfun(@length,Indices2)>= FrameDef);
% 
% %sort indices according to high locomotion speeds
% LocomotionStartHelp = cell2mat(cellfun(@(x) x(1), LocomotorBoutsIndices, 'Un', 0));
% LocomotionStart = LocomotionStartHelp(logical([1; diff(LocomotionStartHelp)>200]));        
% LocomotionStopHelp = cell2mat(cellfun(@(x) x(end), LocomotorBoutsIndices, 'Un', 0));
% LocomotionStop = LocomotionStopHelp(logical([1; diff(LocomotionStartHelp)>200]));

if length(LocomotorBouts)> 5
    
    LocomotorBoutsIndices = Indices2(cellfun(@length,Indices2)>= FrameDef);

    %sort indices according to high locomotion speeds
    LocomotionStart = cell2mat(cellfun(@(x) x(1), LocomotorBoutsIndices, 'Un', 0));
    %LocomotionStart = LocomotionStartHelp(logical([1; diff(LocomotionStartHelp)>200]));        
    LocomotionStop = cell2mat(cellfun(@(x) x(end), LocomotorBoutsIndices, 'Un', 0));
    %LocomotionStop = LocomotionStopHelp(logical([1; diff(LocomotionStartHelp)>200]));

    LocomotionStartFrame = round(LocomotionStart);

%calculating speed trajectory for every Locomotor bout
    for pp = 1:length(LocomotionStartFrame)
        SpeedFramesCorr = LocomotionStartFrame(pp)+(Before*FrameRate):LocomotionStartFrame(pp)+(After*FrameRate);
        SpeedFrames(:,pp) = SpeedFramesCorr(2:end)';
        if min(SpeedFramesCorr) < 0
            ToDelete(pp,:) = 0;
        else
            ToDelete(pp,:) = 1;
        end
    end

    ToDelete = ToDelete(~(max(SpeedFrames)>length(speed2)));

    for i = 1:length(ToDelete)
        if ToDelete(i) == 1
            BehaviorSpeed(i,:) = speed2(SpeedFrames(:,i));
        end
    end

    BehaviorSpeed = BehaviorSpeed(logical(ToDelete),:);



    BehaviorSpeedMean = mean(BehaviorSpeed);
    BehaviorSpeedSEM = std(BehaviorSpeed)/sqrt(length(LocomotionStartFrame));

%align spike timepoints to behavior
    BehaviorSpikes = {};
    BehaviorSpikesNorm = {};
    BehaviorTimepoints = LocomotionStart(logical(ToDelete))/FrameRate;
    LocomotionStart = LocomotionStart(logical(ToDelete))/FrameRate;
    LocomotionStop = LocomotionStop(logical(ToDelete))/FrameRate;
    
    

    BaselineStart = -6;
    BaselineEnd = -2;


    for qq = 1:length(SpikeTimes)
        for jj = 1:length(BehaviorTimepoints)
            BehaviorSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+Before)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+(After+BinSize))));
            BehaviorSpikesNorm{qq}{jj} = BehaviorSpikes{qq}{jj}-BehaviorTimepoints(jj);
        end
    end

    for qq = 1:length(SpikeTimes)
        for jj = 1:length(BehaviorTimepoints)
            BaselineSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+BaselineStart)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+BaselineEnd)));
            BaselineSpikesNorm{qq}{jj} = BaselineSpikes{qq}{jj}-BehaviorTimepoints(jj);
        end
    end


    %% plotting


    for kk = 1:length(SpikeNames)
            SpikeIndex = kk;
            BehaviorSpikesNormSel = BehaviorSpikesNorm{SpikeIndex};
            BaselineSpikesNormSel = BaselineSpikesNorm{SpikeIndex};
            edges = [Before:BinSize:After];
            edgesBaseline = [-6:BinSize:-2];
            BehaviorSpikesHist = cellfun(@(x) histcounts(x, edges), BehaviorSpikesNormSel, 'Un', 0);
            BaselineSpikesHist = cellfun(@(x) histcounts(x, edgesBaseline), BaselineSpikesNormSel, 'Un', 0);

            for i = 1:length(BehaviorSpikesHist)
                BehaviorSpikesHistHelp(i,:) = BehaviorSpikesHist{i};
            end
            for i = 1:length(BaselineSpikesHist)
                BaselineSpikesHistHelp(i,:) = BaselineSpikesHist{i};
            end
            
%             BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
%             if length(SpikeTimes{kk}) > 2
%                 edgesBaseline = [min(SpikeTimes{kk}):BinSize:max(SpikeTimes{kk})];
%                 BaselineSpikesHist = histcounts(SpikeTimes{kk}, edgesBaseline);
%                 BaselineSpikesHistMean = mean(BaselineSpikesHist)/BinSize;
%                 BaselineSpikesHistStd = std(BaselineSpikesHist)/BinSize;
%             else
%                 BaselineSpikesHistMean = 0;
%                 BaselineSpikesHistStd = 0;
%             end
        
%             for i = 1:length(BehaviorSpikesHist)
%                 BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean;
%             end

            BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
            BaselineSpikesHistMean = (mean(BaselineSpikesHistHelp,2)/BinSize);
%             BaselineSpikesHistStd = mean((std(BaselineSpikesHistHelp,1)/BinSize));
            BaselineSpikesHistStd = std(BaselineSpikesHistMean);
            for i = 1:length(BaselineSpikesHistMean)
                BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean(i);
            end
            BehaviorSpikesHistMeanSubtractedMean = mean(BehaviorSpikesHistMeanSubtracted);
            OpenHistMeanSubtractedSingle{kk} = BehaviorSpikesHistMeanSubtracted;
            BehaviorLengthHelp = LocomotionStop - LocomotionStart;
            LengthBehaviorOpen{kk} = BehaviorLengthHelp;
            OpenSignificanceHelp(kk) = (sum(sum(BehaviorSpikesHistHelp,2)>3)/size(BehaviorSpikesHistHelp,1))>0.5;
            OpenHist(kk,:) = BehaviorSpikesHistMean;
            OpenHistMeanSubtracted(kk,:) = BehaviorSpikesHistMeanSubtractedMean;
            OpenHistBaselineStd(kk) = (BaselineSpikesHistStd)';
            BehaviorSpikesHistErr = (std(BehaviorSpikesHistHelp)/BinSize)/sqrt(size(BehaviorSpikesHistHelp,1));

            BehaviorSpikesHistDiff = diff(BehaviorSpikesHistHelp,1,2);
    end
else
    OpenHist = [];
    OpenHistMeanSubtracted = [];
    OpenHistBaselineStd = [];
    OpenSignificanceHelp = [];
    OpenHistMeanSubtractedSingle = [];
    LengthBehaviorOpen = [];
end


function [OpenHistRand, OpenHistRandMeanSubtracted, OpenHistRandMeanSubtractedSingle, OpenHistRandBaselineStd, OpenRandSpikeNames, OpenRandSignificanceHelp] =  FiringPlotOpenHistRand(data, Before, After, BinSize, FrameRate, FrameDef, SpeedCut)

% This function takes exported Plexon data exported from Neuroexplorer
% reads it and analyzes them according to the Behavior
% (leverpresses in this case). It will return a 1D spike raster plot
% aligned to the lever press, a population average of the firing frequency
% in the same range, and a histogram plot showing the spikes per Bin

%% Data import and selection of Spikes and subsequent writing into cell array

ResultsLever = struct();
% extraction of Spikes by name definition
SpikeList = fieldnames(data);
SpikeList = SpikeList(~~(cellfun(@sum, strfind(SpikeList, 'SPK'))));
SpikeList = cell2mat(SpikeList(~(cellfun(@sum, strfind(SpikeList, '_')))));

SpikeTimes = struct();

% write single spikes into a structure and subsequently transform to a cell
for ii = 1:size(SpikeList,1)
    SpikeTimes.(SpikeList(ii,:)) = data.(SpikeList(ii,:));
end

if ~isfield(data, 'Start')
    data.Start = 0;
end

% Subtract Start variable for frame shift if needed
SpikeNames = fieldnames(SpikeTimes);
OpenRandSpikeNames = SpikeNames;
SpikeTimesHelp = struct2cell(SpikeTimes);
SpikeTimes = cellfun(@(x) x-data.Start, SpikeTimesHelp, 'Un', 0);
ResultsLever.SpikeTimes = SpikeTimes;

if ~isfield(data, 'Start')
    data.Stop = max(cell2mat(cellfun(@(x) max(x), SpikeTimes, 'Un', 0)));
end


%% Open Field data extraction
% extract Spikes around speed > 10 cm/s, time window defined by Before and
% after - x-y coordinate file needs to be in .xlsx (excel) format, needs
% to terminate on 'cm.xlsx' and needs to be in the same folder as the
% plx-file

% adapt smoothing for frame rate recording -- Ludwig!!
xx = (diff(smooth(data.x))).^2;
yy = (diff(smooth(data.y))).^2;
speed2 = sqrt(xx + yy)*FrameRate;

% cutoff for unreasonable high speeds, delete frame and equalize to one
% frame earlier
for i = 1:length(speed2)
    if speed2(i) > SpeedCut
        if i > 1
            speed2(i) = speed2(i-1);
        else
            speed2(i) = speed2(i+1);
        end
    end
end
speed = speed2;

%divide speed-vector into over under 10 cm/s 
NonRunningEpisodes = find(speed<10);
speed(NonRunningEpisodes)=0; 

%make an array with all locomotor bouts & extract more than 200ms
id = cumsum(speed==0)+1;                  
mask = speed > 0;
Indices1 = ([1:1:length(speed)])';
Indices1(NonRunningEpisodes)=0;
out = accumarray(id(mask),speed(mask),[],@(x) {x});
Indices2 = accumarray(id(mask),Indices1(mask),[],@(x) {x});
out = out(~cellfun('isempty',out));
Indices2 = Indices2(~cellfun('isempty',Indices2));
out = out(cellfun(@sum,out)>0);
Indices2 = Indices2(cellfun(@sum,Indices2)>0);
LocomotorBouts = out(cellfun(@length,out)>= FrameDef);

% LocomotorBoutsIndices = Indices2(cellfun(@length,Indices2)>= FrameDef);
% 
% %sort indices according to high locomotion speeds
% LocomotionStartHelp = cell2mat(cellfun(@(x) x(1), LocomotorBoutsIndices, 'Un', 0));
% LocomotionStart = LocomotionStartHelp(logical([1; diff(LocomotionStartHelp)>200]));        
% LocomotionStopHelp = cell2mat(cellfun(@(x) x(end), LocomotorBoutsIndices, 'Un', 0));
% LocomotionStop = LocomotionStopHelp(logical([1; diff(LocomotionStartHelp)>200]));

if length(LocomotorBouts)> 5
    
    LocomotorBoutsIndices = Indices2(cellfun(@length,Indices2)>= FrameDef);

    %sort indices according to high locomotion speeds
    LocomotionStart = cell2mat(cellfun(@(x) x(1), LocomotorBoutsIndices, 'Un', 0));
    %LocomotionStart = LocomotionStartHelp(logical([1; diff(LocomotionStartHelp)>200]));        
    LocomotionStop = cell2mat(cellfun(@(x) x(end), LocomotorBoutsIndices, 'Un', 0));
    %LocomotionStop = LocomotionStopHelp(logical([1; diff(LocomotionStartHelp)>200]));

    LocomotionStartFrame = round(LocomotionStart);

%calculating speed trajectory for every Locomotor bout
    for pp = 1:length(LocomotionStartFrame)
        SpeedFramesCorr = LocomotionStartFrame(pp)+(Before*FrameRate):LocomotionStartFrame(pp)+(After*FrameRate);
        SpeedFrames(:,pp) = SpeedFramesCorr(2:end)';
        if min(SpeedFramesCorr) < 0
            ToDelete(pp,:) = 0;
        else
            ToDelete(pp,:) = 1;
        end
    end

    ToDelete = ToDelete(~(max(SpeedFrames)>length(speed2)));

    for i = 1:length(ToDelete)
        if ToDelete(i) == 1
            BehaviorSpeed(i,:) = speed2(SpeedFrames(:,i));
        end
    end

    BehaviorSpeed = BehaviorSpeed(logical(ToDelete),:);



    BehaviorSpeedMean = mean(BehaviorSpeed);
    BehaviorSpeedSEM = std(BehaviorSpeed)/sqrt(length(LocomotionStartFrame));

%align spike timepoints to behavior
    BehaviorSpikes = {};
    BehaviorSpikesNorm = {};
    BehaviorTimepoints = 0 + max(cellfun(@max, SpikeTimes))*rand(length(LocomotionStart),1);
    %BehaviorTimepoints = LocomotionStart(logical(ToDelete))/FrameRate;
    LocomotionStart = LocomotionStart(logical(ToDelete))/FrameRate;
    LocomotionStop = LocomotionStop(logical(ToDelete))/FrameRate;

    BaselineStart = -6;
    BaselineEnd = -2;


    for qq = 1:length(SpikeTimes)
        for jj = 1:length(BehaviorTimepoints)
            BehaviorSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+Before)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+(After+BinSize))));
            BehaviorSpikesNorm{qq}{jj} = BehaviorSpikes{qq}{jj}-BehaviorTimepoints(jj);
        end
    end

    for qq = 1:length(SpikeTimes)
        for jj = 1:length(BehaviorTimepoints)
            BaselineSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+BaselineStart)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+BaselineEnd)));
            BaselineSpikesNorm{qq}{jj} = BaselineSpikes{qq}{jj}-BehaviorTimepoints(jj);
        end
    end


    %% plotting


    for kk = 1:length(SpikeNames)
            SpikeIndex = kk;
            BehaviorSpikesNormSel = BehaviorSpikesNorm{SpikeIndex};
            BaselineSpikesNormSel = BaselineSpikesNorm{SpikeIndex};
            edges = [Before:BinSize:After];
            edgesBaseline = [-6:BinSize:-2];
            BehaviorSpikesHist = cellfun(@(x) histcounts(x, edges), BehaviorSpikesNormSel, 'Un', 0);
            BaselineSpikesHist = cellfun(@(x) histcounts(x, edgesBaseline), BaselineSpikesNormSel, 'Un', 0);

            for i = 1:length(BehaviorSpikesHist)
                BehaviorSpikesHistHelp(i,:) = BehaviorSpikesHist{i};
            end
            for i = 1:length(BaselineSpikesHist)
                BaselineSpikesHistHelp(i,:) = BaselineSpikesHist{i};
            end
            
%             BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
%             if length(SpikeTimes{kk}) > 2
%                 edgesBaseline = [min(SpikeTimes{kk}):BinSize:max(SpikeTimes{kk})];
%                 BaselineSpikesHist = histcounts(SpikeTimes{kk}, edgesBaseline);
%                 BaselineSpikesHistMean = mean(BaselineSpikesHist)/BinSize;
%                 BaselineSpikesHistStd = std(BaselineSpikesHist)/BinSize;
%             else
%                 BaselineSpikesHistMean = 0;
%                 BaselineSpikesHistStd = 0;
%             end
        
%             for i = 1:length(BehaviorSpikesHist)
%                 BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean;
%             end

            BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
            BaselineSpikesHistMean = (mean(BaselineSpikesHistHelp,2)/BinSize);
%             BaselineSpikesHistStd = mean((std(BaselineSpikesHistHelp,1)/BinSize));
            BaselineSpikesHistStd = std(BaselineSpikesHistMean);
            for i = 1:length(BaselineSpikesHistMean)
                BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean(i);
            end
            BehaviorSpikesHistMeanSubtractedMean = mean(BehaviorSpikesHistMeanSubtracted);
            OpenHistRandMeanSubtractedSingle{kk} = BehaviorSpikesHistMeanSubtracted;
            OpenRandSignificanceHelp(kk) = (sum(sum(BehaviorSpikesHistHelp,2)>3)/size(BehaviorSpikesHistHelp,1))>0.5;
            OpenHistRand(kk,:) = BehaviorSpikesHistMean;
            OpenHistRandMeanSubtracted(kk,:) = BehaviorSpikesHistMeanSubtractedMean;
            OpenHistRandBaselineStd(kk) = (BaselineSpikesHistStd)';
            BehaviorSpikesHistErr = (std(BehaviorSpikesHistHelp)/BinSize)/sqrt(size(BehaviorSpikesHistHelp,1));

            BehaviorSpikesHistDiff = diff(BehaviorSpikesHistHelp,1,2);
    end
else
    OpenHistRand = [];
    OpenHistRandMeanSubtracted = [];
    OpenHistRandBaselineStd = [];
    OpenRandSignificanceHelp = [];
    OpenHistRandMeanSubtractedSingle = [];
end






function [ReachHist, ReachHistMeanSubtracted, ReachHistMeanSubtractedSingle, ReachHistBaselineStd, ReachSpikeNames, SignificanceHelpReach, LengthBehaviorReach, BehaviorSpikesNorm] =  FiringPlotReachHistLateral(data, Before, After, BinSize, Alignment)

% This function takes exported Plexon data exported from Neuroexplorer
% reads it and analyzes them according to the Behavior
% (leverpresses in this case). It will return a 1D spike raster plot
% aligned to the lever press, a population average of the firing frequency
% in the same range, and a histogram plot showing the spikes per Bin

%% Data import and selection of Spikes and subsequent writing into cell array
if isempty(data)
    ReachHist = [];
    ReachHistMeanSubtracted = [];
    ReachHistBaselineStd = [];
    return
end

ResultsLever = struct();
% extraction of Spikes by name definition
SpikeList = fieldnames(data);
SpikeList = SpikeList(~~(cellfun(@sum, strfind(SpikeList, 'SPK'))));
SpikeList = SpikeList(~(cellfun(@sum, strfind(SpikeList, 'i'))));
SpikeList = cell2mat(SpikeList(~(cellfun(@sum, strfind(SpikeList, '_')))));

SpikeTimes = struct();

% write single spikes into a structure and subsequently transform to a cell
for ii = 1:size(SpikeList,1)
    SpikeTimes.(SpikeList(ii,:)) = data.(SpikeList(ii,:));
end

if ~isfield(data, 'Start')
    data.Start = 0;
end

% Subtract Start variable for frame shift if needed
SpikeNames = fieldnames(SpikeTimes);
ReachSpikeNames = SpikeNames;
SpikeTimesHelp = struct2cell(SpikeTimes);
SpikeTimes = cellfun(@(x) x-data.Start, SpikeTimesHelp, 'Un', 0);
ResultsLever.SpikeTimes = SpikeTimes;

if ~isfield(data, 'Start')
    data.Stop = max(cell2mat(cellfun(@(x) max(x), SpikeTimes, 'Un', 0)));
end


%find only the primary Leverpresses (not secondary leverpresses)


if isfield(data, 'ReachingStartLateral')
    for ii = 1:length(data.ReachingStart)
        if ~~sum(~(data.ReachingStart(ii)-data.ReachingStartLateral))
            LateralSelect(ii) = 1;
        else
            LateralSelect(ii) = 0;
        end
    end
end

ReachingStartAll = data.ReachingStart(logical(LateralSelect));  
LeverOnAll = data.FingerSpread(logical(LateralSelect));
LeverOffAll = data.FingerClose(logical(LateralSelect));
RetractEndAll = data.RetractEnd(logical(LateralSelect));




%align spike timepoints to behavior
BehaviorSpikes = {};
BehaviorSpikesNorm = {};
if Alignment == 1
    BehaviorTimepoints = ReachingStartAll;
elseif Alignment == 2
    BehaviorTimepoints = ReachingStartAll;
elseif Alignment == 3
    BehaviorTimepoints = LeverOnAll;
elseif Alignment == 4
    BehaviorTimepoints = LeverOffAll;
elseif Alignment == 5
    BehaviorTimepoints = RetractEndAll;
end

BaselineStart = -6;
BaselineEnd = -2;

for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BehaviorSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+Before)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+After)));
        BehaviorSpikesNorm{qq}{jj} = BehaviorSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BaselineSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+BaselineStart)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+BaselineEnd)));
        BaselineSpikesNorm{qq}{jj} = BaselineSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


%% plotting
%figure

for kk = 1:length(SpikeNames)
        SpikeIndex = kk;
        BehaviorSpikesNormSel = BehaviorSpikesNorm{SpikeIndex};
        BaselineSpikesNormSel = BaselineSpikesNorm{SpikeIndex};
        edges = [Before:BinSize:After];
        edgesBaseline = [-6:BinSize:-2];
        BehaviorSpikesHist = cellfun(@(x) histcounts(x, edges), BehaviorSpikesNormSel, 'Un', 0);
        BaselineSpikesHist = cellfun(@(x) histcounts(x, edgesBaseline), BaselineSpikesNormSel, 'Un', 0);
        
        for i = 1:length(BehaviorSpikesHist)
            BehaviorSpikesHistHelp(i,:) = BehaviorSpikesHist{i};
        end
        for i = 1:length(BaselineSpikesHist)
            BaselineSpikesHistHelp(i,:) = BaselineSpikesHist{i};
        end
        
        
%         BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
%         if length(SpikeTimes{kk}) > 2
%             edgesBaseline = [min(SpikeTimes{kk}):BinSize:max(SpikeTimes{kk})];
%             BaselineSpikesHist = histcounts(SpikeTimes{kk}, edgesBaseline);
%             BaselineSpikesHistMean = mean(BaselineSpikesHist)/BinSize;
%             BaselineSpikesHistStd = std(BaselineSpikesHist)/BinSize;
%         else
%             BaselineSpikesHistMean = 0;
%             BaselineSpikesHistStd = 0;
%         end
%         
%         
%         for i = 1:length(BehaviorSpikesHist)
%             BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean;
%         end
        
        BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
        BaselineSpikesHistMean = (mean(BaselineSpikesHistHelp,2)/BinSize);
%         BaselineSpikesHistStd = mean((std(BaselineSpikesHistHelp,1)/BinSize));
        BaselineSpikesHistStd = std(BaselineSpikesHistMean);
        for i = 1:length(BaselineSpikesHistMean)
            BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean(i);
        end
        BehaviorSpikesHistMeanSubtractedMean = mean(BehaviorSpikesHistMeanSubtracted);
        ReachHistMeanSubtractedSingle{kk} = BehaviorSpikesHistMeanSubtracted;
        LengthBehaviorHelp = RetractEndAll - ReachingStartAll;
        LengthBehaviorHelp2 = LeverOffAll - ReachingStartAll;
        LengthBehaviorHelp3 = LeverOnAll - ReachingStartAll;
        LengthBehaviorReach{kk} = [LengthBehaviorHelp LengthBehaviorHelp2 LengthBehaviorHelp3];
        SignificanceHelpReach(kk) = (sum(sum(BehaviorSpikesHistHelp,2)>3)/size(BehaviorSpikesHistHelp,1))>0.5;
        ReachHist(kk,:) = BehaviorSpikesHistMean;
        ReachHistMeanSubtracted(kk,:) = BehaviorSpikesHistMeanSubtractedMean;
        ReachHistBaselineStd(kk) = (BaselineSpikesHistStd)';
        BehaviorSpikesHistErr = (std(BehaviorSpikesHistHelp)/BinSize)/sqrt(size(BehaviorSpikesHistHelp,1));

        BehaviorSpikesHistDiff = diff(BehaviorSpikesHistHelp,1,2);
end 


function [ReachHist, ReachHistMeanSubtracted, ReachHistMeanSubtractedSingle, ReachHistBaselineStd, ReachSpikeNames, SignificanceHelpReach, LengthBehaviorReach, BehaviorSpikesNorm] =  FiringPlotReachHistMedial(data, Before, After, BinSize, Alignment)

% This function takes exported Plexon data exported from Neuroexplorer
% reads it and analyzes them according to the Behavior
% (leverpresses in this case). It will return a 1D spike raster plot
% aligned to the lever press, a population average of the firing frequency
% in the same range, and a histogram plot showing the spikes per Bin

%% Data import and selection of Spikes and subsequent writing into cell array
if isempty(data)
    ReachHist = [];
    ReachHistMeanSubtracted = [];
    ReachHistBaselineStd = [];
    return
end

ResultsLever = struct();
% extraction of Spikes by name definition
SpikeList = fieldnames(data);
SpikeList = SpikeList(~~(cellfun(@sum, strfind(SpikeList, 'SPK'))));
SpikeList = SpikeList(~(cellfun(@sum, strfind(SpikeList, 'i'))));
SpikeList = cell2mat(SpikeList(~(cellfun(@sum, strfind(SpikeList, '_')))));

SpikeTimes = struct();

% write single spikes into a structure and subsequently transform to a cell
for ii = 1:size(SpikeList,1)
    SpikeTimes.(SpikeList(ii,:)) = data.(SpikeList(ii,:));
end

if ~isfield(data, 'Start')
    data.Start = 0;
end

% Subtract Start variable for frame shift if needed
SpikeNames = fieldnames(SpikeTimes);
ReachSpikeNames = SpikeNames;
SpikeTimesHelp = struct2cell(SpikeTimes);
SpikeTimes = cellfun(@(x) x-data.Start, SpikeTimesHelp, 'Un', 0);
ResultsLever.SpikeTimes = SpikeTimes;

if ~isfield(data, 'Start')
    data.Stop = max(cell2mat(cellfun(@(x) max(x), SpikeTimes, 'Un', 0)));
end


%find only the primary Leverpresses (not secondary leverpresses)


if isfield(data, 'ReachingStartMedial')
    for ii = 1:length(data.ReachingStart)
        if ~~sum(~(data.ReachingStart(ii)-data.ReachingStartMedial))
            LateralSelect(ii) = 1;
        else
            LateralSelect(ii) = 0;
        end
    end
end

ReachingStartAll = data.ReachingStart(logical(LateralSelect));  
LeverOnAll = data.FingerSpread(logical(LateralSelect));
LeverOffAll = data.FingerClose(logical(LateralSelect));
RetractEndAll = data.RetractEnd(logical(LateralSelect));




%align spike timepoints to behavior
BehaviorSpikes = {};
BehaviorSpikesNorm = {};
if Alignment == 1
    BehaviorTimepoints = ReachingStartAll;
elseif Alignment == 2
    BehaviorTimepoints = ReachingStartAll;
elseif Alignment == 3
    BehaviorTimepoints = LeverOnAll;
elseif Alignment == 4
    BehaviorTimepoints = LeverOffAll;
elseif Alignment == 5
    BehaviorTimepoints = RetractEndAll;
end

BaselineStart = -6;
BaselineEnd = -2;

for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BehaviorSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+Before)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+After)));
        BehaviorSpikesNorm{qq}{jj} = BehaviorSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BaselineSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+BaselineStart)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+BaselineEnd)));
        BaselineSpikesNorm{qq}{jj} = BaselineSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


%% plotting
%figure

for kk = 1:length(SpikeNames)
        SpikeIndex = kk;
        BehaviorSpikesNormSel = BehaviorSpikesNorm{SpikeIndex};
        BaselineSpikesNormSel = BaselineSpikesNorm{SpikeIndex};
        edges = [Before:BinSize:After];
        edgesBaseline = [-6:BinSize:-2];
        BehaviorSpikesHist = cellfun(@(x) histcounts(x, edges), BehaviorSpikesNormSel, 'Un', 0);
        BaselineSpikesHist = cellfun(@(x) histcounts(x, edgesBaseline), BaselineSpikesNormSel, 'Un', 0);
        
        for i = 1:length(BehaviorSpikesHist)
            BehaviorSpikesHistHelp(i,:) = BehaviorSpikesHist{i};
        end
        for i = 1:length(BaselineSpikesHist)
            BaselineSpikesHistHelp(i,:) = BaselineSpikesHist{i};
        end
        
        
%         BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
%         if length(SpikeTimes{kk}) > 2
%             edgesBaseline = [min(SpikeTimes{kk}):BinSize:max(SpikeTimes{kk})];
%             BaselineSpikesHist = histcounts(SpikeTimes{kk}, edgesBaseline);
%             BaselineSpikesHistMean = mean(BaselineSpikesHist)/BinSize;
%             BaselineSpikesHistStd = std(BaselineSpikesHist)/BinSize;
%         else
%             BaselineSpikesHistMean = 0;
%             BaselineSpikesHistStd = 0;
%         end
%         
%         
%         for i = 1:length(BehaviorSpikesHist)
%             BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean;
%         end
        
        BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
        BaselineSpikesHistMean = (mean(BaselineSpikesHistHelp,2)/BinSize);
%         BaselineSpikesHistStd = mean((std(BaselineSpikesHistHelp,1)/BinSize));
        BaselineSpikesHistStd = std(BaselineSpikesHistMean);
        for i = 1:length(BaselineSpikesHistMean)
            BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean(i);
        end
        BehaviorSpikesHistMeanSubtractedMean = mean(BehaviorSpikesHistMeanSubtracted);
        ReachHistMeanSubtractedSingle{kk} = BehaviorSpikesHistMeanSubtracted;
        LengthBehaviorHelp = RetractEndAll - ReachingStartAll;
        LengthBehaviorHelp2 = LeverOffAll - ReachingStartAll;
        LengthBehaviorHelp3 = LeverOnAll - ReachingStartAll;
        LengthBehaviorReach{kk} = [LengthBehaviorHelp LengthBehaviorHelp2 LengthBehaviorHelp3];
        SignificanceHelpReach(kk) = (sum(sum(BehaviorSpikesHistHelp,2)>3)/size(BehaviorSpikesHistHelp,1))>0.5;
        ReachHist(kk,:) = BehaviorSpikesHistMean;
        ReachHistMeanSubtracted(kk,:) = BehaviorSpikesHistMeanSubtractedMean;
        ReachHistBaselineStd(kk) = (BaselineSpikesHistStd)';
        BehaviorSpikesHistErr = (std(BehaviorSpikesHistHelp)/BinSize)/sqrt(size(BehaviorSpikesHistHelp,1));

        BehaviorSpikesHistDiff = diff(BehaviorSpikesHistHelp,1,2);
end 



function [ReachHistRand, ReachHistRandMeanSubtracted, ReachHistRandMeanSubtractedSingle, ReachHistRandBaselineStd, ReachRandSpikeNames, SignificanceHelpReachRand, BehaviorSpikesNorm] =  FiringPlotReachHistRand(data, Before, After, BinSize)

% This function takes exported Plexon data exported from Neuroexplorer
% reads it and analyzes them according to the Behavior
% (leverpresses in this case). It will return a 1D spike raster plot
% aligned to the lever press, a population average of the firing frequency
% in the same range, and a histogram plot showing the spikes per Bin

%% Data import and selection of Spikes and subsequent writing into cell array
if isempty(data)
    ReachHistRand = [];
    ReachHistRandMeanSubtracted = [];
    ReachHistRandBaselineStd = [];
    return
end

ResultsLever = struct();
% extraction of Spikes by name definition
SpikeList = fieldnames(data);
SpikeList = SpikeList(~~(cellfun(@sum, strfind(SpikeList, 'SPK'))));
SpikeList = SpikeList(~(cellfun(@sum, strfind(SpikeList, 'i'))));
SpikeList = cell2mat(SpikeList(~(cellfun(@sum, strfind(SpikeList, '_')))));

SpikeTimes = struct();

% write single spikes into a structure and subsequently transform to a cell
for ii = 1:size(SpikeList,1)
    SpikeTimes.(SpikeList(ii,:)) = data.(SpikeList(ii,:));
end

if ~isfield(data, 'Start')
    data.Start = 0;
end

% Subtract Start variable for frame shift if needed
SpikeNames = fieldnames(SpikeTimes);
ReachRandSpikeNames = SpikeNames;
SpikeTimesHelp = struct2cell(SpikeTimes);
SpikeTimes = cellfun(@(x) x-data.Start, SpikeTimesHelp, 'Un', 0);
ResultsLever.SpikeTimes = SpikeTimes;

if ~isfield(data, 'Start')
    data.Stop = max(cell2mat(cellfun(@(x) max(x), SpikeTimes, 'Un', 0)));
end


%find only the primary Leverpresses (not secondary leverpresses)

ReachingStartAll = data.ReachingStart;
LeverOnAll = data.FingerSpread;
LeverOffAll = data.FingerClose;
RetractEndAll = data.RetractEnd;




%align spike timepoints to behavior
BehaviorSpikes = {};
BehaviorSpikesNorm = {};
BehaviorTimepoints = 0 + max(cellfun(@max, SpikeTimes))*rand(length(ReachingStartAll),1);

BaselineStart = -6;
BaselineEnd = -2;

for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BehaviorSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+Before)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+After)));
        BehaviorSpikesNorm{qq}{jj} = BehaviorSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BaselineSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+BaselineStart)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+BaselineEnd)));
        BaselineSpikesNorm{qq}{jj} = BaselineSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


%% plotting
%figure

for kk = 1:length(SpikeNames)
        SpikeIndex = kk;
        BehaviorSpikesNormSel = BehaviorSpikesNorm{SpikeIndex};
        BaselineSpikesNormSel = BaselineSpikesNorm{SpikeIndex};
        edges = [Before:BinSize:After];
        edgesBaseline = [-6:BinSize:-2];
        BehaviorSpikesHist = cellfun(@(x) histcounts(x, edges), BehaviorSpikesNormSel, 'Un', 0);
        BaselineSpikesHist = cellfun(@(x) histcounts(x, edgesBaseline), BaselineSpikesNormSel, 'Un', 0);
        
        for i = 1:length(BehaviorSpikesHist)
            BehaviorSpikesHistHelp(i,:) = BehaviorSpikesHist{i};
        end
        for i = 1:length(BaselineSpikesHist)
            BaselineSpikesHistHelp(i,:) = BaselineSpikesHist{i};
        end
        
        
%         BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
%         if length(SpikeTimes{kk}) > 2
%             edgesBaseline = [min(SpikeTimes{kk}):BinSize:max(SpikeTimes{kk})];
%             BaselineSpikesHist = histcounts(SpikeTimes{kk}, edgesBaseline);
%             BaselineSpikesHistMean = mean(BaselineSpikesHist)/BinSize;
%             BaselineSpikesHistStd = std(BaselineSpikesHist)/BinSize;
%         else
%             BaselineSpikesHistMean = 0;
%             BaselineSpikesHistStd = 0;
%         end
%         
%         
%         for i = 1:length(BehaviorSpikesHist)
%             BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean;
%         end
        
        BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
        BaselineSpikesHistMean = (mean(BaselineSpikesHistHelp,2)/BinSize);
%         BaselineSpikesHistStd = mean((std(BaselineSpikesHistHelp,1)/BinSize));
        BaselineSpikesHistStd = std(BaselineSpikesHistMean);
        for i = 1:length(BaselineSpikesHistMean)
            BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean(i);
        end
        BehaviorSpikesHistMeanSubtractedMean = mean(BehaviorSpikesHistMeanSubtracted);
        ReachHistRandMeanSubtractedSingle{kk} = BehaviorSpikesHistMeanSubtracted;
        SignificanceHelpReachRand(kk) = (sum(sum(BehaviorSpikesHistHelp,2)>3)/size(BehaviorSpikesHistHelp,1))>0.5;
        ReachHistRand(kk,:) = BehaviorSpikesHistMean;
        ReachHistRandMeanSubtracted(kk,:) = BehaviorSpikesHistMeanSubtractedMean;
        ReachHistRandBaselineStd(kk) = (BaselineSpikesHistStd)';
        BehaviorSpikesHistErr = (std(BehaviorSpikesHistHelp)/BinSize)/sqrt(size(BehaviorSpikesHistHelp,1));

        BehaviorSpikesHistDiff = diff(BehaviorSpikesHistHelp,1,2);
end



function [SpaghettiHist, SpaghettiHistMeanSubtracted, SpaghettiHistMeanSubtractedSingle, SpaghettiHistBaselineStd, SpaghettiSpikeNames, SignificanceHelpSpaghetti, LengthBehaviorSpaghetti] =  FiringPlotSpaghettiHist(data, Before, After, BinSize)

% This function takes exported Plexon data exported from Neuroexplorer
% reads it and analyzes them according to the Behavior
% (leverpresses in this case). It will return a 1D spike raster plot
% aligned to the lever press, a population average of the firing frequency
% in the same range, and a histogram plot showing the spikes per Bin

%% Data import and selection of Spikes and subsequent writing into cell array
if isempty(data)
    SpaghettiHist = [];
    SpaghettiHistMeanSubtracted = [];
    SpaghettiHistBaselineStd = [];
    return
end

ResultsLever = struct();
% extraction of Spikes by name definition
SpikeList = fieldnames(data);
SpikeList = SpikeList(~~(cellfun(@sum, strfind(SpikeList, 'SPK'))));
SpikeList = cell2mat(SpikeList(~(cellfun(@sum, strfind(SpikeList, '_')))));

SpikeTimes = struct();

% write single spikes into a structure and subsequently transform to a cell
for ii = 1:size(SpikeList,1)
    SpikeTimes.(SpikeList(ii,:)) = data.(SpikeList(ii,:));
end

if ~isfield(data, 'Start')
    data.Start = 0;
end

% Subtract Start variable for frame shift if needed
SpikeNames = fieldnames(SpikeTimes);
SpaghettiSpikeNames = SpikeNames;
SpikeTimesHelp = struct2cell(SpikeTimes);
SpikeTimes = cellfun(@(x) x-data.Start, SpikeTimesHelp, 'Un', 0);
ResultsLever.SpikeTimes = SpikeTimes;

if ~isfield(data, 'Start')
    data.Stop = max(cell2mat(cellfun(@(x) max(x), SpikeTimes, 'Un', 0)));
end


%find only the primary Leverpresses (not secondary leverpresses)


if isfield(data, 'SpaghettiHandsOn')
    SpaghettiStartAll = data.SpaghettiHandsOn;
    SpaghettiEndAll = data.SpaghettiHandsOff;
elseif isfield(data, 'EatOn')
    SpaghettiStartAll = data.EatOn;
    SpaghettiEndAll = data.EatOff;
end



%align spike timepoints to behavior
BehaviorSpikes = {};
BehaviorSpikesNorm = {};
BehaviorTimepoints = SpaghettiStartAll;

BaselineStart = -6;
BaselineEnd = -2;

for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BehaviorSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+Before)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+After)));
        BehaviorSpikesNorm{qq}{jj} = BehaviorSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BaselineSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+BaselineStart)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+BaselineEnd)));
        BaselineSpikesNorm{qq}{jj} = BaselineSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


%% plotting
%figure

for kk = 1:length(SpikeNames)
        SpikeIndex = kk;
        BehaviorSpikesNormSel = BehaviorSpikesNorm{SpikeIndex};
        BaselineSpikesNormSel = BaselineSpikesNorm{SpikeIndex};
        edges = [Before:BinSize:After];
        edgesBaseline = [-6:BinSize:-2];
        BehaviorSpikesHist = cellfun(@(x) histcounts(x, edges), BehaviorSpikesNormSel, 'Un', 0);
        BaselineSpikesHist = cellfun(@(x) histcounts(x, edgesBaseline), BaselineSpikesNormSel, 'Un', 0);
        
        for i = 1:length(BehaviorSpikesHist)
            BehaviorSpikesHistHelp(i,:) = BehaviorSpikesHist{i};
        end
        for i = 1:length(BaselineSpikesHist)
            BaselineSpikesHistHelp(i,:) = BaselineSpikesHist{i};
        end
        
        
%         BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
%         if length(SpikeTimes{kk}) > 2
%             edgesBaseline = [min(SpikeTimes{kk}):BinSize:max(SpikeTimes{kk})];
%             BaselineSpikesHist = histcounts(SpikeTimes{kk}, edgesBaseline);
%             BaselineSpikesHistMean = mean(BaselineSpikesHist)/BinSize;
%             BaselineSpikesHistStd = std(BaselineSpikesHist)/BinSize;
%         else
%             BaselineSpikesHistMean = 0;
%             BaselineSpikesHistStd = 0;
%         end
%         
%         
%         for i = 1:length(BehaviorSpikesHist)
%             BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean;
%         end
        
        BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
        BaselineSpikesHistMean = (mean(BaselineSpikesHistHelp,2)/BinSize);
%         BaselineSpikesHistStd = mean((std(BaselineSpikesHistHelp,1)/BinSize));
        BaselineSpikesHistStd = std(BaselineSpikesHistMean);
        for i = 1:length(BaselineSpikesHistMean)
            BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean(i);
        end
        BehaviorSpikesHistMeanSubtractedMean = mean(BehaviorSpikesHistMeanSubtracted);
        SpaghettiHistMeanSubtractedSingle{kk} = BehaviorSpikesHistMeanSubtracted;
        LengthBehaviorHelp = SpaghettiEndAll - SpaghettiStartAll;
        LengthBehaviorSpaghetti{kk} = LengthBehaviorHelp;
        SignificanceHelpSpaghetti(kk) = (sum(sum(BehaviorSpikesHistHelp,2)>3)/size(BehaviorSpikesHistHelp,1))>0.5;
        SpaghettiHist(kk,:) = BehaviorSpikesHistMean;
        SpaghettiHistMeanSubtracted(kk,:) = BehaviorSpikesHistMeanSubtractedMean;
        SpaghettiHistBaselineStd(kk) = (BaselineSpikesHistStd)';
        BehaviorSpikesHistErr = (std(BehaviorSpikesHistHelp)/BinSize)/sqrt(size(BehaviorSpikesHistHelp,1));

        BehaviorSpikesHistDiff = diff(BehaviorSpikesHistHelp,1,2);
end  





function [SpaghettiHist, SpaghettiHistMeanSubtracted, SpaghettiHistMeanSubtractedSingle, SpaghettiHistBaselineStd, SpaghettiSpikeNames, SignificanceHelpSpaghetti, LengthBehaviorSpaghetti] =  FiringPlotSpaghettiHistRand(data, Before, After, BinSize)

% This function takes exported Plexon data exported from Neuroexplorer
% reads it and analyzes them according to the Behavior
% (leverpresses in this case). It will return a 1D spike raster plot
% aligned to the lever press, a population average of the firing frequency
% in the same range, and a histogram plot showing the spikes per Bin

%% Data import and selection of Spikes and subsequent writing into cell array
if isempty(data)
    SpaghettiHist = [];
    SpaghettiHistMeanSubtracted = [];
    SpaghettiHistBaselineStd = [];
    return
end

ResultsLever = struct();
% extraction of Spikes by name definition
SpikeList = fieldnames(data);
SpikeList = SpikeList(~~(cellfun(@sum, strfind(SpikeList, 'SPK'))));
SpikeList = cell2mat(SpikeList(~(cellfun(@sum, strfind(SpikeList, '_')))));

SpikeTimes = struct();

% write single spikes into a structure and subsequently transform to a cell
for ii = 1:size(SpikeList,1)
    SpikeTimes.(SpikeList(ii,:)) = data.(SpikeList(ii,:));
end

if ~isfield(data, 'Start')
    data.Start = 0;
end

% Subtract Start variable for frame shift if needed
SpikeNames = fieldnames(SpikeTimes);
SpaghettiSpikeNames = SpikeNames;
SpikeTimesHelp = struct2cell(SpikeTimes);
SpikeTimes = cellfun(@(x) x-data.Start, SpikeTimesHelp, 'Un', 0);
ResultsLever.SpikeTimes = SpikeTimes;

if ~isfield(data, 'Start')
    data.Stop = max(cell2mat(cellfun(@(x) max(x), SpikeTimes, 'Un', 0)));
end


%find only the primary Leverpresses (not secondary leverpresses)


if isfield(data, 'SpaghettiHandsOn')
    SpaghettiStartAll = data.SpaghettiHandsOn;
    SpaghettiEndAll = data.SpaghettiHandsOff;
elseif isfield(data, 'EatOn')
    SpaghettiStartAll = data.EatOn;
    SpaghettiEndAll = data.EatOff;
end



%align spike timepoints to behavior
BehaviorSpikes = {};
BehaviorSpikesNorm = {};
BehaviorTimepoints = 0 + max(cellfun(@max, SpikeTimes))*rand(length(SpaghettiStartAll),1);

BaselineStart = -6;
BaselineEnd = -2;

for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BehaviorSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+Before)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+After)));
        BehaviorSpikesNorm{qq}{jj} = BehaviorSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


for qq = 1:length(SpikeTimes)
    for jj = 1:length(BehaviorTimepoints)
        BaselineSpikes{qq}{jj} = SpikeTimes{qq}(~~(SpikeTimes{qq}>(BehaviorTimepoints(jj)+BaselineStart)&SpikeTimes{qq}<(BehaviorTimepoints(jj)+BaselineEnd)));
        BaselineSpikesNorm{qq}{jj} = BaselineSpikes{qq}{jj}-BehaviorTimepoints(jj);
    end
end


%% plotting
%figure

for kk = 1:length(SpikeNames)
        SpikeIndex = kk;
        BehaviorSpikesNormSel = BehaviorSpikesNorm{SpikeIndex};
        BaselineSpikesNormSel = BaselineSpikesNorm{SpikeIndex};
        edges = [Before:BinSize:After];
        edgesBaseline = [-6:BinSize:-2];
        BehaviorSpikesHist = cellfun(@(x) histcounts(x, edges), BehaviorSpikesNormSel, 'Un', 0);
        BaselineSpikesHist = cellfun(@(x) histcounts(x, edgesBaseline), BaselineSpikesNormSel, 'Un', 0);
        
        for i = 1:length(BehaviorSpikesHist)
            BehaviorSpikesHistHelp(i,:) = BehaviorSpikesHist{i};
        end
        for i = 1:length(BaselineSpikesHist)
            BaselineSpikesHistHelp(i,:) = BaselineSpikesHist{i};
        end
        
        
%         BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
%         if length(SpikeTimes{kk}) > 2
%             edgesBaseline = [min(SpikeTimes{kk}):BinSize:max(SpikeTimes{kk})];
%             BaselineSpikesHist = histcounts(SpikeTimes{kk}, edgesBaseline);
%             BaselineSpikesHistMean = mean(BaselineSpikesHist)/BinSize;
%             BaselineSpikesHistStd = std(BaselineSpikesHist)/BinSize;
%         else
%             BaselineSpikesHistMean = 0;
%             BaselineSpikesHistStd = 0;
%         end
%         
%         
%         for i = 1:length(BehaviorSpikesHist)
%             BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean;
%         end
        
        BehaviorSpikesHistMean = mean(BehaviorSpikesHistHelp)/BinSize;
        BaselineSpikesHistMean = (mean(BaselineSpikesHistHelp,2)/BinSize);
%         BaselineSpikesHistStd = mean((std(BaselineSpikesHistHelp,1)/BinSize));
        BaselineSpikesHistStd = std(BaselineSpikesHistMean);
        for i = 1:length(BaselineSpikesHistMean)
            BehaviorSpikesHistMeanSubtracted(i,:) = (BehaviorSpikesHistHelp(i,:)/BinSize) - BaselineSpikesHistMean(i);
        end
        BehaviorSpikesHistMeanSubtractedMean = mean(BehaviorSpikesHistMeanSubtracted);
        SpaghettiHistMeanSubtractedSingle{kk} = BehaviorSpikesHistMeanSubtracted;
        LengthBehaviorHelp = SpaghettiEndAll - SpaghettiStartAll;
        LengthBehaviorSpaghetti{kk} = LengthBehaviorHelp;
        SignificanceHelpSpaghetti(kk) = (sum(sum(BehaviorSpikesHistHelp,2)>3)/size(BehaviorSpikesHistHelp,1))>0.5;
        SpaghettiHist(kk,:) = BehaviorSpikesHistMean;
        SpaghettiHistMeanSubtracted(kk,:) = BehaviorSpikesHistMeanSubtractedMean;
        SpaghettiHistBaselineStd(kk) = (BaselineSpikesHistStd)';
        BehaviorSpikesHistErr = (std(BehaviorSpikesHistHelp)/BinSize)/sqrt(size(BehaviorSpikesHistHelp,1));

        BehaviorSpikesHistDiff = diff(BehaviorSpikesHistHelp,1,2);
end



