% Function that encrypts the input text using the RSA system with the public key (n, e).
% Output: encrypted blocks
function v=rsa_cipher(n, e, text)

    %Error control
    v=[n e];
    vn=v(0>=v | mod(v,1)~=0);
    if ~isempty(vn) || ischar(v)
        error('Inputs must be naturals');
    end
    
    %Convert text into numbers
    num=letter_2numbers(text);
    
    %Determine the block length
    d=length(num2str(n));
    
    %Group numbers into blocks of length (n-1)
    vector=prepare_num_cipher(d-1, num);

    %Encryption using fast exponentiation (modular exponentiation)
    v=[];
    for i=1:length(vector)
        num=power_mod(vector(i), e, n);
        v=[v num];
    end
end