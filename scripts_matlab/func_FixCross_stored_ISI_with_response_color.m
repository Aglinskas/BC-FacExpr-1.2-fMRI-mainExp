function [pressedKey,pressedTimes,t_cross_on,t_cross_off] = func_FixCross_stored_ISI_with_response_color(win,istarget,buttons,cross_colors,trial,vec_ISIs)

oldTextSize = Screen('TextSize', win, 100);
DrawFormattedText(win,'+','center','center',[255 255 255]);
[x t_cross_on] = Screen('flip',win);


%ISI = 4 + (8-4) .* rand; % rand ISI between 4 and 8
ISI = vec_ISIs(trial); % from stored/shuffled

pressedKey = [];
pressedTimes = [];

DisableKeysForKbCheck([]);
RestrictKeysForKbCheck(KbName({buttons.left,buttons.right,buttons.escape,buttons.space}));

isPressed = 0;


%istarget = true;
%istarget = false;

while GetSecs < t_cross_on + ISI %t_presented + opts.instruct_time
    
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-3);
    if keyIsDown

        if strcmp(KbName(keyCode),buttons.escape); close all;sca;error('Escape Key Pressed'); end

        isPressed = 1;
        pressedKey = [pressedKey ',' KbName(keyCode)];
        pressedTimes = [pressedTimes secs-t_cross_on];
        DisableKeysForKbCheck(keyCode==1);
    end

    % If response, dim the cross. 
    if isPressed & istarget
        %DrawFormattedText(win,'+','center','center',[0 255 0]*.3);
        %DrawFormattedText(win,'+','center','center',[125 125 125]);
        DrawFormattedText(win,'+','center','center',cross_colors(1,:));
        [x t_cross_change] = Screen('flip',win);
    elseif isPressed & ~istarget
        %DrawFormattedText(win,'+','center','center',[255 0 0]*.3);
        %DrawFormattedText(win,'+','center','center',[125 125 125]);
        DrawFormattedText(win,'+','center','center',cross_colors(2,:));
        [x t_cross_change] = Screen('flip',win);

    end
end
[[0 255 0]*.3;]
oldTextSize = Screen('TextSize', win, oldTextSize);
t_cross_off = GetSecs;
RestrictKeysForKbCheck([]); % Release keys


end