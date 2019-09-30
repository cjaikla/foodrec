function [allPhaseRankSort,allPhaseRankCountSort,singleWordRankSort,singleWordRankCountSort] = rankAllPhase(data)

allPhase = [];
idxAllPhase = 1;
singleWord = [];

for j = 1:length(data)
    for i = 1:length(data{j}.ingredients)
        % remove number
        ind = regexp(data{j}.ingredients{i},'[a-zA-Z]|(');
        temp = data{j}.ingredients{i}(ind(1):end);
        
        % extract unit out 
        unit_real = regexp(temp,'\w*spoons|\w*spoon|cups|cup|ounces|ounce|pounds|pound|cloves|clove|pinches|slices|slice|inches|inch','match');
        
        %only ingredient (remove amount and unit)
        temp1 = erase(temp,unit_real); %remove amount
        
        % gather 
        allPhase{idxAllPhase} = temp1;
        idxAllPhase = idxAllPhase + 1;
        singleWord = cat(2,singleWord, strsplit(temp1));
        
    end
end

allPhase = allPhase(~cellfun('isempty',allPhase));
singleWord = singleWord(~cellfun('isempty',singleWord));

allPhase = sort(allPhase);
[allPhaseRankSort,allPhaseRankCountSort] = countFreq(allPhase);

singleWord = sort(singleWord);
[singleWordRankSort,singleWordRankCountSort] = countFreq(singleWord);

end


function [secondWordRankSort,secondWordRankCountSort] = countFreq(secondWordCombined)

idx1 = 1;
idxR = 1;

while idx1 < length(secondWordCombined)
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
