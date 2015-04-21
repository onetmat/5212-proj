% Direct copy of impl from HW3
function y =bp2val(P, W1, W2, beta)
[~,Q] = size(P);
[m,~] = size(W2);
y=zeros(m,Q);
for i = 1:Q
    v1 = W1*[P(:,i)' 1]';
    xout1 = tanh(beta*v1);
    v2 = W2*[xout1' 1]';
    xout2 = purelin(v2);
    y(:, i) = xout2;
end