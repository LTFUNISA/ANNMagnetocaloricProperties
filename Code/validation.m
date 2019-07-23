function [mse_val]=validation(i_val,t_val,Ni,No,Nh,val,Wh,Wo)
vh=zeros(Nh,val);
vo=zeros(No,val);
hidden=zeros(Nh,val);
output=zeros(No,val);
erroreOval=zeros(No,val);
squareerrorval=zeros(No,val);
%Sorting input
[i_val,t_val]=random_val(val,i_val,t_val,Ni,No);
%Indexing pattern sequence
for indiceval=1:1:val
    % hidden layer response calculation
        for k=1:1:Nh
            vh(k,indiceval)=0;
            for i=1:1:Ni
                vh(k,indiceval)=vh(k,indiceval)+Wh(k,i)*i_val(i,indiceval);%induced field calculation                 
            end
            vh(k,indiceval)=vh(k,indiceval)+Wh(k,Ni+1);%bias k-th hidden neuron
            hidden(k,indiceval)=2/(1+exp(-2*vh(k,indiceval)))-1;
        end
    % output layer response calculation
        for j=1:1:No
            vo(j,indiceval)=0;
            for k=1:1:Nh
                vo(j,indiceval)=vo(j,indiceval)+Wo(j,k)*hidden(k,indiceval);                  
            end      
            vo(j,indiceval)=vo(j,indiceval)+Wo(j,Nh+1);
            output(j,indiceval)=vo(j,indiceval);
        end  
    %error calculation
        for j=1:1:No
            erroreOval(j,indiceval)=t_val(j,indiceval)-output(j,indiceval);
            squareerrorval(j,indiceval)=erroreOval(j,indiceval)^2; 
        end      
end

mse_val=sum(sum(squareerrorval))/(val*Nh);
end