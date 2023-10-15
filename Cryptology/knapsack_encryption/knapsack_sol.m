%Function that checks if a given knapsack meets a specific objective.
%Outputs:
%   v=0 if obj is not achievable in s
%   v=vector if obj is achievable in s
%   valide has the same output as in the knapsack function
function [v, valide]=knapsack_sol(s,obj)
    valide=knapsack(s);

    %Error in case it's not a knapsack
    if valide==-1
        error('First input must be a knapsack')
    end

    %Error in case obj is not a natural number
    if ischar(obj) || gt(0,obj) || mod(obj,1)~=0
        error('Second input must be a natural')
    end

    i=length(s);
    d=zeros(1,i);

    %Loop that finds the unique solution for obj
    while i>0
        if obj>=s(i)
            d(i)=1;
        end
        obj=obj-d(i)*s(i);
        i=i-1;
    end

    %Solution found
    if obj==0
        v=d;
    %No solution exists
    else
        v=0;
    end
end