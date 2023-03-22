function func_FixCross_jittered_ISI(win,buttons)

oldTextSize = Screen('TextSize', win, 100);
DrawFormattedText(win,'+','center','center');
[x t_cross_on] = Screen('flip',win);
ISI = 4 + (8-4) .* rand; % rand ISI between 4 and 8

RestrictKeysForKbCheck(KbName({buttons.escape}));

while GetSecs < t_cross_on + ISI %t_presented + opts.instruct_time
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-3);
    if keyIsDown
        %isPressed = 1;

        if strcmp(KbName(keyCode),buttons.escape); close all;sca;error('Escape Key Pressed'); end
        %^ if ESC pressed, end experiment

        pressedKey = [pressedKey ',' KbName(keyCode)];
        pressedTimes = [pressedTimes secs-t_video_on];
        DisableKeysForKbCheck(keyCode==1);
    end
end

oldTextSize = Screen('TextSize', win, oldTextSize);

end