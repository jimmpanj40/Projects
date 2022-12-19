clear all;
close all;
clc;
format short g;

%% Question 1 Constellation M-QAM

% Initialisation of the constellation size, its complex and gray code
% M is the size of the constellation
% mComplex : matrix containing complex symbols
% mGray : matrix containing Gray code
M = 16;
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);

%% Question 2 Communication chain

%-----------------------AWGN--------------------------

% Definition of varation and sequence's size
N = M*4;
sigmab2 = 0.5;

% Initialisation of binary sequence, calculation of an and rn
bitsN = genBin(N);
an = mappingGray(M,bitsN,mGray,mComplex);
rn = canalAWGN(an,sigmab2);

% Initialisation of the scale
x_rn = real(rn(:));
y_rn = imag(rn(:));

%--------------------------Receiver---------------------------

% Calculating ân
an2 = decision(rn,mComplex);

x_an2 = real(an2(:));
y_an2 = imag(an2(:));

x_an = real(an(:));
y_an = imag(an(:));

% demapping
bitsn2 = demapGray(an2,mGray,mComplex);
bitsn2 = double(bitsn2 == '1');

%% Question 3 Experimental binary and symbol error rates

g0 = 1;
M = 16;
N = 32768;

% Normalised SNR
maxDB = 15;
normalisedNoiseDB = 0 : maxDB;
normalisedNoise = 10.^(normalisedNoiseDB/10);

% Variance calculation
sigma2 = (g0^2*(M - 1))./(3*log2(M)*normalisedNoise);

binErrorRateExp = zeros(1,13);
symbErrorRateExp = zeros(1,13);

% Communication chain
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
binSeq = genBin(N);
an = mappingGray(M,binSeq,mGray,mComplex);

% Calculation of the error rate for each dB
for i = 1 : maxDB + 1
    binError = 0;
    symbError = 0;
    
    % Recalculating with new sigma2
    %rn = canalAWGN(an,sigma2(i));
    %anHat = decision(rn,mComplex);
    %demapBinSeq = demapGray(anHat,mGray,mComplex);
    %demapBinSeq = double(demapBinSeq == '1');
    
    [demapBinSeq,anHat] = chainCom(sigma2(i),N,M,binSeq,an);
    
    % Calculating bit and symbols error rate
    for j = 1 : length(an)
        if an(j) ~= anHat(j)
            symbError = symbError + 1;
        end
    end
    
    for k = 1 : length(binSeq)
        if binSeq(k) ~= demapBinSeq(k)
            binError = binError + 1;
        end
    end
    
    binErrorRateExp(i) = binError/length(binSeq);
    symbErrorRateExp(i) = symbError/length(an);
end

%% Question 4 Theoretical curve of error probability

% Calculating theoretical error probability
binErrorRateTh=4*((sqrt(M)-1)/(sqrt(M)*log2(M)))*0.5*erfc(sqrt(normalisedNoise*(3*log2(M))/(M-1))/sqrt(2));
symbErrorRateTh=binErrorRateTh*log2(M);

%% Question 5 Complementary exercices

%% Simulation of QPSK, 16-QAM,256-QAM

[QPSKbin,QPSKsymb] = synthesis(N,M,g0);
[QAM16bin,QAM16symb] = synthesisQAM(N,16,g0);
[QAM256bin,QAM256symb] = synthesisQAM(N,256,g0);




