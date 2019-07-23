function write_results(Nh,MAPE_M,MAPE_cp,MAE_M,MAE_cp,square_R,results_file)
fop1=fopen(results_file,'wt');
fprintf(fop1,'%s\t','Nh [\]: ');
fprintf(fop1,'%.0f\n',Nh);
fprintf(fop1,'%s\t','MAPE_M [%]: ');
fprintf(fop1,'%.4f\n',MAPE_M);
fprintf(fop1,'%s\t','MAPE_cp [%]: ');
fprintf(fop1,'%.4f\n',MAPE_cp);
fprintf(fop1,'%s\t','MAE_M [A/m]: ');
fprintf(fop1,'%.1f\n',MAE_M);
fprintf(fop1,'%s\t','MAE_cp [J/kgK]:');
fprintf(fop1,'%.1f\n',MAE_cp);
fprintf(fop1,'%s\t','square_R [\]: ');
fprintf(fop1,'%.4f\n',square_R);
fclose(fop1);
end