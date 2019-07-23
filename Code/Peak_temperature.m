function [Tpeak_mag,Tpeak_demag]=Peak_temperature(H_array,T_diagram,dTad_mag,dTad_demag,dTad_mag_max,dTad_demag_max)
Tpeak_mag=zeros(length(H_array)-1,1);
Tpeak_demag=zeros(length(H_array)-1,1);
for i=2:1:length(H_array)
    for j=1:1:length(T_diagram)
        if dTad_mag(i,j)==dTad_mag_max(i)
           Tpeak_mag(i-1)=T_diagram(j);
        elseif dTad_demag(i,j)==dTad_demag_max(i)
           Tpeak_demag(i-1)=T_diagram(j);
        end
    end
end
end