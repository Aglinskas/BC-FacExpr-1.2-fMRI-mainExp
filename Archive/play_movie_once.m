moviename = '/Users/aidasaglinskas/Desktop/BC-FacExpr-fMRI-stim/stimuli/sadness-4.mp4'
windowrect = []


% Check if Psychtoolbox is properly installed:
%AssertOpenGL;


% Wait until user releases keys on keyboard:
%KbReleaseWait;

% Select screen for display of movie:
screenid = max(Screen('Screens'));

%Open 'windowrect' sized window on screen, with black [0] background color:
win = Screen('OpenWindow', screenid, 0, windowrect);
    
    

play_movie_once_from_fn(moviename,win)
    
    
    % Open movie file:
    movie = Screen('OpenMovie', win, moviename);
    % Start playback engine:
    Screen('PlayMovie', movie, 1);
    % Playback loop: Runs until end of movie or keypress:
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
    end
    % Stop playback:
    Screen('PlayMovie', movie, 0);
    % Close movie:
    Screen('CloseMovie', movie);
%     