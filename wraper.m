% The 'wraper' function is combining all the results from all algorithms
% (KNN, KNN with weight, KNN with weight and TFIDF, and KNN with weight and
% PCA) and the outputs are the color maps of suggested dishes, common
% ingredients, and cooking methods
%
% The 'KNNfood' function is to calculate euclidean distance
%
% The 'analyseTFIDFResult' function is to find the most common ingredients
% that might misleading the clustering and weight them down to 0.1. Then,
% use 'KNNfood' to determine the closest dishes 
%
% The 'analysePCAResult' function is similar to the 'analyseTFIDFResult'
% function. PCA is used to find the common ingredients that might misleading 
% the clustering and weight them down to 0.1.Then, use 'KNNfood' to determine
% the closest dishes 
%

function [FoodName,FoodURL] = wraper(PCAindex,TFIDF_E,XANF,Xcooking,IngName,CookName,idx,data)

figure

subplot(1,4,1)
[FoodIndex1] = KNNFOOD('KNN',XANF,Xcooking,IngName,CookName,idx,data,1);

subplot(1,4,2)
[FoodIndex2] = KNNFOOD('KNN with weight',XANF,Xcooking,IngName,CookName,idx,data,2);

subplot(1,4,3)
[FoodIndex3] = analyseTFIDFResult('KNN with weight and TFIDF',TFIDF_E,XANF,Xcooking,IngName,CookName,idx,data);

subplot(1,4,4)
[FoodIndex4] = analysePCAResult('KNN with weight and PCA', PCAindex,XANF,Xcooking,IngName,CookName,idx,data);

allIndex = unique([FoodIndex1 FoodIndex2 FoodIndex3 FoodIndex4]);

FoodName = [];
FoodURL = [];

for i = 1:length(allIndex)
    FoodName{i} = data{allIndex(i)}.name;
    FoodURL{i} = data{allIndex(i)}.url;
end

end

function [FoodIndex] = KNNFOOD(str,XANF,Xcooking,IngName,CookName,idx,data,w)

num = 6;
for i = 1:length(w)

    X = cat(2,XANF,w(i).*Xcooking);
    Name = [IngName CookName];
    
    [n,d] = knnsearch(X,X(idx,:),'k',num,'distance','euclidean');
    
    % find non-zeros X
    temp = X(n,:);
    % Remove zero columns
    Xindex = any(temp);
    tempXindex = Xindex;    
    temp( :, all(~temp,1) ) = [];  
    
    for j = 1:num
        FoodIndex(j) = n(j);
        FoodName{j} = data{n(j)}.name;
    end
    
    StrNameTemp = Name(Xindex);
    
    imagesc(temp')
    set(gca,'ytick',[1:size(temp,2)],'yticklabel',StrNameTemp)
    set(gca,'xtick',[1:num],'xticklabel',FoodName)
    xtickangle(45)
    title(str)
    colorbar
end
end

function [FoodIndex] = analyseTFIDFResult(str,TFIDF_E,XANF,Xcooking,IngName,CookName,idx,data)

[B,I] = sort(sum(TFIDF_E)); 
coutoffIndex = 7;

w = [0.1];

for i = 1:length(w)
   XANFTemp = XANF;
   XANFTemp(:,I(1:coutoffIndex)) = XANF(:,I(1:coutoffIndex)).*w(i);
   FoodIndex = KNNFOOD(str,XANFTemp,Xcooking,IngName,CookName,idx,data,0.5);
end
    
end

function [FoodIndex] = analysePCAResult(str,PCAindex,XANF,Xcooking,IngName,CookName,idx,data)

w = [0.1];

for i = 1:length(w)
   XANFTemp = XANF;
   XANFTemp(:,PCAindex) = XANF(:,PCAindex).*w(i);
   FoodIndex = KNNFOOD(str,XANFTemp,Xcooking,IngName,CookName,idx,data,0.5);
end
    
end
