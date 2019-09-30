function [DirectionsingleWordRankSort,DirectionsingleWordRankCountSort] = rankCookingDirection(data)

singleWord = [];

for j = 1:length(data)
    for i = 1:length(data{j}.directions)
        % gather 
        singleWord = cat(2,singleWord, strsplit(data{j}.directions{i}));
        
    end
end

singleWord = singleWord(~cellfun('isempty',singleWord));

singleWord = sort(singleWord);
[DirectionsingleWordRankSort,DirectionsingleWordRankCountSort] = countFreq(singleWord);

end

function [secondWordRankSort,secondWordRankCountSort] = countFreq(secondWordCombined)

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

secondWordRankSort = secondWordRankSort';
secondWordRankCountSort = secondWordRankCountSort';

end