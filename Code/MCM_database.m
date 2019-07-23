function [Wh,Wo,map_i,map_t,rho]=MCM_database(material)
if strcmp(material,'Gd')==1
    Wh=load('Gd_Wh.txt');
    Wo=load('Gd_Wo.txt');
    map_i=load('Gd_mapi.txt');
    map_t=load('Gd_mapt.txt');
    rho=7900;
elseif strcmp(material,'LaFeCoSi1')==1
    Wh=load('LaFeCoSi1_Wh.txt');
    Wo=load('LaFeCoSi1_Wo.txt');
    map_i=load('LaFeCoSi1_mapi.txt');
    map_t=load('LaFeCoSi1_mapt.txt');
    rho=6980;
elseif strcmp(material,'LaFeCoSi2')==1
    Wh=load('LaFeCoSi2_Wh.txt');
    Wo=load('LaFeCoSi2_Wo.txt');
    map_i=load('LaFeCoSi2_mapi.txt');
    map_t=load('LaFeCoSi2_mapt.txt');
    rho=7290;
elseif strcmp(material,'LaFeCoSi3')==1
    Wh=load('LaFeCoSi3_Wh.txt');
    Wo=load('LaFeCoSi3_Wo.txt');
    map_i=load('LaFeCoSi3_mapi.txt');
    map_t=load('LaFeCoSi3_mapt.txt');
    rho=7160;
else
    warning('The material is not included in the database')
    return;
end
end