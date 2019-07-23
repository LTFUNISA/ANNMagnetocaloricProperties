function [square_R]=Determination_coefficient(No,target,output)
pattern=size(target,2);
RSS=0; 
square_sum=0;
for i=1:1:No
    for k=1:1:pattern
        RSS=RSS+(target(i,k)-output(i,k))^2;
        square_sum=square_sum+(target(i,k))^2;
    end
end
square_R=1-RSS/square_sum;
end