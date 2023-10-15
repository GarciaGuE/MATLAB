%Function that checks if a knapsack is simple or superincreasing.
%Outputs:
%   valide=-1 if it's not a knapsack
%   valide=0 if it's a knapsack but not superincreasing
%   valide= 1 if it's a superincreasing knapsack
function valide=knapsack(s)
    %Vector to collect non-admissible values
    nm=s(mod(s,1)~=0 | s<=0);

    %Error in case the input is not a vector or not a number
    if isvector(s)==false || ischar(s)
        error('Input must be a vector of numbers')
    end
    if ~isempty(nm)
        valide=-1;
        return;
    end

    %Check if it's superincreasing
    valide=1;
    long=length(s);
    for i=1:long
        add=0;
        if i~=1
            for j=1:i-1
                add=add+s(j);
            end
        end
        if add>=s(i)
            valide=0;
            break;
        end
    end 
end