function [X] = extractDirection(data,cookingList)

X = zeros(length(data),length(cookingList));

for j = 1:length(data)
    for i = 1:length(data{j}.directions)
        for k = 1:length(cookingList)
            if ~isempty(regexp(data{j}.directions{i},cookingList{k},'once','ignorecase'))
               X(j,k) = 1; 
            end
            
            if strcmp('Pan-fry',cookingList{k}) && ~isempty(regexp(data{j}.directions{i},'skillet|wok|pan|sausage','once','ignorecase'))
               X(j,k) = 1; 
            end
            
            if strcmp('Deep-fry',cookingList{k}) && ~isempty(regexp(data{j}.directions{i},'deep|hot oil|airfry|air fry','once','ignorecase'))
               X(j,k) = 1; 
            end
            
            if strcmp('Slow cook',cookingList{k}) && ~isempty(regexp(data{j}.directions{i},'low heat|pressure','once','ignorecase'))
               X(j,k) = 1; 
            end
            
            if strcmp('Stir fry',cookingList{k}) && ~isempty(regexp(data{j}.directions{i},'Stir-fry|stir','once','ignorecase'))
               X(j,k) = 1; 
            end
            
            if strcmp('Grill',cookingList{k}) && ~isempty(regexp(data{j}.directions{i},'skewer|coal','once','ignorecase'))
               X(j,k) = 1; 
            end
            
            if strcmp('Bake',cookingList{k}) && ~isempty(regexp(data{j}.directions{i},'oven','once','ignorecase'))
               X(j,k) = 1; 
            end
            
            if strcmp('Boil',cookingList{k}) && ~isempty(regexp(data{j}.directions{i},'pasta|spaghetti','once','ignorecase'))
               X(j,k) = 1; 
            end
            
            if strcmp('Steam',cookingList{k}) && ~isempty(regexp(data{j}.directions{i},'rice cooker','once','ignorecase'))
               X(j,k) = 1; 
            end
        end
    end
    fms = 'j = %d\n';
    fprintf(fms,j)
end

sumRX = sum(X,2);
X(sumRX == 0,length(cookingList)) = 1;
sumRX = sum(X,2);

X = X./repmat(sumRX,1,size(X,2));

end

