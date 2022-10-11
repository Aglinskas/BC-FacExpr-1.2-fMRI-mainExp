myTrials = funct_get_myTrials(0,0)


% Set up the window
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 2)

screenid = max(Screen('Screens'));
[win, windowRect] = Screen(screenid, 'openwindow',[128 128 128],[]);

commandwindow

% Open movie file:
movie = Screen('OpenMovie', win, moviename);
% Start playback engine:
Screen('PlayMovie', movie, 1);
% Playback loop: R uns until end of movie or keypress:


pressedKey = [];
pressedTimes = [];

DisableKeysForKbCheck([]);
while 1
    % Wait for next movie frame, retrieve texture handle to it
    tex = Screen('GetMovieImage', win, movie);
    % Valid texture returned? A negative value means end of movie reached:
    if tex<=0
        break;% We're done, break out of loop:
    end
    % Draw the new texture immediately to screen:
    Screen('DrawTexture', win, tex);
    % Update display:
    Screen('Flip', win);
    % Release texture:
    Screen('Close', tex);


    isPressed = 0;
    %pressedKey = [];
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck;

    if keyIsDown
        isPressed=1;
        clc;
        disp('pressed')
        pressedKey = [pressedKey ',' KbName(keyCode)]
        pressedTimes = [pressedTimes secs]
        DisableKeysForKbCheck(keyCode==1)
    end


   
end
% Stop playback:
Screen('PlayMovie', movie, 0);
% Close movie:
Screen('CloseMovie', movie);