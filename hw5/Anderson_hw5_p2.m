%% Mathew Anderson SysEng 5212, Spring 2015
% Homework 5, problem #2

clear;
clc;
close all;

% Call PCA to determine the latent values of the input images.
load('tiger.mat');
load('fruits.mat');

[~,~,tigerLatents] = pca(tiger);
[~,~,fruitLatents] = pca(fruits);

% determine position of 95% retention
tigercumsumd = cumsum(tigerLatents)./sum(tigerLatents);
fruitcumsumd = cumsum(fruitLatents)./sum(fruitLatents);

ndims = find(tigercumsumd > 0.95);
tigerndim_95 = ndims(1);
ndims = find(fruitcumsumd > 0.95);
fruitndim_95 = ndims(1);

% determine position of 99% retention

ndims = find(tigercumsumd > 0.99);
tigerndim_99 = ndims(1);
ndims = find(fruitcumsumd > 0.99);
fruitndim_99 = ndims(1);

% Use pcares to reconstruct the images with a certain number % retention based on
% analysis of latent values.
[~, fruit99] = pcares(fruits, fruitndim_99);
[~, fruit95] = pcares(fruits, fruitndim_95);

[~, tiger99] = pcares(tiger, tigerndim_99);
[~, tiger95] = pcares(tiger, tigerndim_95);

% Call the image compression routines (modified) from HW4.
msa_hw5_hw4(tiger95);
msa_hw5_hw4(tiger99);

% Uncomment the following to see original image
%image(tiger);

msa_hw5_hw4(fruit95);
msa_hw5_hw4(fruit99);

% Uncomment the following to see the original
%image(fruits);