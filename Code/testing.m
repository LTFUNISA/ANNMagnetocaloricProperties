function [mse_test]=testing(i_test,t_test,Ni,No,Nh,test,Wh,Wo)
vh=zeros(Nh,test);
vo=zeros(No,test);
hidden=zeros(Nh,test);
output=zeros(No,test);
erroreOtest=zeros(No,test);
squareerrortest=zeros(No,test);
%Sorting input
[i_test,t_test]=random_test(test,i_test,t_test,Ni,No);    
%Indexing pattern sequence
    for indicetest=1:1:test
    % hidden layer response calculation
        for k=1:1:Nh
            vh(k,indicetest)=0;
            for i=1:1:Ni
                vh(k,indicetest)=vh(k,indicetest)+Wh(k,i)*i_test(i,indicetest);%induced field calculation                 
            end
            vh(k,indicetest)=vh(k,indicetest)+Wh(k,Ni+1);%bias k-th hidden neuron
            hidden(k,indicetest)=2/(1+exp(-2*vh(k,indicetest)))-1;
        end
    % output layer response calculation
        for j=1:1:No
            vo(j,indicetest)=0;
            for k=1:1:Nh
                vo(j,indicetest)=vo(j,indicetest)+Wo(j,k)*hidden(k,indicetest);                   
            end  
            vo(j,indicetest)=vo(j,indicetest)+Wo(j,Nh+1);
            output(j,indicetest)=vo(j,indicetest);
        end  
 %error calculation
        for j=1:1:No
            erroreOtest(j,indicetest)=t_test(j,indicetest)-output(j,indicetest);
            squareerrortest(j,indicetest)=erroreOtest(j,indicetest)^2;
        end 
    end
    
    mse_test=sum(sum(squareerrortest))/(test*Nh);
end