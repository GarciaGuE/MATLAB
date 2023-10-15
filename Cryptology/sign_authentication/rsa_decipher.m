%Function that decrypts a numeric vector using the RSA system with the provided private key,
%returning the plain text.
% Output: the plain text.
function text=rsa_decipher(n, d, code)
    %Error control
    v=[n d code];
    vn=v(0>=v | mod(v,1)~=0);
    if ~isempty(vn) || ischar(v)
        error('Inputs must be naturals');
    end

    %Decrypting with RSA to obtain numeric values
    descnum=rsa_num_decipher(n, d, code);
    
    %Numeric decryption
    text=num_decipher(n, descnum);
end