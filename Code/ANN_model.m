function [output]=ANN_model(input,map_i,map_t,Wh,Wo)
[i_n]=Test_normalization(input,map_i);
[output_n]=tanlin_ANN(i_n,Wh,Wo);
[output]=denormalize(output_n,map_t);
end