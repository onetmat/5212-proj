%% Mathew Anderson SysEng 5212, Spring 2015
% Homework 5, problem #1

% Polynomial learning machine. Arbitrary value of p=3
function [outval] = msa_svm_kernel(x, xi)
    outval = (x*xi' + 1).^3;
end