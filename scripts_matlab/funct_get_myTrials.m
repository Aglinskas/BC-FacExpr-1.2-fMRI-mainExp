function myTrials = funct_get_myTrials(subject,run)
% 6 Runs
% 2 second long videos
% 10 for each emotion label (anger, sadness, fear, disgust, surprise, happiness, neutral)
% videos presented in randomized order
% button press during a neutral video
% 5 face identities shown, each contribure two videos for each emotion
% jittered ISI of 4-8 seconds
% each run approx 9 minutes

videos = dir('./stimuli/*.mp4');
videos = {videos.name}'
videos = fullfile(pwd,'/stimuli',videos);
videos = Shuffle(videos);
nTrials = length(videos);




myTrials = struct;
[myTrials(1:nTrials).moviename] = deal(videos{:});
% [myTrials(1:nTrials).tex] = deal([]);
% [myTrials(1:nTrials).response] = deal([]);
% [myTrials(1:nTrials).RT] = deal([]);
% [myTrials(1:nTrials).t_on] = deal([]);
% [myTrials(1:nTrials).t_off] = deal([]);

end
