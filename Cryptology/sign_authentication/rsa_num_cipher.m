%Function that performs the same procedure as rsa_cipher, except it starts with numeric blocks
%instead of a text input.
%Output: encrypted blocks
function v=rsa_num_cipher(n, e, blocks)
    %Error control
    v=[n e blocks];
    vn=v(0>=v | mod(v,1)~=0);
    if ~isempty(vn) || ischar(v)
        error('Inputs must be naturals');
    end

    %Encryption using fast exponentiation (modular exponentiation)
    v=[];
    for i=1:length(blocks)
        num=power_mod(blocks(i), e, n);
        v=[v num];
    end
end