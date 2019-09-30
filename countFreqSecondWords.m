function [secondWordRankSort,secondWordRankCountSort] = countFreqSecondWords(secondWordCombined)

idx1 = 1;
idxR = 1;

while idx1 < length(secondWordCombined)-1
    idx2 = idx1 + 1;
    secondWordRank{idxR} = secondWordCombined{idx1};
    secondWordRankCount(idxR) = 1;
    while idx2 <= length(secondWordCombined) && idx1 <= length(secondWordCombined) && strcmp(secondWordCombined{idx1},secondWordCombined{idx2})   
        secondWordRankCount(idxR) = secondWordRankCount(idxR) + 1;
        idx2 = idx2 + 1;
    end
    idxR = idxR + 1;
    idx1 = idx2;
end

[secondWordRankCountSort,secondWordRankCountSortIdx] = sort(secondWordRankCount,'descend');
for i = 1:length(secondWordRankCountSortIdx)
    secondWordRankSort{i} = secondWordRank{secondWordRankCountSortIdx(i)};
end

figure 
plot(secondWordRankCountSort(1:100))

secondWordRankSort = secondWordRankSort';
secondWordRankCountSort = secondWordRankCountSort';

end

