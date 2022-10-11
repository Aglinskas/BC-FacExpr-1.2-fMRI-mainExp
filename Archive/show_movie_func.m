clear all;close all
commandwindow

theanswer = [];

Screen('Preference', 'SkipSyncTests', 1);
moviename = '/Users/aidasaglinskas/Desktop/BC-FacExpr-fMRI-stim/stimuli/DualDiscs.mov'
moviename = '/Users/aidasaglinskas/Desktop/BC-FacExpr-fMRI-stim/stimuli/sadness-4.mp4'


% Initialize with unified keynames and normalized colorspace:
PsychDefaultSetup(2);

% Setup key mapping:
space=KbName('SPACE');
esc=KbName('ESCAPE');
right=KbName('RightArrow');
left=KbName('LeftArrow');
up=KbName('UpArrow');
down=KbName('DownArrow');
shift=KbName('RightShift');
colorPicker=KbName('c');

%try
    % Open onscreen window with gray background:
    screen = max(Screen('Screens'));
    PsychImaging('PrepareConfiguration');

    % No special movieOptions by default:
    movieOptions = [];

    win = PsychImaging('OpenWindow', screen, [0.5, 0.5, 0.5]);
    [w, h] = Screen('WindowSize', win);
    Screen('Blendfunction', win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


shader = []


pixelFormat = [];

% Use default maxThreads if none specified:
 maxThreads = [];

% Initial display and sync to timestamp:
Screen('Flip',win);
iteration = 0;
abortit = 0;

% Use blocking wait for new frames by default:
blocking = 1;

% Default preload setting:
preloadsecs = [];


% Playbackrate defaults to 1:
rate=1;

% No mouse color prober/picker by default - Performance impact!
colorprobe = 0;

% Choose 16 pixel text size:
Screen('TextSize', win, 16);


% Show title while movie is loading/prerolling:
DrawFormattedText(win, ['Loading ...\n' moviename], 'center', 'center', 0, 40);
Screen('Flip', win);
% 
% Open movie file and retrieve basic info about movie:
[movie, movieduration, fps, imgw, imgh, ~, ~, hdrStaticMetaData] = Screen('OpenMovie', win, moviename, [], preloadsecs, [], pixelFormat, maxThreads, movieOptions);
fprintf('Movie: %s  : %f seconds duration, %f fps, w x h = %i x %i...\n', moviename, movieduration, fps, imgw, imgh);


if imgw > w || imgh > h
    % Video frames too big to fit into window, so define size to be window size:
    dstRect = CenterRect((w / imgw) * [0, 0, imgw, imgh], Screen('Rect', win));
else
    dstRect = [];
end


Screen('PlayMovie', movie, rate, 1, 1.0);
% 
t1 = GetSecs;

% Infinite playback loop: Fetch video frames and display them...
i = 0
while 1

        tex = Screen('GetMovieImage', win, movie, blocking);

        if tex<=0
            % We're done, break out of loop:
            break;
        end

%         % Valid texture returned?

        % Draw the new texture immediately to screen:
        Screen('DrawTexture', win, tex, [], dstRect, [], [], [], [], shader);

        % Update display:
        Screen('Flip', win);
        
        % Release texture:
        Screen('Close', tex);
        
        % Framecounter:
        i=i+1;
end

Screen('PlayMovie', movie, 0);
