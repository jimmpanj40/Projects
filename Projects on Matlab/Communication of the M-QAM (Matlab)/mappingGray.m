function [mapGray] = mappingGray(M,seqBin,mGray,mComplex)
%mappingGray Summary of this function goes here
%Allow to create the sequence an
%We separate the binary sequence in group of 4 bits
%Then we convert them in decimal
%We find the position of these decimal in the Graymap and finally convert
%to the corresponding complex in the complex map of the 16-QAM

tmpVector = [];
mapGray = [];

for i = 1 : log2(M) : size(seqBin,2)
    tmpGroup = zeros(1,4);
    tmpString = "";
    % Creating Groups
    for k = i : i+3
        tmpGroup(1,k) = seqBin(1,k);
        % Casting to string
        tmpString = strcat(tmpString,string(tmpGroup(1,k)));
    end
    % Casting to decimal
    tmpBin = bin2dec(tmpString);
    
    % Looking the position 
    for l = 1 : log2(M)
        for c = 1 : log2(M)
            if tmpBin == mGray(l,c)
                tmpVector = [tmpVector mComplex(l,c)];
            end
        end
    end
end

mapGray = tmpVector;

end

