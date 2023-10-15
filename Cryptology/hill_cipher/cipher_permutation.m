%Encrypt a text using a permutation matrix (Hill Cipher).
function code=cipher_permutation(p, text)
    A=matrix_per(p);
    code=hill_cipher(A, text);
end
