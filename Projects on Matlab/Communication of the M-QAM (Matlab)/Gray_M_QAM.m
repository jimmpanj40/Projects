function [mGray] = Gray_M_QAM(M)
% Gray code of the M-QAM
    mGray = zeros(sqrt(M));
    i = 0;
    for x = 1 : sqrt(M);
      for y = sqrt(M) : -1 : 1
        mGray(x,y) = i;
        i = i + 1;
      end
    end
    mGray = bin2gray(mGray,'qam',M);
end