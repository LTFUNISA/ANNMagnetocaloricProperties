function [Wh,Wo,mse_train]=batch_training(i_train,t_train,Ni,No,Nh,train,learningrate,momentum,Wh,Wo,deltaWh,deltaWo)
hidden=zeros(Nh,train);
output=zeros(No,train);
vh=zeros(Nh,train);
vo=zeros(No,train);
errorOtrain=zeros(No,train);
squareerrortrain=zeros(No,train);
gradientO=zeros(No,train);
errorH=zeros(Nh,train);
gradientH=zeros(Nh,train);
accumdeltaWo=zeros(No,Nh+1);
accumdeltaWh=zeros(Nh,Ni+1);
%Sorting input
[i_train,t_train]=random_train(train,i_train,t_train,Ni,No);
%Indexing pattern sequence
    for indicetrain=1:1:train
    % hidden layer response calculation
        for k=1:1:Nh
            for i=1:1:Ni
                vh(k,indicetrain)=vh(k,indicetrain)+Wh(k,i)*i_train(i,indicetrain);%induced field calculation
            end
            vh(k,indicetrain)=vh(k,indicetrain)+Wh(k,Ni+1);%bias k-th hidden neuron
            hidden(k,indicetrain)=2/(1+exp(-2*vh(k,indicetrain)))-1;
        end
    % output layer response calculation
        for j=1:1:No
            for k=1:1:Nh
            vo(j,indicetrain)=vo(j,indicetrain)+Wo(j,k)*hidden(k,indicetrain);              
            end      
            vo(j,indicetrain)=vo(j,indicetrain)+Wo(j,Nh+1);
            output(j,indicetrain)=vo(j,indicetrain);            
        end
        
       
    %error and local gradient calculation (output layer)
        for j=1:1:No
            errorOtrain(j,indicetrain)=t_train(j,indicetrain)-output(j,indicetrain);
            gradientO(j,indicetrain)=errorOtrain(j,indicetrain);
            squareerrortrain(j,indicetrain)=errorOtrain(j,indicetrain)^2; 
        end       
        
    %error and local gradient calculation (hidden layer)
        for k=1:1:Nh
            for j=1:1:No
                errorH(k,indicetrain)=errorH(k,indicetrain)+Wo(j,k)*gradientO(j,indicetrain);
            end
            gradientH(k,indicetrain)=errorH(k,indicetrain)*(1-hidden(k,indicetrain))*(1+hidden(k,indicetrain));%la derivata della funzione tangente iperbolica è (1-y)(1+y)
        end
       
    %charge changing (output layer)
        for j=1:1:No
            for k=1:1:Nh
                deltaWo(j,k)=learningrate*gradientO(j,indicetrain)*hidden(k,indicetrain)+(accumdeltaWo(j,k)/indicetrain)*momentum;
                accumdeltaWo(j,k)=accumdeltaWo(j,k)+deltaWo(j,k);                
            end
            deltaWo(j,Nh+1)=learningrate*gradientO(j,indicetrain)+(accumdeltaWo(j,Nh+1)/indicetrain)*momentum;
            accumdeltaWo(j,Nh+1)=accumdeltaWo(j,Nh+1)+deltaWo(j,Nh+1);
       end
    %charge changing (hidden layer)
       for k=1:1:Nh
           for i=1:1:Ni
               deltaWh(k,i)=learningrate*gradientH(k,indicetrain)*i_train(i,indicetrain)+(accumdeltaWh(k,i)/indicetrain)*momentum;
               accumdeltaWh(k,i)=accumdeltaWh(k,i)+deltaWh(k,i);
           end
           deltaWh(k,Ni+1)=learningrate*gradientH(k,indicetrain)+(accumdeltaWh(k,Ni+1)/indicetrain)*momentum;
           accumdeltaWh(k,Ni+1)=accumdeltaWh(k,Ni+1)+deltaWh(k,Ni+1);
       end
    end
    
    mse_train=sum(sum(squareerrortrain))/(train*Nh);
    
    %synpatic weights correction (output layer)
    for j=1:1:No
        for k=1:1:Nh
            Wo(j,k)=Wo(j,k)+accumdeltaWo(j,k)/train;
        end
        Wo(j,Nh+1)=Wo(j,Nh+1)+accumdeltaWo(j,Nh+1)/train;
    end
    
    %synaptic weights correction (hidden layer)
    for k=1:1:Nh
        for i=1:1:Ni
            Wh(k,i)=Wh(k,i)+accumdeltaWh(k,i)/train;
        end
        Wh(k,Ni+1)=Wh(k,Ni+1)+accumdeltaWh(k,Ni+1)/train;
    end
end