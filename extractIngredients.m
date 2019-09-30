function [X,XA,XAN,unit_c] = extractIngredients(data,allPhaseIngList,singleWordIngList,unitIng,unitConversionList,unitConversionTable)

X = zeros(length(data),length(allPhaseIngList)+length(singleWordIngList));
XA = zeros(length(data),length(allPhaseIngList)+length(singleWordIngList));
IngList = [allPhaseIngList singleWordIngList];

for j = 1:length(data)
    
    numServing = str2num(data{j}.serving);
    
    for i = 1:length(data{j}.ingredients)
        % get number
        %extract the amount of ingredients out
        
        if ~isempty(regexp(data{j}.ingredients{i},'(+[0-9]','once'))
            ind = regexp(data{j}.ingredients{i},'(?i)\w*');
            if ~isempty(regexp(data{j}.ingredients{i},'/','once'))
                a = str2num(data{j}.ingredients{i}(ind(2):ind(4)));
            else
                a = str2num(data{j}.ingredients{i}(ind(2):ind(3)));
            end
            if length(a)>1
                amount = a(1)+a(2); %fix [1, 0.5] to 1.5
            elseif isempty(a)
                amount = 0;
            else
                amount = a;
            end
             
             temp = data{j}.ingredients{i}(ind(1):end);
        else
            ind = regexp(data{j}.ingredients{i},'[a-zA-Z]|('); %find the index of the first letter
            if length(ind) > 1
                a = str2num(data{j}.ingredients{i}(1:ind(1)-2)); %only get an ingredient then convert to float (i.e. 1 1/2 to [1,0.5])
            else
                a = {[]};
            end
            if length(a)>1
                amount = a(1)+a(2); %fix [1, 0.5] to 1.5
            elseif isempty(a)
                amount = 0;
            else
                amount = a;
            end
             temp = data{j}.ingredients{i}(ind(1):end);
        end
                
        
        % get unit
        unit = regexp(temp,'\w*spoons|\w*spoon|cubes|cube|cups|cup|ounces|ounce|pounds|pound','match','once');
        temp1 = erase(temp,unit);
       
        
        fms = 'j = %d and i = %d\n';
        fprintf(fms,j,i)
        
        temp1 = data{j}.ingredients{i};
        
        % check allPhaseIngList
        indexIngList = 1;
        matchIngList = false;
        
        while(indexIngList <= length(IngList) && ~matchIngList)

            if ~isempty(regexp(temp1,IngList{indexIngList},'once'))               
                matchIngList = true;
                X(j,indexIngList) = amount;
                unit_c{j,indexIngList} = unit;
                XA(j,indexIngList) = convertUnit(X(j,indexIngList),unit,unitIng{indexIngList},unitConversionList,unitConversionTable,numServing);
            elseif strcmp(IngList{indexIngList},'chicken broth')
                if ~isempty(regexp(temp1,'chicken stock','once'))               
                matchIngList = true;
                X(j,indexIngList) = amount;
                unit_c{j,indexIngList} = unit;
                XA(j,indexIngList) = convertUnit(X(j,indexIngList),unit,unitIng{indexIngList},unitConversionList,unitConversionTable,numServing);
                else
                    indexIngList = indexIngList + 1;
                end
            elseif strcmp(IngList{indexIngList},'heavy cream')
                if ~isempty(regexp(temp1,'heavy whipping cream|whipping cream','once'))               
                matchIngList = true;
                X(j,indexIngList) = amount;
                unit_c{j,indexIngList} = unit;
                XA(j,indexIngList) = convertUnit(X(j,indexIngList),unit,unitIng{indexIngList},unitConversionList,unitConversionTable,numServing);
                else
                    indexIngList = indexIngList + 1;
                end 
            elseif strcmp(IngList{indexIngList},'beef broth')
                if ~isempty(regexp(temp1,'beef stock','once'))               
                matchIngList = true;
                X(j,indexIngList) = amount;
                unit_c{j,indexIngList} = unit;
                XA(j,indexIngList) = convertUnit(X(j,indexIngList),unit,unitIng{indexIngList},unitConversionList,unitConversionTable,numServing);
                else
                    indexIngList = indexIngList + 1;
                end 
            elseif strcmp(IngList{indexIngList},'cider vinegar')
                if ~isempty(regexp(temp1,'apple cider','once'))               
                matchIngList = true;
                X(j,indexIngList) = amount;
                unit_c{j,indexIngList} = unit;
                XA(j,indexIngList) = convertUnit(X(j,indexIngList),unit,unitIng{indexIngList},unitConversionList,unitConversionTable,numServing);
                else
                    indexIngList = indexIngList + 1;
                end    
            elseif strcmp(IngList{indexIngList},'vegetable broth')
                if ~isempty(regexp(temp1,'vegetable stock','once'))               
                matchIngList = true;
                X(j,indexIngList) = amount;
                unit_c{j,indexIngList} = unit;
                XA(j,indexIngList) = convertUnit(X(j,indexIngList),unit,unitIng{indexIngList},unitConversionList,unitConversionTable,numServing);
                else
                    indexIngList = indexIngList + 1;
                end       
            else
                indexIngList = indexIngList + 1;
            end
        end   
    end
    
    % normalize by serving
    XA(j,:) = XA(j,:)./numServing;
         
end

 % normalize by X  
maxTemp = max(XA,[],1);
XAN = XA./repmat(maxTemp,size(XA,1),1);

X = real(X);
XA = real(XA);
XAN = real(XAN);

end

function [newAmount] = convertUnit(amount,unit,unitIng,unitConversionList,unitConversionTable,numServing)

if strcmp(unitIng,'unitless') || isempty(unit)
    newAmount = 1*numServing;
else

    idxUnitTargetCell = strfind(unitConversionList,unitIng);
    idxUnitTarget = find(~cellfun(@isempty,idxUnitTargetCell));

    idxUnitCell = strfind(unitConversionList,unit);
    idxUnit = find(~cellfun(@isempty,idxUnitCell));
    
    newAmount = amount*unitConversionTable(idxUnit,idxUnitTarget);
end
end

