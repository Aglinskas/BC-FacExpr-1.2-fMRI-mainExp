pwd

clc;clear all;close all;sca;
addpath('./scripts_matlab/');

myPractice = func_get_myPracticeTrials();


% Prep button responses
KbName('UnifyKeyNames');
buttons.left = '3#' ;
buttons.right = '4$' ;
buttons.triggers = { '=+' , '5%' , 't'};
buttons.escape = 'ESCAPE';
buttons.space= 'space';
buttons.enter = 'Return'


% Set up the window
PsychDefaultSetup(2);
%Screen('Preference', 'SkipSyncTests', 0)
Screen('Preference', 'SkipSyncTests', 1);
%Screen('Preference', 'SkipSyncTests', 2)

screenid = max(Screen('Screens'));
screenid = 0;

fps = 10; % video playback speed. Keep 10 for practice for  ¯\_(ツ)_/¯ reasons (looks weird at 25)
cross_colors = [[0 255 0]*.3;[255 0 0]*.3] % Colors for fix cross: Green and Red

RestrictKeysForKbCheck([]);
commandwindow;
ISI_train = .5;
ISI_test = 3;
%%

%[win, windowRect] = Screen(screenid, 'openwindow',[0 0 0],[]);

t_start = GetSecs;
[win, windowRect] = Screen(screenid, 'openwindow',[125 125 125],[]);
%hz=Screen('NominalFrameRate', win, 1, 20);
Screen('GetFlipInterval',win);
instructions = ['Welcome to the practice.\n' ...
    'In the fMRI experiment you will be asked to\n' ...
    'view videos of facial expressions\n' ...
    'and press a button when you see a\n' ...
    'NEUTRAL facial expression\n' ...
    '(press SPACE to continue)'];
func_show_instructions(win,instructions,buttons,30);


instructions = ['This practice will help you to familiarize yourself\n' ...
    'with the stimuli and procedure.\n'...
    'Pay attention and learn to \nidentify the different facial expressions'...
    '\n(press SPACE to continue)'];
func_show_instructions(win,instructions,buttons,30);


repeatTraining = true; % There's an option to not repeat at the end of loop
while repeatTraining

l = 0;
instructions = '1\5\nFirst - you will see 5 videos showing NEUTRAL expressions,\nfollowed by fixation cross (.5s).\nYou dont have to do anything\njust observe the facial expressions';
func_show_instructions(win,instructions,buttons,30);
% Neutral
for i = 1:5
l=l+1;
moviename = myPractice(l).moviename;
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps);
%func_FixCross_jittered_ISI(win,buttons);
func_FixCross_fixed_ISI(win,buttons,ISI_train);
end


instructions = '2/5\nYou will now see 5 videos of HAPPY expressions.';
func_show_instructions(win,instructions,buttons,30);
% Happiness
for i = 1:5
l=l+1;
moviename = myPractice(l).moviename;
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps);
%func_FixCross_jittered_ISI(win,buttons);
func_FixCross_fixed_ISI(win,buttons,ISI_train);
end


instructions = '3/5\nNext you will see 5 videos showing SADNESS';
func_show_instructions(win,instructions,buttons,30);
% Sadness
for i = 1:5
l=l+1;
moviename = myPractice(l).moviename;
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps);
%func_FixCross_jittered_ISI(win,buttons)
func_FixCross_fixed_ISI(win,buttons,ISI_train);
end


instructions = '4/5\nNext you will see 5 videos showing SURPRISE';
func_show_instructions(win,instructions,buttons,30);
% Fear
for i = 1:5
l=l+1;
moviename = myPractice(l).moviename;
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps);
%func_FixCross_jittered_ISI(win,buttons);
func_FixCross_fixed_ISI(win,buttons,ISI_train);
end


instructions = '5/5\nLastly you will see 5 videos showing DISGUST';
func_show_instructions(win,instructions,buttons,30);
% Disgust
for i = 1:5
l=l+1;
moviename = myPractice(l).moviename;
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps);
%func_FixCross_jittered_ISI(win,buttons);
func_FixCross_fixed_ISI(win,buttons,ISI_train);
end



% Ask whether to repeat training or not
instructions = 'Press SPACE to repeat training block\nPress ENTER to move on to test phase';
keyPressed = func_show_instructions(win,instructions,buttons,30);
repeatTraining = ~strcmp(keyPressed,buttons.enter);
end


%%%%%%%% Test phase %%%%%%%% 

repeatTesting = true; 
while repeatTesting 

l=25;

instructions = ['This is a test phase\n' ...
    'You will see 10 videos.\n' ...
    'If the video shows NEUTRAL facial expression\n' ...
    'press the 3 on the keyboard\n' ...
    'during the fixation cross.\n' ...
    'you will have 3 seconds to respond\n'...
    'Press SPACE to start'];
 
func_show_instructions(win,instructions,buttons,30);


%%% Test Block 1
for i = 1:10
l=l+1;
moviename = myPractice(l).moviename;
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps);
[pressedKey,pressedTimes,t_cross_on,t_cross_off] = func_FixCross_jittered_ISI_with_response_color(win,myPractice(l).isTarget,buttons,cross_colors,ISI_test);
myPractice(l).isPressed = ~isempty(pressedKey);
end
acc= mean([myPractice(l-9:l).isPressed]==[myPractice(l-9:l).isTarget]);

instructions = sprintf('Test block 1/3\nYou accuracy was %i%%\n Press space for another block',acc*100)
func_show_instructions(win,instructions,buttons,30)

%%% Test Block 2
for i = 1:10
l=l+1;
moviename = myPractice(l).moviename;
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps);
[pressedKey,pressedTimes,t_cross_on,t_cross_off] = func_FixCross_jittered_ISI_with_response_color(win,myPractice(l).isTarget,buttons,cross_colors,ISI_test);
myPractice(l).isPressed = ~isempty(pressedKey);
end
acc = mean([myPractice(l-9:l).isPressed]==[myPractice(l-9:l).isTarget]);

instructions = sprintf('Test block 2/3\nYou accuracy was %i%%\n Press space for another block',acc*100)
func_show_instructions(win,instructions,buttons,30)

%%% Test Block 3
for i = 1:10
l=l+1;
moviename = myPractice(l).moviename;
%[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner(moviename,win,windowRect,buttons);
[pressedKey_video,pressedTimes_video,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps);
[pressedKey,pressedTimes,t_cross_on,t_cross_off] = func_FixCross_jittered_ISI_with_response_color(win,myPractice(l).isTarget,buttons,cross_colors,ISI_test);
myPractice(l).isPressed = ~isempty(pressedKey);
end
acc= mean([myPractice(l-9:l).isPressed]==[myPractice(l-9:l).isTarget]);

instructions = sprintf('Test block 3/3\nYou accuracy was %i%%\n Press SPACE to terminate or\nPress ENTER to repeat test phase',acc*100)
func_show_instructions(win,instructions,buttons,30)

% Ask whether to repeat training or not
instructions = 'All done!\nPress SPACE to repeat testing block\nPress ENTER to close this app ';
keyPressed = func_show_instructions(win,instructions,buttons,30);
repeatTesting = ~strcmp(keyPressed,buttons.enter);
end

    
% That's all folks
close all;sca;

disp(sprintf('Practice Duration: %.2f minutes',(GetSecs-t_start)/60));