function [pressedKey,pressedTimes,t_video_on,t_video_off] = func_playmovie_with_response(moviename,win,windowRect)


% Open movie file:
%moviename = myTrials(trial).moviename
%moviename = myTrials(1).moviename
movie = Screen('OpenMovie', win, moviename);

%% Resize the movie

movie_size = [1280 720]/2 ;
cntr = windowRect(3:end)/2 ;
destRect = [
    cntr(1)- (movie_size(1)/2)
    cntr(2)- (movie_size(2)/2)
    cntr(1)+ (movie_size(1)/2)
    cntr(2)+ (movie_size(2)/2)
    ]';



% Start playback engine:
Screen('PlayMovie', movie, 1);
% Playback loop: R uns until end of movie or keypress:

pressedKey = [];
pressedTimes = [];
DisableKeysForKbCheck([]);

t_video_on = GetSecs;
while 1
    % Wait for next movie frame, retrieve texture handle to it
    tex = Screen('GetMovieImage', win, movie);
    % Valid texture returned? A negative value means end of movie reached:
    if tex<=0
        break;% We're done, break out of loop:
    end
    % Draw the new texture immediately to screen:
    %Screen('DrawTexture', win, tex);
    Screen('DrawTexture', win, tex,[],destRect);
    % Update display:
    Screen('Flip', win);
    % Release texture:
    Screen('Close', tex);


    isPressed = 0;
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
    if keyIsDown
        isPressed = 1;
        pressedKey = [pressedKey ',' KbName(keyCode)];
        pressedTimes = [pressedTimes secs-t_video_on];
        DisableKeysForKbCheck(keyCode==1);
    end
   
end
t_video_off = GetSecs;
% Stop playback:
Screen('PlayMovie', movie, 0);
% Close movie:
Screen('CloseMovie', movie);

end