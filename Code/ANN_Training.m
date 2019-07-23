function [map_i,map_t,Wh,Wo,Nh_opt,MAPE_array,MAPE_M,MAPE_cp,MAE_M,MAE_cp,square_R,mse_train,mse_val,mse_test]=ANN_Training(in,target,No,Nh)
%Normalize experimental data between -1 and 1
in=in';
target=target';
[i_n,t_n,map_i,map_t]=normalize(in,target);
%Set data clustering (% of data set)
[train_percentage,val_percentage,test_percentage]=Data_clustering();
%Network structure optimization
[Nh_opt,MAPE_array]=Optimize_network(No,Nh,train_percentage,val_percentage,test_percentage,i_n,t_n,map_t,target);
%Optimal network training
[Wh,Wo,output,mse_train,mse_val,mse_test]=Training(Nh_opt,train_percentage,val_percentage,test_percentage,i_n,t_n,map_t);
[MAPE_M,MAPE_cp,MAE_M,MAE_cp]=Error_calculation_Target(No,target,output);
[square_R]=Determination_coefficient(No,target,output);
end





