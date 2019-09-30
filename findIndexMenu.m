function [ index] = findIndexMenu(data,str)

index = 0;

for i = 1:length(data)
    if strcmp(data{i}.name,str)
        index = i;
        break        
    end
end

data{index}.directions

data{index}.ingredients

end

