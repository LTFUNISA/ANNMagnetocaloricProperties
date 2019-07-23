function [output]=denormalize(output_n,map_t)
pattern=size(output_n,2);
No=size(output_n,1);
output=zeros(No,pattern);
maxtarget=map_t(2,:);
mintarget=map_t(1,:);
for j=1:1:No
    for p=1:1:pattern
        output(j,p)=(output_n(j,p)*(maxtarget(j)-mintarget(j))+mintarget(j)+maxtarget(j))./2;
    end
end
