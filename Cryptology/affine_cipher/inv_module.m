%% Compute the modular inverse of a matrix A module m, subject to certain conditions.
function inver=inv_module(A, m)
    %Check if m is an integer.
    if mod(m,1)~=0
        error('Error using m (line ...)\n Is not a integer.')
    end
    
    %Check if all elements of A are integers.
    C=A(mod(A, 1)~=0);
    d=det(A);
    dr=round(d);
    [g, u, ~]=gcd(dr,m);
    if g~=1
        error('Error using inv module (line ...)\nThe matrix is invalid.')
    elseif  isempty(C)==0
        error('Error using inv module (line ...)\nAll the elements should be integer numbers.');
    else
        Ai=inv(A); 
        Aim=mod(u, m);
        A=(Aim*d)*Ai;
        for fil=1:size(A,1)
            for col=1:size(A,2)
                A(fil, col)=mod(A(fil,col),m);
            end
        end
        inver=round(A);
    end
end