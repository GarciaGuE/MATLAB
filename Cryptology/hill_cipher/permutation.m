%Logical function that returns 1 if the permutation vector is correct, 0 otherwise.
function permute=permutation(p)
    permute=1;
    long=length(p);
    for i=1:long
        if p(i)>long || mod(p(i),1)~=0
            permute=0;
            break;
        end
        for j=i+1:long
            if p(i)==p(j)
               permute=0; 
            end
        end
    end
end