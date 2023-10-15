%Function that generates a pair of public and private keys suitable for a superincreasing knapsack.
%Outputs:
%   publ_k=trap knapsack created from s, mu, and w
%   priv_k=vector with mu and the modular multiplicative inverse of w
function [publ_k, priv_k]=knapsack_mh(s)
    %Check if it's a superincreasing knapsack
    if knapsack(s)~=1
        error("The first input does not represent a simple knapsack.");
    end

    %Input the value of mu
    total=2*(s(end));
    fprintf('\nIntroduce the value mu, a natural number greater than %d:', total);
    mu=input('\n');

    %Check that it is valid
    if mu<total || mod(mu,1)~=0
        error("The value mu must be a integer greater than %d and natural", total);
    end

    %Search for a coprime value w
    w=mu;
    [factor_c, ~]=common_factors(w,s);
    [g, u, v]=gcd(w, mu);
    while g~=1 || factor_c==1 && w>2
        w=w-1;
        [g, u, v]=gcd(w, mu);
        [factor_c, ~]=common_factors(w,s);
    end
    
    %Calculate the modular multiplicative inverse
    wi=mod(u,mu);
    
    %Vector with the values of mu and wi
    priv_k=[mu wi];
    
    %Create the trap knapsack
    s=mod((s*w),mu);
    publ_k=s;
end