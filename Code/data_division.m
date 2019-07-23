function [train,val,test,i_train,i_val,i_test,t_train,t_val,t_test]=data_division(i_n,t_n,pattern,Ni,No,train_percentage,val_percentage,test_percentage)
trainpercentage=train_percentage;
valpercentage=val_percentage;
train=round(pattern/100*trainpercentage);
val=round(pattern/100*valpercentage);
test=test_percentage;
[index_train,index_val,index_test]=sorting_data(train,val,test,pattern);
i_train=zeros(Ni,train);
t_train=zeros(No,train);
i_val=zeros(Ni,val);
t_val=zeros(No,val);
i_test=zeros(Ni,test);
t_test=zeros(No,test);
for j=1:1:length(index_train)
    i_train(:,j)=i_n(:,index_train(j));
    t_train(:,j)=t_n(:,index_train(j));
end
for k=1:1:length(index_val)
    i_val(:,k)=i_n(:,index_val(k));
    t_val(:,k)=t_n(:,index_val(k));
end
for l=1:1:length(index_test)
    i_test(:,l)=i_n(:,index_test(l));
    t_test(:,l)=t_n(:,index_test(l));
end
end