% Ptrain - Training data (nxQ) - n is actual data, Q is number of samples
% Ttrain - Training output (mxQ)
% Ptest - Testing data (for error verification)
% Ttest - Testing data output
% M - number of hidden neurons
% Tp(1) - momentum factor
% Tp(2) - max iters
% Tp(3) - slope of tanh activation function
% Tp(4) - cutoff value for growth of MSE
% TP(5) - 1 to use Nguyen-Widrow weight initialization, 0 for random
% Tp(6) - 1 to generate MSE plot
% W1 - opt input weight vector (must be length M)
% W2 - opt output weight vector (must be at least length M)


% Direct copy of impl from HW3
function [W1, W2, E] = bp2(Ptrain, Ttrain, Ptest, Ttest, M,Tp,W1,W2)
[n,~]=size(Ptrain);
[m,Q]=size(Ttrain);
q=length(Ttest);

alpha = Tp(1);
MaxIter = Tp(2);
beta = Tp(3);
Incr = Tp(4);
NgyWid = Tp(5);

E=[];
MSEold=realmax;
MSEnew = realmax;
iter = 0;

if nargin < 8
    if NgyWid == 0
        W1 = 0.1*randn(M,n+1);
        W2 = 0.1*randn(m, M+1);
    else
        % Nguyen-Widrow init
        gamma1 = 0.7*M^(1/n);
        gamma2 = 0.7*m^(1/M);
        W1 = -0.5+rand(M,n);
        W2 = -0.5+rand(m,M);
        b1 = zeros(M,1);
        b2 = zeros(m,1);
        for i = 1:M
            W1(i,:) = gamma1*W1(i,:)/norm(W1(i,:));
            b1(i) = (max(W1(i,:))-min(W1(i,:)))*rand(1,1)-mean(W1(i,:));
        end
        W1 = [W1 b1];
        
        for i = 1:m
            W2(i, :) = gamma2*W2(i,:)/norm(W2(i,:));
            b2(i) = (max(W2(i,:))-min(W2(i,:)))*rand(1,1)-mean(W2(i,:));
        end
        
        W2 = [W2 b2];
    end
end
% Network training phase
MSE = zeros(MaxIter, 1);
while iter < MaxIter && MSEnew <= (MSEold+Incr)
    %fprintf('Iteration number: %d\n', iter);
    iter = iter + 1;
    for i = 1:Q
        v1 = W1*[Ptrain(:,i)' 1]';
        xout1 = tanh(beta*v1);
        g1 = beta*(1-xout1.^2);
        v2 = W2*[xout1' 1]';
        xout2=purelin(v2);
        g2=1;
        e=Ttrain(:,i)-xout2;
        MSE(iter)=MSE(iter)+e'*e/Q;
        D2 = diag(g2)*e;
        D1 = diag(g1)*W2(1:m, 1:M)'*D2;
        W2 = W2+alpha*D2*[xout1' 1];
        W1 = W1+alpha*D1*[Ptrain(:,i)' 1];
    end
    % Calculate error for testing data set
    MSEold = MSEnew;
    MSEnew = norm(Ttest-bp2val(Ptest, W1, W2, beta))^2/q;
    E = [E;MSEnew];
end
if Tp(6) == 1
    figure;
    loglog(MSE,'r');
    hold on;
    loglog(E,'b');
    grid;
    xlabel('Training epoch');
    ylabel('MSE');
    legend('Training MSE', 'Test MSE');
    hold off;
end