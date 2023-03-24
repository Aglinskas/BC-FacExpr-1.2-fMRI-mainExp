function myPractice = func_get_myPracticeTrials()
% 5 categories 
%%% fearsurprise
%%% neutral
%%% disgust
%%% happiness
%%% sadness
% 5 train trials per category
% 30 trials of test
% 2 second videos

addpath('./scripts_matlab/');

%stimuli_dir = './stimuli/stimuli_practice2';
stimuli_dir = fullfile(pwd,'/stimuli/stimuli_practice2');

videos_fear = dir(fullfile(stimuli_dir,'fearsurprise','*.mp4'));
videos_neutral = dir(fullfile(stimuli_dir,'neutral','*.mp4'));
videos_disgust = dir(fullfile(stimuli_dir,'disgust','*.mp4'));
videos_happiness = dir(fullfile(stimuli_dir,'happiness','*.mp4'));
videos_sadness = dir(fullfile(stimuli_dir,'sadness','*.mp4'));



videos_fear = {videos_fear.name}';
videos_neutral = {videos_neutral.name}';
videos_disgust = {videos_disgust.name}';
videos_happiness = {videos_happiness.name}';
videos_sadness = {videos_sadness.name}';


videos_fear = Shuffle(videos_fear);
videos_neutral = Shuffle(videos_neutral);
videos_disgust = Shuffle(videos_disgust);
videos_happiness = Shuffle(videos_happiness);
videos_sadness = Shuffle(videos_sadness);



myPractice = struct();
l = 0;


% Neutral
for i = 1:5
l=l+1;
myPractice(l).moviename = fullfile(stimuli_dir,'neutral',videos_neutral{i});
myPractice(l).emotion = 'n';
myPractice(l).label = 'neutral';
myPractice(l).category = 'train';
end


% Happiness
for i = 1:5
l=l+1;
myPractice(l).moviename = fullfile(stimuli_dir,'happiness',videos_happiness{i});
myPractice(l).emotion = 'h';
myPractice(l).label = 'happiness';
myPractice(l).category = 'train';
end

% Sadness
for i = 1:5
l=l+1;
myPractice(l).moviename = fullfile(stimuli_dir,'sadness',videos_sadness{i});
myPractice(l).emotion = 's';
myPractice(l).label = 'sadness';
myPractice(l).category = 'train';
end

% Fear/Surprise
for i = 1:5
l=l+1;
myPractice(l).moviename = fullfile(stimuli_dir,'fearsurprise',videos_fear{i});
myPractice(l).emotion = 'f';
myPractice(l).label = 'fear';
myPractice(l).category = 'train';
end

% Fear/Surprise
for i = 1:5
l=l+1;
myPractice(l).moviename = fullfile(stimuli_dir,'disgust',videos_disgust{i});
myPractice(l).emotion = 'd';
myPractice(l).label = 'disgust';
myPractice(l).category = 'train';
end





% Shuffle again
videos_fear = Shuffle(videos_fear);
videos_neutral = Shuffle(videos_neutral);
videos_disgust = Shuffle(videos_disgust);
videos_happiness = Shuffle(videos_happiness);
videos_sadness = Shuffle(videos_sadness);

% videos_fear = dir(fullfile(stimuli_dir,'fearsurprise','*.mp4'));
% videos_neutral = dir(fullfile(stimuli_dir,'neutral','*.mp4'));
% videos_disgust = dir(fullfile(stimuli_dir,'disgust','*.mp4'));
% videos_happiness = dir(fullfile(stimuli_dir,'happiness','*.mp4'));
% videos_sadness = dir(fullfile(stimuli_dir,'sadness','*.mp4'));

all_folders = {'fearsurprise','disgust','happiness','sadness','neutral'};
all_files = {videos_fear,videos_disgust,videos_happiness,videos_sadness,videos_neutral};
all_emotion = {'f','d','h','s','n'};
all_label = {'fear','disgust','happiness','sadness','neutral'};

for i = 1:30
l=l+1;

rand_cat_idx = randi(5);
rand_video_idx = randi(length(all_files{rand_cat_idx}),1);

myPractice(l).moviename = fullfile(stimuli_dir,all_folders{rand_cat_idx},all_files{rand_cat_idx}{rand_video_idx});
myPractice(l).emotion = all_emotion{rand_cat_idx};
myPractice(l).label = all_label{rand_cat_idx};
myPractice(l).category = 'test';
myPractice(l).isTarget = strcmp(myPractice(l).emotion,'n');
end







