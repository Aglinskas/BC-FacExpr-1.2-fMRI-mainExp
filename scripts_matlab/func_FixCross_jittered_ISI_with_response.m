function [pressedKey,pressedTimes,t_cross_on,t_cross_off] = func_FixCross_jittered_ISI_with_response(win)

oldTextSize = Screen('TextSize', win, 100);
DrawFormattedText(win,'+','center','center',[255 255 255]);
[x t_cross_on] = Screen('flip',win);


ISI = 4 + (8-4) .* rand; % rand ISI between 4 and 8

pressedKey = [];
pressedTimes = [];
DisableKeysForKbCheck([]);
isPressed = 0;

while GetSecs < t_cross_on + ISI %t_presented + opts.instruct_time
    
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
    if keyIsDown
        isPressed = 1;
        pressedKey = [pressedKey ',' KbName(keyCode)];
        pressedTimes = [pressedTimes secs-t_cross_on];
        DisableKeysForKbCheck(keyCode==1);
    end


    % If response, dim the cross. 
    if isPressed
        DrawFormattedText(win,'+','center','center',[255 255 255]*.3);
        [x t_cross_change] = Screen('flip',win);
    end
end

oldTextSize = Screen('TextSize', win, oldTextSize);
t_cross_off = GetSecs;


% function [pressedKey,pressedTimes,t_video_on,t_video_off] = func_playmovie_with_response(moviename,win)
% 
% 
% % Open movie file:
% movie = Screen('OpenMovie', win, moviename);
% % Start playback engine:
% Screen('PlayMovie', movie, 1);
% % Playback loop: R uns until end of movie or keypress:
% 
% pressedKey = [];
% pressedTimes = [];
% DisableKeysForKbCheck([]);
% 
% t_video_on = GetSecs;
% while 1
%     % Wait for next movie frame, retrieve texture handle to it
%     tex = Screen('GetMovieImage', win, movie);
%     % Valid texture returned? A negative value means end of movie reached:
%     if tex<=0
%         break;% We're done, break out of loop:
%     end
%     % Draw the new texture immediately to screen:
%     Screen('DrawTexture', win, tex);
%     % Update display:
%     Screen('Flip', win);
%     % Release texture:
%     Screen('Close', tex);
% 
% 
%     isPressed = 0;
%     [keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
%     if keyIsDown
%         isPressed = 1;
%         pressedKey = [pressedKey ',' KbName(keyCode)];
%         pressedTimes = [pressedTimes secs-t_video_on];
%         DisableKeysForKbCheck(keyCode==1);
%     end
%    
% end
% t_video_off = GetSecs;
% % Stop playback:
% Screen('PlayMovie', movie, 0);
% % Close movie:
% Screen('CloseMovie', movie);
% 
% end

end