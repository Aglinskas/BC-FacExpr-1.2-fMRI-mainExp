function [keyPressed] = func_show_instructions(win,instructions,buttons,textsize)
% Waits for trigger press before moving on, listents ONLY to the trigger
% and ESC

oldTextSize = Screen('TextSize', win, textsize);
DrawFormattedText(win, instructions, 'center', 'center', [255 255 255]);
Screen('Flip', win);

% Only check the trigger keys (and escape key)
RestrictKeysForKbCheck([KbName(buttons.space) KbName(buttons.escape),KbName(buttons.enter)]);
pause(1)

trigger_pressed = 0;
while ~trigger_pressed
[keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
    if keyIsDown
        keyPressed = KbName(keyCode);
        if strcmp(KbName(keyCode),buttons.escape);close all;sca;error('Escape Key Pressed'); end
        trigger_pressed = 1;
    end
end
DisableKeysForKbCheck([]); % re-enable all keys

end %ends function
