function [i_test,t_test]=random_test(test,i_test,t_test,Ni,No)
indicitestrandom=randperm(test,test);
for i=1:1:Ni
    for l=1:1:test
        i_test(i,l)=i_test(i,indicitestrandom(l));
    end
end
for j=1:1:No
    for l=1:1:test
        t_test(j,l)=t_test(j,indicitestrandom(l));
    end
end
end