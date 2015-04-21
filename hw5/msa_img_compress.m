% Mathew Anderson SysEng 5212, Spring 2015
% Compression routine

% Pattern - input to be compressed, dims must be divisible by 8
% nn - Neural Network information
% nn.weights - Hidden Layer Weights
% nn.beta - Slope of tanh activation function
% nn.outWeights - Weights of output layer
% Method returns
% output - Compressed output pattern
% compressParams - Parameters necessary to uncompress pattern later
function [output, compressParams] = msa_img_compress(pattern, nn)
    compressParams.nn = nn;
    
    dims = size(pattern);
    compressParams.dims = dims;
    % break out image into samples
    sampleIndex = 1;
    imageSamples = zeros(64,dims(1)*dims(2) / 64);
    for i=1:8:dims(1)
        for j = 1:8:dims(2)
            imageSamples(:, sampleIndex) = reshape(pattern(i:i+7, j:j+7), 64, 1);
            sampleIndex = sampleIndex + 1;
        end
    end
    % Normalize the input
    [imageSamples, normParams] = mapminmax(imageSamples, -0.8, 0.8);
    compressParams.normParams = normParams;
    
    % Evaluate NN with weights located in nn{1} and beta val to get
    % encoded signal, representing output
    beta = nn.beta;
    W1 = nn.weights;
    [m,~] = size(nn.weights);
    [~,Q] = size(imageSamples);
    output=zeros(m,Q);
    for i=1:Q
        v1 = W1*[imageSamples(:,i)' 1]';
        xout1 = tanh(beta*v1);
        output(:, i) = xout1;
    end