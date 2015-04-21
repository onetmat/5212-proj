%% Mathew Anderson SysEng 5212, Spring 2015
% Homework 5, problem #1
% Input data generator

function [Ptrain, Ttrain] = msa_tight_fist_gen(count)
    radii = [0.2 0.5 0.8];
    Ptrain = zeros(2, count);
    Ptrain(1, :) = rand(size(Ptrain(1, :))) .* radii(3);
    Ptrain(2, :) = 2*pi*rand(size(Ptrain(2, :)));
    Ttrain = zeros(1, count);
    for i = 1:count
        % Find all cases where the output class
        % should be 1 vs -1
        % Determine if we are above x-axis
        upperQuad = Ptrain(2, i) <= pi;
    
        % If we are, then we are in class one
        % only if r is <= 0.2 or > 0.5
        smallRad = Ptrain(1, i) <= radii(1);
        largeRad = Ptrain(1, i) > radii(2);
        if upperQuad == 1
            if smallRad || largeRad
                Ttrain(i) = 1;
            else
                Ttrain(i) = -1;
            end
        else
            if smallRad == 0 && largeRad == 0
                Ttrain(i) = 1;
            else
                Ttrain(i) = -1;
            end
        end
        
        % now, convert back to x,y coordinates
        r = Ptrain(1, i);
        theta = Ptrain(2,i);
        Ptrain(1, i ) = r*cos(theta);
        Ptrain(2, i) = r*sin(theta);
    end
end