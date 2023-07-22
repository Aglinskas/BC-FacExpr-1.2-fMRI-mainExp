vec_ISIs = []

for i = 1:70
ISI = 4 + (8-4) .* rand; % rand ISI between 4 and 8
vec_ISIs(i) = ISI;
end

hist(vec_ISIs)

save('vec_ISIs.mat','vec_ISIs')