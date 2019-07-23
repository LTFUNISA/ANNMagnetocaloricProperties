function plot_results(T_diagram,H_array,mag,cp,dSiso,Stot_th,Stot_mag,dTad_mag,dTad_demag,dTad_mag_max,dTad_demag_max,Tpeak_mag,Tpeak_demag)

figure(1)
subplot(2,1,1)
plot(T_diagram,mag)
xlabel('T [K]','FontSize',16)
ylabel('M [A m^{-1}]','FontSize',16)
title('Magnetization','FontSize',18)
xlim([260 310])
grid on
subplot(2,1,2)
plot(T_diagram,cp)
xlabel('T [K]','FontSize',16)
ylabel('c_{p} [J kg^{-1}K^{-1}]','FontSize',16)
title('Specific heat at a constant magnetic field','FontSize',18)
xlim([260 310])
grid on

figure(2)
plot(T_diagram,abs(dSiso))
xlabel('T [K]','FontSize',16)
ylabel('|\DeltaS_{iso}| [J kg^{-1}K^{-1}]','FontSize',16)
title('Isothermal Entropy Change','FontSize',18)
xlim([260 310])
grid on

figure(3)
subplot(2,1,1)
plot(T_diagram,Stot_th,T_diagram,Stot_mag)
xlabel('T [K]','FontSize',16)
ylabel('s [J kg^{-1}K^{-1}]','FontSize',16)
title('s-T diagram','FontSize',18)
xlim([260 310])
grid on
subplot(2,1,2)
plot(T_diagram,dTad_mag,T_diagram,dTad_demag)
xlabel('T [K]','FontSize',16)
ylabel('\DeltaT_{ad} [K]','FontSize',16)
title('Adiabatic temperature change','FontSize',18)
xlim([260 310])
grid on

figure(4)
subplot(2,1,1)
plot(H_array,dTad_mag_max,'o')
xlabel('H [T]','FontSize',16)
ylabel('\DeltaT_{ad,max} [K]','FontSize',16)
title('Maximum Adiabatic temperature change (Magnetisation phase)','FontSize',18)
grid on
subplot(2,1,2)
plot(H_array,dTad_demag_max,'o')
xlabel('H [T]','FontSize',16)
ylabel('\DeltaT_{ad,max} [K]','FontSize',16)
title('Maximum Adiabatic temperature change (Demagnetisation phase)','FontSize',18)
grid on

figure(5)
subplot(2,1,1)
plot(H_array(1,2:end),Tpeak_mag,'o')
xlabel('H [T]','FontSize',16)
ylabel('T_{peak} [K]','FontSize',16)
ylim([270 300])
title('Peak temperature (Magnetisation phase)','FontSize',18)
grid on
subplot(2,1,2)
plot(H_array(1,2:end),Tpeak_demag,'o')
xlabel('H [T]','FontSize',16)
ylabel('T_{peak} [K]','FontSize',16)
title('Peak temperature (Demagnetisation phase)','FontSize',18)
ylim([270 300])
grid on
end