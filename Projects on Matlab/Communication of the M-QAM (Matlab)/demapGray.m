function [seqBits2] = demapGray(an2,mGray,mComplex)
%demapGray Summary of this function goes here
%We convert ân in a binary sequence

tmp = [];
for k = 1 : size(an2,2)
    for l = 1 : size(mGray,1)
        for c = 1 : size(mGray,2)
            if an2(1,k) == mComplex(l,c)
                tmp = [tmp dec2bin(mGray(l,c),4)];
            end
        end
    end
end
seqBits2 = tmp;

end

