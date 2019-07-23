function save_data(H_array,T_diagram,mag,cp,dSiso,Stot_mag,dTad_mag,dTad_demag)
save=input('Do you want saving data? (y or n in string format): ');
if strcmp(save,'y')==1
   filename=input('Name the workfile ("Myfile.xlsx"): ');
   worksheet_mag='Magnetization';
   worksheet_cp='Specific heat';
   worksheet_dSiso='dSiso';
   worksheet_sT='s-T diagram';
   worksheet_dTad_mag='dTad_mag';
   worksheet_dTad_demag='dTad_demag';
   xlswrite(filename,mag,worksheet_mag,'B2');
   xlswrite(filename,H_array',worksheet_mag,'A2');
   xlswrite(filename,T_diagram,worksheet_mag,'B1');
   xlswrite(filename,cp,worksheet_cp,'B2');
   xlswrite(filename,H_array',worksheet_cp,'A2');
   xlswrite(filename,T_diagram,worksheet_cp,'B1');
   xlswrite(filename,dSiso,worksheet_dSiso,'B2');
   xlswrite(filename,H_array',worksheet_dSiso,'A2');
   xlswrite(filename,T_diagram,worksheet_dSiso,'B1');
   xlswrite(filename,Stot_mag,worksheet_sT,'B2');
   xlswrite(filename,H_array',worksheet_sT,'A2');
   xlswrite(filename,T_diagram,worksheet_sT,'B1')
   xlswrite(filename,dTad_mag,worksheet_dTad_mag,'B2');
   xlswrite(filename,H_array',worksheet_dTad_mag,'A2');
   xlswrite(filename,T_diagram,worksheet_dTad_mag,'B1');
   xlswrite(filename,dTad_demag,worksheet_dTad_demag,'B2');
   xlswrite(filename,H_array',worksheet_dTad_demag,'A2');
   xlswrite(filename,T_diagram,worksheet_dTad_demag,'B1');
end
end