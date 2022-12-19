function [mComplex] = const_M_QAM(M)
% Code for the M-QAM constellation
  mComplex=zeros(sqrt(M));
  for i=sqrt(M):-1:1
    for k=1:sqrt(M)
      mComplex(k,i)=(-sqrt(M)+1) + 2*(i-1)+j*(sqrt(M)-1-2*(k-1));
    end
  end
end