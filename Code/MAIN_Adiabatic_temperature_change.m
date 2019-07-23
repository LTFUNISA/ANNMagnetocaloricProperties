%Evaluating magnetocaloric effect in magnetocaloric materials: 
%a novel approach based on indirect measurements using artificial neural networks
%Angelo Maiorino, Manuel Gesù Del Duca, Jaka Tušek, Urban Tomc, 
%Andrej Kitanovski and Ciro Aprea
%
%Code authors: Angelo Maiorino, Manuel Gesù Del Duca, Jaka Tušek, Urban Tomc, 
%Andrej Kitanovski and Ciro Aprea 
%e-mail: amaioriono@unisa.it, mdelduca@unisa.it
%
%Copyright (c) 2019, Angelo Maiorino, Manuel Gesù Del Duca, Jaka Tušek, Urban Tomc, 
%Andrej Kitanovski and Ciro Aprea 
%All rights reserved.
%
% Redistribution and use in source and binary forms, with or without modification,
%are permitted provided that the following conditions are met:
% 1. Redistributions of source code must retain the above copyright notice, 
%    this list of conditions and the following disclaimer. 
% 2. Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
% IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
% BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
% OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
% WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
%
%This code could be integrated with an AMR numerical model for the
%evaluation of the adiabatic temperature change and the specific heat
%based on the use of an Artificial Neural Network (ANN). 
%It allows to calculate them considering the previous value of the
%magnetic field (Hprev), the new one (H) and the previous value of the
%temperature of the MCM. Furthermore, the code has to load the parameters
%of the trained ANN, which depends on the specific MCM. These data are
%provided as output by running "MAIN_for_ANN_training".
%For testing a different material, one has to change the file references 
%of these parameters (line from 21 to 24) and the value of the density (line 34). 

function [dTad,cp]=MAIN_Adiabatic_temperature_change(Hprev,H,Tprev)
%Load ANN parameters
Wh=load('Wh.txt');
Wo=load('Wo.txt');
map_i=load('map_i.txt');
map_t=load('map_t.txt');
Tmin=map_i(1,2);
Tmax=map_i(2,2);
Hmin=map_i(1,1);
Hmax=map_i(2,1);
Mmin=map_t(1,1);
Mmax=map_t(2,1);
Nh=size(Wh,1);
Ni=size(Wh,2)-1;
%Density of the material in kg/m^3
rho=6980;
%Total entropy evaluation at H=0
T_diagram=250:0.1:310;
H_diagram=0;
input_diagram=zeros(length(H_diagram)*length(T_diagram),2);
k=1;
for i=1:1:length(H_diagram)
    for j=1:1:length(T_diagram)
        input_diagram(k,1)=H_diagram(i);
        input_diagram(k,2)=T_diagram(j);
        k=k+1;
    end
end
output_diagram=ANN_model(input_diagram',map_i,map_t,Wh,Wo);
cp_fitted=output_diagram(2,:);
Stot_th=zeros(1,length(T_diagram));
Stot_th(1)=0;
for i=2:1:length(T_diagram)
    Stot_th(i)=Stot_th(i-1)+cp_fitted(i)*(log(T_diagram(i))-log(T_diagram(i-1)));
end
%Magnetic entropy change evaluation at H=Hprev and H=H
H_array=[Hprev H];
dSiso_mapping=zeros(length(H_array),length(T_diagram));
B=(Hmax-Hmin)/(Tmax-Tmin);
for i=1:1:length(H_array)
    for j=1:1:length(T_diagram)
        for k=1:1:Nh
            C=(Wo(1,k)*Wh(k,2))/Wh(k,1);
            AH=Wh(k,2)*(Tmin+Tmax-2*T_diagram(j))/(Tmin-Tmax)+Wh(k,1)*(Hmin+Hmax-2*H_array(i))/(Hmin-Hmax)+Wh(k,Ni+1);
            A0=Wh(k,2)*(Tmin+Tmax-2*T_diagram(j))/(Tmin-Tmax)+Wh(k,1)*(Hmin+Hmax)/(Hmin-Hmax)+Wh(k,Ni+1);
            dSiso_mapping(i,j)=dSiso_mapping(i,j)+B*C*(tanh(AH)-tanh(A0));
        end
        dSiso_mapping(i,j)=dSiso_mapping(i,j)*(Mmax-Mmin)/2*1/rho;
    end
end
%Total entropy evaluation at H=Hprev and H=H
Stot_mag=zeros(length(H_array),length(T_diagram));
for i=1:1:length(H_array)
    for j=1:1:length(T_diagram)
        Stot_mag(i,j)=Stot_th(j)+dSiso_mapping(i,j);
    end
end
%Adiabatic temperature change evaluation by s-T diagram
Tmag=zeros(1,length(T_diagram-1));
dTad_mag=zeros(1,length(T_diagram-1));
for j=2:1:size(Stot_mag,2)
    Tmag(j)=interp1(Stot_mag(2,:),T_diagram(:),Stot_mag(1,j));
    dTad_mag(j)=Tmag(j)-T_diagram(j);
end
index=T_diagram==Tprev;
dTad=dTad_mag(index);
%Specific heat evaluation from ANN
input_new=[H;Tprev+dTad];
output_new=ANN_model(input_new,map_i,map_t,Wh,Wo);
cp=output_new(2);
end
