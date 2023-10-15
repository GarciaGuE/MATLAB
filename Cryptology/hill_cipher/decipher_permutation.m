%Decrypt a ciphertext using a permutation matrix (Hill Cipher).
function text=decipher_permutation(p, code)
    A=matrix_per(p);
    A=inv(A);
    text=hill_cipher(A, code);
end