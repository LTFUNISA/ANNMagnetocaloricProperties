function [i_val,t_val]=random_val(val,i_val,t_val,Ni,No)
indicivalrandom=randperm(val,val);
for i=1:1:Ni
    for l=1:1:val
        i_val(i,l)=i_val(i,indicivalrandom(l));
    end
end
for j=1:1:No
    for l=1:1:val
        t_val(j,l)=t_val(j,indicivalrandom(l));
    end
end
end