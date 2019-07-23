function [index_train,index_val,index_test]=sorting_data(train,val,test,pattern)
index_train=randperm(pattern,train);
index_val=randperm(pattern,val);
index_test=randperm(pattern,test);
end