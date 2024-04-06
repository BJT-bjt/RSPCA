function [Train_data, Train_label, Test_data, Test_label] = Ransample_vecrate(fea,gnd,trainrate)
% Randomly selecte training data and rest data with a statsic rate. (Vec version)
    Train_label = [];  
    Test_label = [];   
    Train_data=[];
    Test_data=[];
    c = length(unique(gnd)); 
    a = hist(gnd,unique(gnd));
    a = a';
    a_train = round(a*trainrate);
    a_test = a - a_train;
    temp=0;
    for k=1:c
    B=[];                        
    C=[];                        
    b=randperm(a(k,1))+temp;     
    for i=1:a_train(k,1)         
        B=[B;fea(b(1,i),:)];      
    end

    for j=a_train(k,1)+1:a(k,1)
        C=[C;fea(b(:,j),:)];
    end
    Train_data=[Train_data;B];
    Test_data=[Test_data;C];
    Train_label=[Train_label;k*ones(a_train(k,1),1)];
    Test_label=[Test_label;k*ones(a_test(k,1),1)];
    temp=temp+a(k,1);
end