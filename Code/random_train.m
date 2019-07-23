function [i_train,t_train]=random_train(train,i_train,t_train,Ni,No)
xtrain=randperm(train,train);
for i=1:1:Ni
    for l=1:1:train
        i_train(i,l)=i_train(i,xtrain(l));
    end
end
for j=1:1:No
    for l=1:1:train
        t_train(j,l)=t_train(j,xtrain(l));
    end
end
end