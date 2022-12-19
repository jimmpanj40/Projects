function [binErrorRateTh,symbErrorRateTh] = synthesisQAM(N,M,g0) 
%this function gives us the binary and symbol error rate from N, M and g0
%of our channel

    mComplex = const_M_QAM(M);
    mGray = Gray_M_QAM(M);
    binSeq = genBin(N);
    an = mappingGray(M,binSeq,mGray,mComplex);
    binErrorRateExp = zeros(1,13);
    symbErrorRateExp = zeros(1,13);

    maxDB = 15;
    normalisedNoiseDB = 0 : maxDB;
    normalisedNoise = 10.^(normalisedNoiseDB/10);

    % Variance calculation
    sigma2 = (g0^2*(M - 1))./(3*log2(M)*normalisedNoise);

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
    binErrorRateTh=4*((sqrt(M)-1)/(sqrt(M)*log2(M)))*0.5*erfc(sqrt(normalisedNoise*(3*log2(M))/(M-1))/sqrt(2));
    symbErrorRateTh=binErrorRateTh*log2(M);
end 
