function [pressedKey,pressedTimes,t_video_on,t_video_off] = func_playmovie_with_response_scanner_frames(moviename,win,windowRect,buttons,fps)


% Open movie file:
%moviename = '/Users/aidasaglinskas/Desktop/BC-FacExpr-1.2-fMRI-mainExp/stimuli/stimuli_experiment/stimuli_cropped_normed_crop_000/id1d1.mov'
%moviename = '/Users/aidasaglinskas/Desktop/BC-FacExpr-1.2-fMRI-mainExp/stimuli/stimuli_practice2/neutral/RightVideoSN030_comp_n2.mov';
movie = VideoReader(moviename);
%% Resize the movie

movie_size = [512 512]; % /2
cntr = windowRect(3:end)/2 ;
destRect = [
    cntr(1)- (movie_size(1)/2)
    cntr(2)- (movie_size(2)/2)
    cntr(1)+ (movie_size(1)/2)
    cntr(2)+ (movie_size(2)/2)
    ]';

pressedKey = [];
pressedTimes = [];
DisableKeysForKbCheck([]);

t_video_on = GetSecs;
for i = 1:movie.NumFrames
    when=t_video_on+1/fps*i; % Figure out when to flip
    frame = read(movie,i);
    tx = Screen('MakeTexture',win,frame);
    Screen('DrawTexture', win, tx,[],destRect);
    [VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip',win,when);
   
    RestrictKeysForKbCheck(KbName({buttons.left,buttons.right,buttons.escape}));

    %isPressed = 0;
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-3); % KbCheck(-3) scans all devices
    if keyIsDown
        %isPressed = 1;

        if strcmp(KbName(keyCode),buttons.escape); close all;sca;error('Escape Key Pressed'); end
        %^ if ESC pressed, end experiment

        pressedKey = [pressedKey ',' KbName(keyCode)];
        pressedTimes = [pressedTimes secs-t_video_on];
        DisableKeysForKbCheck(keyCode==1);
    end
   
end

RestrictKeysForKbCheck([]); % Release all keys
t_video_off = GetSecs;
end