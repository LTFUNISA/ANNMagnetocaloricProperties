%A new artificial intelligence method to evaluate magnetocaloric properties
%Angelo Maiorino, Manuel Gesù Del Duca, Jaka Tušek, Urban Tomc, 
%Andrej Kitanovski and Ciro Aprea
%
%Code author: Manuel Gesù Del Duca 
%e-mail:mdelduca@unisa.it
%
% Copyright (c) 2018, Manuel Gesù Del Duca
% All rights reserved.
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
%This code allows to point out the main thermodynamic properties of a MCM,
%based on the use of Artificial Neural Network (ANN). After a new MCM is
%characterised by ANN (running "MAIN_for_ANN_training"), i.e. synaptic
%weights and input-output mapping are identified, one can execute this code
%to evaluate the behaviour of the MCM over the desired range. The code
%loads the needed parameters from the .txt files where they have been previously 
%saved. After launching the code, the program asks which kind of material you
%want to evaluate the properties. The already available materials are listed in
%"Available Materials.txt", where it is possible to get the codes required to enter
%the query. Then, all the main magnetocaloric properties (magnetisation, 
%specific heat, isothermal entropy change, adiabatic temperature change, peak
%temperatures) are calculated as functions of the absolute temperature and the 
%magnetic field over the desired range. Some keyboard input are needed to
%define the calculation procedure, such as: temperature step, magnetic
%field step and maximum magnetic field. In the end, it is possible to save
%the data into a worksheet for further analysis and investigation, and also
%to compare the predicted values with the experimental results.
%
%For any questions, please contact the Authors.

function [T_diagram,H_array,mag,cp,dSiso,Stot_th,Stot_mag,dTad_mag,dTad_demag,dTad_mag_max,dTad_demag_max,Tpeak_mag,Tpeak_demag]=MAIN_MagProp()
material=input('Select magnetocaloric material code in string format (See "Available Materials.txt"): ');
%Load material properties
[Wh,Wo,map_i,map_t,rho]=MCM_database(material);
%Set ANN parameters
Tmin=map_i(1,2);
Tmax=map_i(2,2);
Hmin=map_i(1,1);
Hmax=map_i(2,1);
Mmin=map_t(1,1);
Mmax=map_t(2,1);
Nh=size(Wh,1);
Ni=size(Wh,2)-1;
%Define queries
stepT=input('Define temperature step in K: ');
stepH=input('Define magnetic field step in T: ');
Hupper=input('Define upper limit of magnetic field range in T: ');
if Hupper>Hmax
    warning('The upper limit of the magnetic field is out of training range (1 T): the predictions may be inaccurate.')
    keyboard;
end
T_diagram=Tmin:stepT:Tmax;
H_array=Hmin:stepH:Hupper;
%Magnetization and cp evaluation
[mag,cp]=ANN_prediction(H_array,T_diagram,map_i,map_t,Wh,Wo);
%Total entropy evaluation at H=0 T
Stot_th=zeros(1,length(T_diagram));
Stot_th(1)=0;
for i=2:1:length(T_diagram)
    Stot_th(i)=Stot_th(i-1)+cp(1,i)*(log(T_diagram(i))-log(T_diagram(i-1)));
end
%Magnetic entropy change evaluation
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
dSiso=dSiso_mapping;
%Total entropy evaluation at the applied magnetic field
Stot_mag=zeros(length(H_array),length(T_diagram));
for i=1:1:length(H_array)
    for j=1:1:length(T_diagram)
        Stot_mag(i,j)=Stot_th(j)+dSiso_mapping(i,j);
    end
end
%Adiabatic temperature change evaluation by T-S diagram
Tmag=zeros(1,length(T_diagram-1));
Tdemag=zeros(1,length(T_diagram-1));
dTad_mag=zeros(length(H_array),length(T_diagram-1));
dTad_demag=zeros(length(H_array),length(T_diagram-1));
for i=1:1:length(H_array)
    for j=2:1:size(Stot_mag,2)
        Tmag(j)=interp1(Stot_mag(i,:),T_diagram(:),Stot_th(j));
        dTad_mag(i,j)=Tmag(j)-T_diagram(j);
        Tdemag(j)=interp1(Stot_th(:),T_diagram(:),Stot_mag(i,j));
        dTad_demag(i,j)=Tdemag(j)-T_diagram(j);
    end
end
dTad_mag_max=max(dTad_mag,[],2);
dTad_demag_max=min(dTad_demag,[],2);
[Tpeak_mag,Tpeak_demag]=Peak_temperature(H_array,T_diagram,dTad_mag,dTad_demag,dTad_mag_max,dTad_demag_max);
%Plot results
plot_results(T_diagram,H_array,mag,cp,dSiso,Stot_th,Stot_mag,dTad_mag,dTad_demag,dTad_mag_max,dTad_demag_max,Tpeak_mag,Tpeak_demag)
%Export to .xls file
save_data(H_array,T_diagram,mag,cp,dSiso,Stot_mag,dTad_mag,dTad_demag);
end
