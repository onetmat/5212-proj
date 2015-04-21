%% Mathew Anderson SysEng 5212, Spring 2015
% Homework 5, problem #1

clear;
close all;
clc;

% Change the value of Cval_use to set the appropriate value for C.
Cval = [500, 100, 2500];
Cval_use = 2;

% Various parameters used for testing SVM generation.
num_train_samples = 500;
num_test_samples = 200;

[Ptrain, Ttrain] = msa_tight_fist_gen(num_train_samples);

Ptrain = Ptrain';
Ttrain = Ttrain';

% Generate the kernel matrix, one row at a time
kern_mat = zeros(num_train_samples, num_train_samples);
for i = 1:num_train_samples
    kern_mat(i, :) = msa_svm_kernel_row(Ptrain(i,:), Ptrain);
end

% setup the call to quadprog

Aeq = Ttrain';
beq = 0;
f = -1 * ones(1, num_train_samples);
lb = zeros(1,num_train_samples);
ub = Cval(Cval_use) * ones(1, num_train_samples);
x0=0;

kern_mat_part = kern_mat .* (Ttrain * Ttrain');

[x] = quadprog(kern_mat_part, f, [], [], Aeq, beq, lb, ub);
% Now find the actual SVs
% use 1e-4 for approx of zero
svs = find(x > 1e-7);
svVals = Ptrain(svs, :);

% plot the training data and the Support Vectors
figure;
title ('Train Val plot (with SVs)');
gscatter(Ptrain(:, 1), Ptrain(:, 2), Ttrain);
hold on;
plot(svVals(:,1), svVals(:,2),'ko','MarkerSize',10);
legend('Class 1 (actual)', 'Class 2 (actual)', 'Support Vector');

% Re-generate num_samples data to use as a testing set
[Ptest, Ttest] = msa_tight_fist_gen(num_test_samples);

Ptest = Ptest';
Ttest = Ttest';

class_error_total = 0;
labels = zeros(1,num_test_samples);
% Evaluate the test points to determine classification error
for i = 1:num_test_samples
    % Get SVM classification
    label = 0;
    for svi = 1:numel(svs)
        % classify according to this sv
        sv_inx = svs(svi);
        sv_contrib= x(sv_inx) * Ttrain(sv_inx) * msa_svm_kernel(Ptest(i,:), Ptrain(sv_inx,:));
        label = label + sv_contrib;
    end
    % My SVM implementation suffers from a lot of soft margin error
    if label > 0
        label = 1;
    else
        label = -1;
    end
    labels(i) = label;
    % Compare to known output
    if Ttest(i) ~= label
        class_error_total = class_error_total + 1;
    end
end

figure;
title ('Test Val plot (with SVs)');
gscatter(Ptest(:, 1), Ptest(:, 2), labels');
hold on;
plot(svVals(:,1), svVals(:,2),'ko','MarkerSize',10);
legend('Class 1 (SVM)', 'Class 2 (SVM)', 'Support Vector');

miss_class_pct = class_error_total / num_test_samples;
fprintf('Classification error of SVM with C = %d, %.3f%% pct\n', Cval(Cval_use), miss_class_pct * 100);