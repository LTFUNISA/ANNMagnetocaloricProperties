function [MAPE_M,MAPE_cp,MAE_M,MAE_cp]=Error_calculation_Target(No,target,output)
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
MAE_v=mean(absolute,2);
MAPE_v=mean(relative,2)*100;
MAPE_M=MAPE_v(1);
MAPE_cp=MAPE_v(2);
MAE_M=MAE_v(1);
MAE_cp=MAE_v(2);
end