function [secondWordCombined] = extractUnits(unit_c)
%
secondWordCombined = unit_c{1};

for i = 2:length(unit_c)
    secondWordCombined = cat(1,secondWordCombined,unit_c{i});
end

secondWordCombined = sort(secondWordCombined);

end

