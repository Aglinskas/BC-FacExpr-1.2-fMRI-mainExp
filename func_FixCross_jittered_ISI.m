function func_FixCross_jittered_ISI(win)

oldTextSize = Screen('TextSize', win, 100);
DrawFormattedText(win,'+','center','center');
[x t_cross_on] = Screen('flip',win);
ISI = 4 + (8-4) .* rand; % rand ISI between 4 and 8
while GetSecs < t_cross_on + ISI %t_presented + opts.instruct_time
    % Wait dixation cross
end

oldTextSize = Screen('TextSize', win, oldTextSize);

end