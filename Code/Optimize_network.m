function [Nh_opt,MAPE]=Optimize_network(No,Nh,train_percentage,val_percentage,test_percentage,i_n,t_n,map_t,target)
%ARRAY initialization
Ni=size(i_n,1);
MAPE=zeros(1,length(Nh));
%Initialize optimization cycle
for i=1:1:length(Nh)
    %Create network
    [Wh,Wo]=ANN_training_codeBP(Ni,Nh(i),No,i_n,t_n,train_percentage,val_percentage,test_percentage);
    [output_n]=tanlin_ANN(i_n,Wh,Wo);
    [output]=denormalize(output_n,map_t);
    [MAPE(i)]=Error_calculation(No,target,output);
end
MAPE_opt=min(MAPE);
for i=1:1:length(Nh)
    if MAPE(i)==MAPE_opt
       Nh_opt=Nh(i);
    end
end
end

    