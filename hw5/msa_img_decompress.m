% Mathew Anderson SysEng 5212, Spring 2015
% Decompression routine

% [encodedImg, compressionParams] = output of msa_img_compress
function [pattern] = msa_img_decompress(encodedImg, compressParams)
    
    % Run the encoded signal through the output layer
    % of the NN.
    nn = compressParams.nn;
    W2 = nn.outWeights;
    [~,Q] = size(encodedImg);
    [m,~] = size(W2);
    y=zeros(m,Q);
    for i = 1:Q
        v2 = W2*[encodedImg(:,i)' 1]';
        xout2 = purelin(v2);
        y(:, i) = xout2;
    end
    
    % Undo normalization of input
    y = mapminmax('reverse', y, compressParams.normParams);
    
    % Reconstruct image data from the output
    dims = compressParams.dims;
    sampleIndex = 1;
    for i = 1:8:dims(1)
        for j = 1:8:dims(2)
            pattern(i:i+7, j:j+7) = reshape(y(:, sampleIndex), 8, 8);
            sampleIndex = sampleIndex + 1;
        end
    end