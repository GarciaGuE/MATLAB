%Function that decrypts a cryptogram given a superincreasing knapsack.
%Output:
%   text=decrypted code
function text=decipher_knapsack_s(s,code)
    %Check if it's a superincreasing knapsack
    if knapsack(s)~=1
        error("The first input does not represent a simple knapsack.");
    end

    %Vector to collect non-admissible values
    nm=code(mod(code,1)~=0 | code<0);

    %Error if non-admissible values or if it's not a vector
    if ~isempty(nm) || isvector(code)==false || ischar(code)
         error("The second input must be a vector of naturals.");
    end

    % Find the binary representation of each element in the vector and
    % group them into blocks as large as the length of the key,
    % and find the elements of the knapsack that satisfy them
    lc=length(code);
    binary=[];
    for i=1:lc
        [v]=knapsack_sol(s,code(i));
        binary=[binary v];
    end

    %Group into blocks of 8 for the binary text
    lb=length(binary);
    if mod(lb,8)~=0
        binary=binary(1:lb-mod(lb,8));
    end
    binary=reshape(binary,8,[]);
    sz=size(binary);

    %Take each column and transform it to decimal
    decimal='';
    v=[];
    for i=1:sz(2)
        v=binary(:, i);
        v=reshape(v,1,[]);
        decimal=strcat(decimal, bin2dec(num2str(v)));
    end
    
    %Convert to characters
    text=char(decimal);
end