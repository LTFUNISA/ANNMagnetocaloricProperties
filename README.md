# MagProp

# Contents
Overview\
Repository
System requirements (Hardware and Software)
Installation guide
User information
Instructions for use with provided data
File dependencies
Reproducibility
Pseudocodes

# Overview

Here, we present a new procedure to evaluate thermodynamic properties of magnetocaloric materials based on Artificial Neural Networks (ANNs). This methodology has been developed to speed up the characterisation of new magnetocaloric materials and facilitate the design process for a magnetic refrigerator. Indeed, it requires a small amount of experimental data to characterise an MCM accurately, in comparison with other commonly-used techniques. 
Three different codes are provided to run the procedure within the MATLAB environment. The first code is related to the training of the ANN starting from the experimental data. The second code allows to use the evaluation method within an AMR numerical simulation model. The last code provides a database of the thermodynamic properties of magnetocaloric materials, based on the learning capabilities of the Artificial Neural Networks. 
To run the codes, execute the following m-files:
•‘MAIN_for_ANN_training.m’, for training an ANN;
•‘MAIN_Adiabatic_temperature_change.m’, for the evaluation of the adiabatic temperature change and the specific heat at a specific point;
•	‘MAIN_MagProp.m’, for evaluate magnetocaloric properties of a specific material over the desired range.

# Repository

