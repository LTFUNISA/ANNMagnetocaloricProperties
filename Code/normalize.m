function [i_n,t_n,map_i,map_t,pattern]=normalize(in,target)

%normalize input and output in the range [-1,1]
pattern=size(in,2);
Ni=size(in,1);
No=size(target,1);
maxinput=zeros(1,Ni);
maxtarget=zeros(1,No);
mininput=zeros(1,Ni);
mintarget=zeros(1,No);
for i=1:1:Ni
    maxinput(i)=max(in(i,:));
    mininput(i)=min(in(i,:));
    for l=1:1:pattern
        in(i,l)=-1+2*(in(i,l)-mininput(i))/(maxinput(i)-mininput(i));
    end
end
for j=1:1:No
    maxtarget(j)=max(target(j,:));
    mintarget(j)=min(target(j,:));
    for l=1:1:pattern
        target(j,l)=-1+2*(target(j,l)-mintarget(j))/(maxtarget(j)-mintarget(j));
    end
end
i_n=in;
t_n=target;
map_i=[mininput;maxinput];
map_t=[mintarget;maxtarget];
end
