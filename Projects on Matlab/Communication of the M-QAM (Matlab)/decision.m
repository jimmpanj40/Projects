function [an2] = decision(rn,mComplex)
%decision Summary of this function goes here
%For each symbol of rn's sequence we find the nearest symbol of the 16-QAM

closest = 0;
for k = 1 : size(rn,2)
    min = 5 + j*5;
    for i = 1 : size(mComplex,1)
        for h = 1 : size(mComplex,2)
            if min > abs(rn(1,k)-mComplex(i,h))
                min = abs(rn(1,k)-mComplex(i,h));
                closest = mComplex(i,h);
            end
        end
    end
    an2(1,k) = closest;
end

end

