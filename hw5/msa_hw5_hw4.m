% Mathew Anderson SysEng 5212, Spring 2015
% Homework 5, problem #2

% Essentially, this is Anderson_hw4_p2.m converted to a function

function [] = msa_hw5_hw4(inImage)
    dims = size(inImage);

    % break out the image into samples
    sampleIndex = 1;
    imageSamples = zeros(64,dims(1)*dims(2) / 64);
    for i=1:8:dims(1)
        for j = 1:8:dims(2)
            imageSamples(:, sampleIndex) = reshape(inImage(i:i+7, j:j+7), 64, 1);
            sampleIndex = sampleIndex + 1;
        end
    end

    % Normalize data
    [imageSamples, imageNormParams] = mapminmax(imageSamples, -0.8, 0.8);

    % Clean up the workspace to make everything easier to read.
    clear i;
    clear j;
    clear sampleIndex;

    % Setup the network parameters for both networks.
    Tp(1) = 0.01; % momentum
    Tp(2) = 200; % max iters
    Tp(3) = 1; % slope of tanh activation function
    Tp(4) = 0.1; %cutoff value for growth of MSE
    Tp(5) = 1; % use Nguyen-Widrow weight init
    Tp(6) = 0;

    % Randomize inputs to network for training
    shuffIndex = randperm(length(imageSamples));
    imageShuffled = imageSamples(:, shuffIndex);

    % Train all networks using the test params in Tp and a variable number of hidden neurons
    % the number in front of the weights indicate the number of hidden neurons.

    hiddenNeuronCount = [6, 8];%, 10];% 16, 32]; % Note that you can increase/decrease this array as desired

    for i=1:length(hiddenNeuronCount)
        [hWeights, oWeights, ~] = bp2(imageShuffled, imageShuffled, imageSamples, imageSamples, hiddenNeuronCount(i), Tp);
        allNNs{i}.weights = hWeights;
        allNNs{i}.beta = 1;
        allNNs{i}.outWeights = oWeights;
    end

    % Run the image through all NNs and make an image
    for i = 1:length(hiddenNeuronCount)
        [encodedImage, imageComp] = msa_img_compress(inImage, allNNs{i});
        decodedImage = msa_img_decompress(encodedImage, imageComp);
        figure;
        image(decodedImage);
        fprintf('Size of image compressed with %d neurons: %d\n', hiddenNeuronCount(i), numel(encodedImage));
    end

    % Plot control image
    figure;
    image(inImage);
end