•	Code: functions package;
•	Data: data provided to test the codes;
•	Results: some example of outputs.
System requirements (Hardware and Software)
The proposed codes require only a standard computer with enough RAM to support the operations within MATLAB environment. No specific hardware is required. According to the release, a minimum value of 2 GB or 4 GB of RAM is suggested, for MATLAB R2017b and MATLAB R2018a, respectively. For better performance, values more than 4 GB and 8 GB are recommended for MATLAB R2017b and MATLAB R2018a, respectively. There are no minimum specifications for the performance of the CPU (https://it.mathworks.com/support/sysreq/previous_releases.html).
The codes have been tested on the following two systems:
1.	OS: Windows 10 Home (version 1803)
            CPU: 6 cores, 2.20 GHz/core, max. 4.10 GHz/core. RAM 16 GB
2.	OS: Windows 10 Home 
            CPU: 2 cores, 1.70 GHz/core, max. 2.4 GHz/core. RAM 4 GB
About the software version, the following releases have been tested:
1.	MATLAB R2018a (9.4);
2.	MATLAB R2017b (9.3).
No specific toolbox are required to run the proposed codes.

# Installation guide

No specific software installation is required. Just MATLAB must be installed on your computer to run the codes. The time required to install this software is strongly related to the number of packages or toolboxes required for the execution of a code. In this case, this time should be the lowest possible since the codes here presented don’t need any specific additional package to be run.

# User information

The first code aims to train an Artificial Neural Network to predict the value of magnetisation and specific heat as a function of absolute temperature and magnetic field. It could be used when a new characterisation is needed or when one wants to improve the prediction performance of previous ANNs. To run this code, it is needed to enter the following command in the command window:

>> [Wh,Wo,map_i,map_t]=MAIN_for_ANN_training()

The input are loaded after the code is launched from two .txt files. The name of these files can be changed in ‘MAIN_for_ANN_training.m’ at line 27-28.   The latter must have a structure like that in ‘mag_table_Specimen1.txt’ and ‘cp_table_Specimen1.txt’. The name of these files can be changed in ‘MAIN_for_ANN_training.m’ at line 27-28. During the training procedure, the results of each trial are showed in the command window. After the training is completed, its performance are saved in a .txt file, as well as the parameters of the network, i.e. the synaptic weights and the input-target mapping. At line 44-48 of ‘MAIN_for_ANN_training.m’ is possible to change the name of these files. The synaptic weights, the input-output mapping and the performance of the ANN training represent the output of the code. Some changes can be made according to needs. For example, the range of investigation of the hidden layer size can be modified at line 40-41 of ‘MAIN_for_ANN_training.m’, as well as the maximum reasonable Mean Absolute Percentage Error (MAPE) at line 50.  In ‘Data_clustering.m’ is possible to change the percentages of data that compose the train, validation and test set whereas the training parameters can be modified in ‘set_train_parameters.m’. The running time of this code strongly depends on the parameters used to train the ANN. With the system used so far, it is in the range between 50 s and 480 s.
The second code could be integrated with an AMR numerical model for the evaluation of the adiabatic temperature change (dTad) and the specific heat (cp) based on the use of an ANN.  It allows to calculate them considering the previous value of the magnetic field (Hprev), the new one (H) and the previous value of the temperature (Tprev) of the MCM. To run this code, it is needed to enter the following command in the command window:

>> [dTad,cp]=MAIN_Adiabatic_temperature_change(Hprev,H,Tprev)

To calculate the output variables, the parameters of the ANN, i.e. synaptic weights and input-output mapping, are loaded from four .txt file, which are defined at line 21-24 in ‘MAIN_Adiabatic_temperature_change.m’. These files are provided as output by the execution of ‘MAIN_for_ANN_training.m’. Their name must be changed according to the MCM, as well as the value of density at line 34. The running time of this code is about 0.04 s with the system 1 in System requirements Section.
The third code allows to point out the main thermodynamic properties of a MCM, based on the use an ANN. After a new MCM is characterised by ANN (running ‘MAIN_for_ANN_training’), i.e. synaptic weights and input-output mapping are identified, one can execute this code to evaluate the behaviour of the MCM over the desired range. To run this code, it is needed to enter the following command in the command window:

>>[T_diagram,H_array,mag,cp,dSiso,Stot_th,Stot_mag,dTad_mag,dTad_demag,dTad_mag_max,dTad_demag_max,Tpeak_mag,Tpeak_demag]=MAIN_MagProp()

The code loads the needed parameters from the .txt files where they have been previously saved as output of ‘MAIN_for_ANN_training’. After launching the code, the program asks which kind of material you want to evaluate the properties. The already available materials are listed in ‘Available Materials.txt’, where it is possible to get the codes required to enter the query. Then, all the main magnetocaloric properties (magnetisation, specific heat, isothermal entropy change, adiabatic temperature change, peak temperatures) are calculated as functions of the absolute temperature and the magnetic field over the desired range. Some keyboard input are needed to define the calculation procedure, such as: temperature step, magnetic field step and maximum magnetic field. In the end, it is possible to save the data into a worksheet for further analysis and investigation and to compare the predicted values with the experimental results. Enter ‘y’ or ‘n’ for saving the data or not, respectively. The running time depends on the input entered from the keyboard during the execution of the code. Hence, it cannot be defined a priori.

# Instructions for use with provided data

To test the first code, it is just needed to run ‘MAIN_for_ANN_training.m". The program will read the experimental data for training an ANN from the provided files related to the Specimen 1, ‘mag_table_Specimen1.txt’ and ‘cp_table_Specimen1.txt’. In the end, one can see the results by four different pictures, as follows:
•	(Figure 1): values of MAPE as a function of different sizes of the hidden layer;
•	(Figure 2): the evolution of mse (mean square error) over the epochs for the train, validation and test set;
•	(Figure 3): the comparison of the predicted vs experimental magnetisation as a function of the absolute temperature at the maximum magnetic field;
•	(Figure 4): the comparison of the predicted vs experimental specific heat as a function of the absolute temperature at the maximum magnetic field;
Furthermore, the performance of the training will be saved in ‘Train_results.txt’ whereas the parameters of the trained ANN, i.e. synaptic weights linking input and hidden layer, synaptic weights linking hidden and output layer, input and target mapping, will be saved in 'Wh.txt', 'Wo.txt', 'map_i.txt' and 'map_t.txt', respectively.
To test the second code, it is needed to enter the following command in the command window:

>> [dTad,cp]=MAIN_Adiabatic_temperature_change(0,1,272)

where 0 is the value of Hprev in T, 1 is the value of H in T and 272 is the value of previous temperature in K. One can change these values as it likes. The code will read the parameters of the ANN from the same files where they are saved after the execution of the training. Hence, in this case, the second code will provide the prediction of the adiabatic temperature change and the specific heat for the Specimen 1. These values will be displayed in the command window.
To test the third code, it is just needed to run ‘MAIN_MagProp.m’. Before doing this, it is recommended to open ‘Available Materials.txt’, where the MCMs, for which the ANN parameters are provided, are listed with the respective code item needed to run the program. Once this file is open, the user can decide of which MCM wants to predict the properties. Then, the program will ask to set the temperature and the magnetic field step for the evaluation. It is recommended to choose between 0.001 K and 1 K for the temperature step, and between 0.1 T and 0.5 T for the magnetic field. This is for ensuring a good clarity of the figures. However, a smaller step of magnetic field can be selected. Then, the user must set the maximum magnetic field, that should be 1 T. In the end, it will be possible to save the data in a .xlsx file for further investigations. Enter ‘y’ or ‘n’ for saving the data or not, respectively.

# File dependencies

All file dependencies can be found in "Readme.docx".

# Reproducibility
All the data reported in the paper “Magnetocaloric effect in Gadolinium and LaFe13_x_yCoxSiy alloys: a novel approach based on indirect measurements using artificial neural networks” by Angelo Maiorino, Manuel Gesù Del Duca, Jaka Tušek, Urban Tomc, Andrej Kitanovski and Ciro Aprea can be reproduced using the third code described above (‘MAIN_MagProp.m’). All the parameters of the four ANNs developed and used for the four MCMs investigated are provided with the main code. Hence, to reproduce the same results, it is needed to run ‘MAIN_MagProp.m’ four times, changing the material code each time according to ‘Available Materials.txt’. Furthermore, the temperature and the magnetic field step must be set to 0.1 K and 0.25 T, respectively. The upper limit of the magnetic field must be set to 1 T. 

# Pseudocodes

All pseudocodes can be found in "Readme.docx".

 

