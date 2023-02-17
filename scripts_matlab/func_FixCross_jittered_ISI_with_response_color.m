function [pressedKey,pressedTimes,t_cross_on,t_cross_off] = func_FixCross_jittered_ISI_with_response_color(win,istarget,buttons)

oldTextSize = Screen('TextSize', win, 100);
DrawFormattedText(win,'+','center','center',[255 255 255]);
[x t_cross_on] = Screen('flip',win);


ISI = 4 + (8-4) .* rand; % rand ISI between 4 and 8

pressedKey = [];
pressedTimes = [];

DisableKeysForKbCheck([]);
RestrictKeysForKbCheck(KbName({buttons.left,buttons.right,buttons.escape}));

isPressed = 0;


%istarget = true;
%istarget = false;

while GetSecs < t_cross_on + ISI %t_presented + opts.instruct_time
    
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-3);
    if keyIsDown

        if strcmp(KbName(keyCode),buttons.escape); error('Escape Key Pressed'); end

        isPressed = 1;
        pressedKey = [pressedKey ',' KbName(keyCode)];
        pressedTimes = [pressedTimes secs-t_cross_on];
        DisableKeysForKbCheck(keyCode==1);
    end

    % If response, dim the cross. 
    if isPressed & istarget
        DrawFormattedText(win,'+','center','center',[0 255 0]*.3);
        [x t_cross_change] = Screen('flip',win);
    elseif isPressed & ~istarget
        DrawFormattedText(win,'+','center','center',[255 0 0]*.3);
        [x t_cross_change] = Screen('flip',win);

    end
end

oldTextSize = Screen('TextSize', win, oldTextSize);
t_cross_off = GetSecs;
RestrictKeysForKbCheck([]); % Release keys


end