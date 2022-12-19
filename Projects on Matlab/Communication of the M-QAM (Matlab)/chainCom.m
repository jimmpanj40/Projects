function [bitsn2,an_hat] = chainCom(sigma2,N,M,bitsN,an)
    mComplex = const_M_QAM(M);
    mGray = Gray_M_QAM(M);
    rn = canalAWGN(an,sigma2);
    an_hat = decision(rn,mComplex);
    bitsn2 = demapGray(an_hat,mGray,mComplex);
    bitsn2 = double(bitsn2 == '1');
end

