function myTrials = funct_get_myTrials_disfa(subject,run)
% 6 Runs
% 2 second long videos
% 10 for each emotion label (anger, sadness, fear, disgust, surprise, happiness, neutral)
% videos presented in randomized order
% button press during a neutral video
% 5 face identities shown, each contribure two videos for each emotion
% jittered ISI of 4-8 seconds
% each run approx 9 minutes

%videos = dir('./stimuli/*.mp4');
videos = dir('./stimuli_experiment/*.mp4');
videos = {videos.name}';
videos = fullfile(pwd,'/stimuli_experiment',videos);
videos = Shuffle(videos);
nTrials = length(videos);




myTrials = struct;
[myTrials(1:nTrials).moviename] = deal(videos{:});

% [myTrials(1:nTrials).tex] = deal([]);
% [myTrials(1:nTrials).response] = deal([]);
% [myTrials(1:nTrials).RT] = deal([]);
% [myTrials(1:nTrials).t_on] = deal([]);
% [myTrials(1:nTrials).t_off] = deal([]);


% add emotion labels
for i = 1:length(myTrials)
temp = strsplit(myTrials(i).moviename,'/')';
temp = temp{end};
%temp = strsplit(temp,'_');
%condition = temp{2}(isletter(temp{2}));
condition = temp(4);
identity = temp(3);
myTrials(i).emotion = condition;
myTrials(i).identity = identity;

short = {'n' 'd' 'f' 's' 'su' 'h'};
long = {'neutral' 'disgust' 'fear' 'sadness' 'happiness'};
w = cellfun(@(x) strcmp(myTrials(i).emotion,x),{'n' 'd' 'f' 's' 'h'});
myTrials(i).label = long{w};

end



