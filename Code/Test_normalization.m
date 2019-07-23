function [i_n]=Test_normalization(ingressi,map_i)
Ni=size(ingressi,1);
pattern=size(ingressi,2);
maxinput=map_i(2,:);
mininput=map_i(1,:);
i_n=zeros(Ni,pattern);
for i=1:1:Ni
    for l=1:1:pattern
        i_n(i,l)=-1+2*(ingressi(i,l)-mininput(i))/(maxinput(i)-mininput(i));
    end
end