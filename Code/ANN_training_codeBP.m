function [finalWh,finalWo,mse_train,mse_val,mse_test]=ANN_training_codeBP(Ni,Nh,No,i_n,t_n,train_percentage,val_percentage,test_percentage)
pattern=size(t_n,2);
%Define training parameters for EBP
[cycles_number,success,learningrate,momentum]=set_train_parameters();
%Divide data for cross-validation
[train,val,test,i_train,i_val,i_test,t_train,t_val,t_test]=data_division(i_n,t_n,pattern,Ni,No,train_percentage,val_percentage,test_percentage);
%Initialize synaptic weights
[initialWh,initialWo,deltaWh,deltaWo]=initialize_weights(Ni,Nh,No);
%Training phase
trainingcycle=1;
error_ftrain=zeros(1,cycles_number);
error_fval=zeros(1,cycles_number);
error_ftest=zeros(1,cycles_number);
mse_train=zeros(1,cycles_number);
mse_val=zeros(1,cycles_number);
mse_test=zeros(1,cycles_number);
k=1;
Wh=initialWh;
Wo=initialWo;
while (trainingcycle<cycles_number+1)
    [Wh,Wo,mse_train(k)]=batch_training(i_train,t_train,Ni,No,Nh,train,learningrate,momentum,Wh,Wo,deltaWh,deltaWo);
    error_ftrain(k)=mse_train(k);
%Validation phase
    [mse_val(k)]=validation(i_val,t_val,Ni,No,Nh,val,Wh,Wo);
    error_fval(k)=mse_val(k);
%Test phase
    [mse_test(k)]=testing(i_test,t_test,Ni,No,Nh,test,Wh,Wo);
    error_ftest(k)=mse_test(k);
%Early stopping   
    if error_fval(k)<success
    disp('Error thresold reached: ')
    disp(error_fval(k))
    disp('Epochs: ')
    disp(trainingcycle)
    break
    end
    trainingcycle=trainingcycle+1;
    k=k+1;
end
if error_fval(k-1)>success
   disp('Training cycle concluded. Mean square error equal to: ')
   disp(error_fval(k-1))
end
finalWh=Wh;
finalWo=Wo;
end
 


