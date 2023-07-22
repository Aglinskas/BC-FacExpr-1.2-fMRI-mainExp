function myTrials = funct_get_myTrials_disfa_halfruns(subject,run)
% 6 Runs
% 2 second long videos
% 10 for each emotion label (anger, sadness, fear, disgust, surprise, happiness, neutral)
% videos presented in randomized order
% button press during a neutral video
% 5 face identities shown, each contribure two videos for each emotion
% jittered ISI of 4-8 seconds
% each run approx 9 minutes

%videos = dir('./stimuli/*.mp4');


%%%% Make run orders
% run_order = zeros(6,100)';
% for i = 1:100
% run_order(i,:) = Shuffle(1:6);
% end
% run_order(100,:) = 1:6
% save('./scripts_matlab/run_order.mat','run_order')
% subject=1,run=1

load('./scripts_matlab/run_order.mat');

stimuli_folders = dir('./stimuli/stimuli_experiment/stimuli_*');
stimuli_folders = {stimuli_folders.name}';

run_dir = sprintf('./stimuli/stimuli_experiment/%s/',stimuli_folders{run_order(subject,run)});
%videos = dir([run_dir '*.mp4']);
videos = dir([run_dir '*.mov']);
videos = {videos.name}';
videos = fullfile(pwd,run_dir,videos);
%videos = Shuffle(videos);
minirun_idx = cellfun(@(x) str2num(x(end-4)),videos);
[Y I] = sort(minirun_idx);
videos = videos(I);

videos(1:35) = Shuffle(videos(1:35));
videos(36:70) = Shuffle(videos(36:70));

%minirun_idx(I(1:35))
%minirun_idx(I(36:70))

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
myTrials(i).isTarget = strcmp(myTrials(i).label,'neutral');
end

%%% Prealocate responses
[myTrials.response_cross] = deal([]);
[myTrials.RT_cross] = deal([]);
[myTrials.cross_on] = deal([]);
[myTrials.cross_off] = deal([]);
[myTrials.cross_dur] = deal([]);


[myTrials.response_video] = deal([]);
[myTrials.RT_video] = deal([]);
[myTrials.video_on] = deal([]);
[myTrials.video_off] = deal([]);
[myTrials.video_dur] = deal([]);


%%% Pre-allocate fix cross
% for i = 1:length(myTrials)
% ISI = 4 + (8-4) .* rand; % rand ISI between 4 and 8
% myTrials(i).est_fix_cross = ISI;
% end




% for i = 1:length(myTrials)
% movie = VideoReader(myTrials(i).moviename);
% myTrials(i).est_video_duration = movie.duration;
% end







