%Function that checks if a number w has common prime factors with the elements of a backpack s
%Outputs:
%   factor_c=0 if no common factors found
%   factor_c=1  if common factors found
%   fact=vector of common factors
function [factor_c, fact]=common_factors(w,s)
    %Check if w is a natural number
    if w<=0 || mod(w,1)~=0
        error('The first input must be a natural.')
    end
    
    valide=knapsack(s);

    %Check if s is a backpack
    if valide==-1
        error('The second input does not represent a knapsack.')
    end

    %Elements that have common factors will be stored in a vector
    fact=s(gcd(w, s)~=1);

    %If there are common factors we return 1, else we return 0
    if ~isempty(fact)
        factor_c=1;
    else
        factor_c=0;
        fact=[];
    end
end