function [MAPE]=Error_calculation(No,target,output)
pattern=size(target,2);
absolute=abs(target-output);
relative=zeros(No,pattern);
for i=1:1:No
    for k=1:1:pattern
        if target(i,k)==0
        else
            relative(i,k)=absolute(i,k)/abs(target(i,k));
        end
    end
end
MAPE_v=mean(relative,2)*100;
MAPE=sum(MAPE_v)/size(target,1);
end