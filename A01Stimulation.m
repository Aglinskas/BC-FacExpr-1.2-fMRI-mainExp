function A01Stimulation(subID,runID)
% Runs synthetic expressions main experiment fMRI stimulation
% Experimental variables:
% 6 Runs
% 2 second long videos
% 10 for each emotion label (anger, sadness, fear, disgust, surprise, happiness, neutral)
% videos presented in randomized order
% button press during a neutral video
% 5 face identities shown, each contribure two videos for each emotion
% jittered ISI of 4-8 seconds
% each run approx 9 minutes


%clc;clear all;close all;sca;
%A01Stimulation(100,1)
%subID = 100;runID = 1;
%subID = 1;runID = 2;

commandwindow
addpath('./scripts_matlab/')

% Preload ISI durations and shuffle them
load('vec_ISIs.mat');
Shuffle(vec_ISIs);

%myTrials = funct_get_myTrials_disfa(subID,runID);
myTrials = funct_get_myTrials_disfa_halfruns(subID,runID);


% Prep button responses
KbName('UnifyKeyNames')
buttons.left = '3#' ;
buttons.right = '4$' ;
buttons.triggers = { '=+' , '5%' , 't'};
buttons.escape = 'ESCAPE';
buttons.space= 'space';

% Set up the window
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 2)
screenid = max(Screen('Screens'));
screenid = 0

%[win, windowRect] = Screen(screenid, 'openwindow',[128 128 128],[]);
[win, windowRect] = Screen(screenid, 'openwindow',[0 0 0],[]);
%[win, windowRect] = Screen(screenid, 'openwindow',[0 0 0],[0 0 640 480]);
fps = 25; % Video playback speed
cross_colors = [125 125 125; 125 125 125;] % Colors for fix cross: ~gay~ gray

% Wait for scanner trigger
func_wait_for_trigger_scanner(win,buttons)


expStart = GetSecs; % Get time0
%%% Experiment loop

func_FixCross_fixed_(win,buttons,3,[1 1 1]) % Fix Cross with fixed 3 second ISI to prep for experiment

for trial = 1:length(myTrials)

    if trial==36 % Mid run pause
    func_FixCross_fixed_(win,buttons,17,[0 0 0])
    func_FixCross_fixed_(win,buttons,3,[1,1,1])
    end


clc;
disp(trial)
disp(myTrials(trial).label)

% Show movie and collect pressed responses
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(myTrials(trial).moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(myTrials(trial).moviename,win,windowRect,buttons,fps);

% Show Fixation Cross
isTarget = strcmp(myTrials(trial).label,'neutral');
[pressedKey_cross,pressedTimes_cross,t_cross_on,t_cross_off] = func_FixCross_stored_ISI_with_response_color(win,isTarget,buttons,cross_colors,trial,vec_ISIs);

% Record Video information and responses to myTrials

myTrials(trial).response_video = pressedKey_video; 
myTrials(trial).RT_video = pressedTimes_video;
myTrials(trial).video_on = t_video_on-expStart;
myTrials(trial).video_off = t_video_off-expStart;
myTrials(trial).video_dur = myTrials(trial).video_off-myTrials(trial).video_on;


% Record Fixation Cross information and responses to myTrials
myTrials(trial).response_cross = pressedKey_cross; % save pressed keys during the video
myTrials(trial).RT_cross = pressedTimes_cross; % save RTs relative to video onset
myTrials(trial).cross_on = t_cross_on-expStart; % time video was shown relative to experiment start
myTrials(trial).cross_off = t_cross_off-expStart; % time video ended relative to experiment start
myTrials(trial).cross_dur = myTrials(trial).cross_off-myTrials(trial).cross_on;


end %ends experiment loop

% after the experiment, save variables
save(fullfile('Data',sprintf('myTrials_S%02d-run-%02d.mat',subID,runID)),'myTrials');
save(fullfile('Data',sprintf('workspace_S%02d-run-%02d.mat',subID,runID)));


% TODO: show accuracy at the end of run
acc = round(mean(~cellfun(@isempty,{myTrials([myTrials.isTarget]).response_cross}))*100);
DrawFormattedText(win, sprintf('End of run %d/6\n Accuracy %d%%',runID,acc), 'center', 'center', [255 255 255]);
Screen('Flip', win);
pause(12)
sca; % close PTB

disp(sprintf('Run Duration: %.2f minutes',(GetSecs-expStart)/60))

end %ends function













