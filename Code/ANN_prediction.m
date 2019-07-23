function [mag,cp]=ANN_prediction(H_array,T_diagram,map_i,map_t,Wh,Wo)
input_diagram=zeros(length(H_array)*length(T_diagram),2);
k=1;
for i=1:1:length(H_array)
    for j=1:1:length(T_diagram)
        input_diagram(k,1)=H_array(i);
        input_diagram(k,2)=T_diagram(j);
        k=k+1;
    end
end
output_predicted=ANN_model(input_diagram',map_i,map_t,Wh,Wo);
mag=zeros(length(H_array),length(T_diagram));
cp=zeros(length(H_array),length(T_diagram));
k=1;
for i=1:1:length(H_array)
    for j=1:1:length(T_diagram)
        mag(i,j)=output_predicted(1,k);
        cp(i,j)=output_predicted(2,k);
        k=k+1;
    end
end
end