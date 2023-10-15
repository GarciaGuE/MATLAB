% Function that decrypts a numeric vector using the RSA system with the provided private key,
% and returns a numeric vector (the step before converting the digits to characters).
% Output: the numeric vector obtained after applying RSA decryption.
function v=rsa_num_decipher(n, d, code)
    
    %Error control
    v=[n d code];
    vn=v(0>=v | mod(v,1)~=0);
    if ~isempty(vn) || ischar(v)
        error('Inputs must be naturals');
    end

    %Decryption using fast exponentiation (modular exponentiation)
    v=[];
    for i=1:length(code)
       v=[v power_mod(code(i), d, n)]; 
    end
end