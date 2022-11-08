

for i = 1:length(myTrials)

if strcmp(myTrials(i).label,'neutral') & ~isempty(myTrials(i).response_cross)
    myTrials(i).acc = 1;
elseif ~strcmp(myTrials(i).label,'neutral') & isempty(myTrials(i).response_cross)
    myTrials(i).acc = 1;
else
    myTrials(i).acc = 0;
end
end


mean([myTrials.acc])


{myTrials([myTrials.acc]==0).moviename}'