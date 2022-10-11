function stimulation(subID,runID)
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

%subID = 0;runID = 0;

myTrials = funct_get_myTrials(subID,runID);


% Set up the window
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 2)
screenid = max(Screen('Screens'));
[win, windowRect] = Screen(screenid, 'openwindow',[128 128 128],[]);



% Wait for scanner trigger
% TODO change tigger key once known
func_wait_for_trigger(win,'space')


expStart = GetSecs; % Get time0
%%% Experiment loop
for trial = 1:length(myTrials)

func_FixCross_jittered_ISI(win) % Fix Cross with variable ISI (4-8 seconds)

% Show movie and collect pressed responses
[pressedKey,pressedTimes,t_video_on,t_video_off] = func_playmovie_with_response(myTrials(trial).moviename,win);

% Record responses and times
myTrials(trial).response = pressedKey; % save pressed keys during the video
myTrials(trial).RT = pressedTimes; % save RTs relative to video onset
myTrials(trial).t_on = t_video_on-expStart; % time video was shown relative to experiment start
myTrials(trial).t_off = t_video_off-expStart; % time video ended relative to experiment start


end %ends experiment loop

% after the experiment, save variables
save(fullfile('Data',sprintf('myTrials_S%02d-run-%02d.mat',subID,runID)),'myTrials');
save(fullfile('Data',sprintf('workspace_S%02d-run-%02d.mat',subID,runID)));



DrawFormattedText(win, sprintf('End of run %d/6',runID), 'center', 'center', []);
Screen('Flip', win);
pause(5)
sca; % close PTB

end %ends function




