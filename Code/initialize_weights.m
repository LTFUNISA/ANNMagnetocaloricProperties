function [Wh,Wo,deltaWh,deltaWo]=initialize_weights(Ni,Nh,No)
deltaWo=zeros(No,Nh+1);
deltaWh=zeros(Nh,Ni+1);
minimum=-1;
maximum=1;
Wh=minimum+(maximum-minimum)*rand(Nh,Ni+1);
Wo=minimum+(maximum-minimum)*rand(No,Nh+1);
end
