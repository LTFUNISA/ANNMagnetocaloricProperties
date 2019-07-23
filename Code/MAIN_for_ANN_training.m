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
%Here, a new Artificial Neural Network can be defined for new materials 
%or to improve the performance of an existing ANN for known materials.
%
%During the training procedure, the results of each trial are showed in the
%command window. After the training is completed, its performance are saved
%in a .txt file, as well as the parameters of the network, i.e. the
%synaptic weights and the input-output mapping. The latter could be used as
%input of the codes for the calculation of the magnetocaloric properties.
%The final results are showed with 4 plots, depicting: 
%(Figure 1) the values of MAPE as a function of different sizes of the hidden layer;
%(Figure 2) the evolution of mse over the epochs for the train, validation
%and test set;
%(Figure 3) the comparison of the predicted vs experimental magnetisation
%as a function of the absolute temperature at the maximum magnetic field;
%(Figure 4) the comparison of the predicted vs experimental specific heat
%as a function of the absolute temperature at the maximum magnetic field;

function [Wh,Wo,map_i,map_t]=MAIN_for_ANN_training()
%Define data
mag_table=load('mag_table_Specimen1.txt');
cp_table=load('cp_table_Specimen1.txt');
[r,c]=size(mag_table);
T_array=mag_table(1,2:c);
H_array=mag_table(2:r,1);
mag_data=mag_table(2:r,2:c);
cp_data=cp_table(2:r,2:c);
%Create input-target array
Ni=2;
No=2;
[in,target]=Format_mapping(H_array,T_array,Ni,No,mag_data,cp_data);
%Define Nh array for the trial and error procedure needed to identify the
%best hidden layer size
Nhmin=2*Ni+1;
Nhmax=15;
Nh=Nhmin:1:Nhmax;
%Define filename to write
Wh_file='Wh.txt';
Wo_file='Wo.txt';
mapi_file='map_i.txt';
mapt_file='map_t.txt';
results_file='Train_results.txt';
%Training procedure
initial_MAPE_threshold=10;%Set the maximum reasonable value of Mean Absolute Percentage Error
net_success=0;
z=0;
while net_success==0
[map_i,map_t,Wh,Wo,Nh_opt,MAPE_array,MAPE_M,MAPE_cp,MAE_M,MAE_cp,square_R,mse_train,mse_val,mse_test]=ANN_Training(in,target,No,Nh);
MAPE_ave=mean([MAPE_M MAPE_cp]);
    if MAPE_ave<initial_MAPE_threshold*(1+z/10)
        disp('MAPE value is lower than target. Its value is equal to:')
        disp(MAPE_ave)
        net_success=1;
        figure(1)
        plot(Nh,MAPE_array)
        xlabel('N_{h}','FontSize',16)
        ylabel('MAPE [%]','FontSize',16)
        figure(2)
        plot(mse_train)
        hold on
        plot(mse_val)
        hold on
        plot(mse_test)
        xlabel('Epochs','FontSize',16)
        ylabel('mse','FontSize',16)
        legend({'train','validation','test'},'FontSize',16)
        set(gca, 'YScale', 'log')
        write_parameters(Wh,Wo,map_i,map_t,Wh_file,Wo_file,mapi_file,mapt_file);
        write_results(Nh_opt,MAPE_M,MAPE_cp,MAE_M,MAE_cp,square_R,results_file);
    else
        disp('MAPE is too large. Its value is: ')
        disp(MAPE_ave)
        z=z+1;
    end
end
%Simulation of data and comparison with the experimental data at the maximum
%magnetic field as a function of temperature
[output]=ANN_model(in',map_i,map_t,Wh,Wo);
k=1;
mag_pred_table=zeros(length(H_array),length(T_array));
cp_pred_table=zeros(length(H_array),length(T_array));
for i=1:1:length(H_array)
    for j=1:1:length(T_array)
        mag_pred_table(i,j)=output(1,k);
        cp_pred_table(i,j)=output(2,k);
        k=k+1;
    end
end    
figure(3)
plot(T_array,mag_pred_table(r-1,:)','-',T_array,mag_data(r-1,:)','o')
xlabel('T [K]','FontSize',16)
ylabel('M [A m^{-1}]','FontSize',16)
legend({'M predicted at H maximum','M measured at H maximum'},'FontSize',16)
figure(4)
plot(T_array,cp_pred_table(r-1,:)','-',T_array,cp_data(r-1,:)','o')
xlabel('T [K]','FontSize',16)
ylabel('c_{p} [J kg^{-1}K^{-1}]','FontSize',16)
legend({'cp predicted at H maximum','cp measured at H maximum'},'FontSize',16)
end