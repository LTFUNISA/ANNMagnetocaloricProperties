function [output]=tanlin_ANN(in,Wh,Wo)
HL=size(Wh,1);
IL=size(Wh,2)-1;
OL=size(Wo,1);
pattern=size(in,2);
H=zeros(HL,pattern);
output=zeros(OL,pattern);
for p=1:1:pattern
    for k=1:1:HL
        v=0;
        for i=1:1:IL
        v=v+Wh(k,i)*in(i,p);
        end  
        v=v+Wh(k,IL+1);
        %H(k,p)=tanh(v);
        %H(k,p)=(exp(v)-exp(-v))/(exp(v)+exp(-v));
        H(k,p)=2/(1+exp(-2*v))-1;
    end
    for j=1:1:OL
        v=0;
        for k=1:1:HL
        v=v+Wo(j,k)*H(k,p);
        end    
    v=v+Wo(j,HL+1);
    output(j,p)=v;
    end
end        
        