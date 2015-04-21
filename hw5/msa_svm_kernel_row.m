%% Mathew Anderson SysEng 5212, Spring 2015
% Homework 5, problem #1

function [kernel_row] = msa_svm_kernel_row(x, vectors)
    [numVecs, ~] = size(vectors);
    
    kernel_row = zeros(1, numVecs);
    for i = 1:numVecs
        ret = msa_svm_kernel(x, vectors(i, :));
        kernel_row(i) = ret;
    end
end