%Function that calculates the minimum value of the exponent of the power of A 
%module m is equal to the identity matrix.
%Output: value of the exponent of the power of A
function n=power_a(A,m)
    %Error control
    [fil, col]=size(A);
    if m<=0 || mod(m,1)~=0
        error('First input must be natural.');
    end

    An=A(mod(A,1)~=0);

    if ~isempty(An)
        error('Second input must be natural.');
    end

    if fil~=2 || col~=2
        error('Invalid matrix.');
    end
    
    %Calculate the power until it is equal to the identity
    matrixI=eye(2);
    n=1;
    aux=A;
    while ~isequal(aux, matrixI)
        aux=mod(aux*A, m);
        n=n+1;
    end
end