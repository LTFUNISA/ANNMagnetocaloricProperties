function [Wh,Wo,output,mse_train,mse_val,mse_test]=Training(Nh_opt,train_percentage,val_percentage,test_percentage,i_n,t_n,map_t)
Ni=size(i_n,1);
No=size(t_n,1);
[Wh,Wo,mse_train,mse_val,mse_test]=ANN_training_codeBP(Ni,Nh_opt,No,i_n,t_n,train_percentage,val_percentage,test_percentage);
[output_n]=tanlin_ANN(i_n,Wh,Wo);
[output]=denormalize(output_n,map_t);
end