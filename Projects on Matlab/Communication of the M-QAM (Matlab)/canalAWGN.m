function [rn] = canalAWGN(an,sigmab2)
%canalAWGN Summary of this function goes here
% Creation of the noise with a real and an imaginary part
g0 = 1;
N = size(an,2);
bn = sqrt(sigmab2).*randn(N,1) + j*sqrt(sigmab2).*randn(N,1);
rn = g0 * an + bn';
end

