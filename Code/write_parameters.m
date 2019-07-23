function write_parameters(Wh,Wo,map_i,map_t,Wh_file,Wo_file,mapi_file,mapt_file)
fop1=fopen(Wh_file,'wt');
for i=1:1:size(Wh,1)
    for j=1:1:size(Wh,2)
        if j==size(Wh,2)
           fprintf(fop1,'%.4f\n',Wh(i,j));
        else
           fprintf(fop1,'%.4f\t',Wh(i,j));
        end
    end
end
fclose(fop1);

fop2=fopen(Wo_file,'wt');
for i=1:1:size(Wo,1)
    for j=1:1:size(Wo,2)
        if j==size(Wo,2)
           fprintf(fop2,'%.4f\n',Wo(i,j));
        else
           fprintf(fop2,'%.4f\t',Wo(i,j));
        end
    end
end
fclose(fop2);

fop3=fopen(mapi_file,'wt');
for i=1:1:size(map_i,1)
    for j=1:1:size(map_i,2)
        if j==size(map_i,2)
           fprintf(fop3,'%.4f\n',map_i(i,j));
        else
           fprintf(fop3,'%.4f\t',map_i(i,j));
        end
    end
end
fclose(fop3);

fop4=fopen(mapt_file,'wt');
for i=1:1:size(map_t,1)
    for j=1:1:size(map_t,2)
        if j==size(map_t,2)
           fprintf(fop4,'%.4f\n',map_t(i,j));
        else
           fprintf(fop4,'%.4f\t',map_t(i,j));
        end
    end
end
fclose(fop4);
end