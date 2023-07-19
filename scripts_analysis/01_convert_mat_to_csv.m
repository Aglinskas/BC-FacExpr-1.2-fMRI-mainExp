%data_dir = ''

cd ../Data/

%cd into data dir

files = dir('./myTrials_S*.mat');
files = {files.name}';
n = length(files)

%i = 1
for i = 1:n
load(files{i},'myTrials')
writetable(struct2table(myTrials), strrep(files{i},'.mat','.csv'))
end