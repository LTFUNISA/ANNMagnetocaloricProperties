function [in,target]=Format_mapping(H_array,T_array,Ni,No,mag_data,cp_data)
in=zeros(length(H_array)*length(T_array),Ni);
target=zeros(length(H_array)*length(T_array),No);
k=1;
for i=1:1:length(H_array)
    for j=1:1:length(T_array)
        in(k,1)=H_array(i);
        in(k,2)=T_array(j);
        target(k,1)=mag_data(i,j);
        target(k,2)=cp_data(i,j);
        k=k+1;
    end
end
end