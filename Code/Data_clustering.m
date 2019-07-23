function [train_percentage,val_percentage,test_percentage]=Data_clustering()
train_percentage=60;
val_percentage=20;
test_percentage=100-train_percentage-val_percentage;
end