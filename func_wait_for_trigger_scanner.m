function func_wait_for_trigger_scanner(win,buttons)
% Waits for trigger press before moving on, listents ONLY to the trigger
% and ESC

oldTextSize = Screen('TextSize', win, 50);
DrawFormattedText(win, 'Waiting to start', 'center', 'center', [255 255 255]);
Screen('Flip', win);

% Only check the trigger keys (and escape key)
RestrictKeysForKbCheck([KbName(buttons.triggers) KbName(buttons.escape)]);

trigger_pressed = 0;
while ~trigger_pressed
[keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
    if keyIsDown
        if strcmp(KbName(keyCode),buttons.escape); error('Escape Key Pressed'); end
        trigger_pressed = 1;
    end
end
DisableKeysForKbCheck([]); % re-enable all keys

end %ends function