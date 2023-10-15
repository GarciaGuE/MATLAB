%Function that allows decrypting an encrypted message with its public key.
%Output:
%   text = decrypted text
function text=decipher_kmh(s,code,mu,invw)
    %Calculate the module of the multiplication between the elements
    % of code and inw
    code=mod((code*invw),mu);

    %Apply the same decryption as the decipher_knapsack_s function
    text=decipher_knapsack_s(s,code);
end