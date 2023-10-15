%Function that encrypts a message using a knapsack.
%Output:
%   code = vector of encrypted text numbers
function code=knapsack_cipher(s,text)
    %Check if it's a knapsack
    if knapsack(s)==-1
        error("The first input does not represent a knapsack.");
    end
    
    %Check if it's text
    if ischar(text)==false
        error("The second input must be char 'text'.");
    end
    
    %Convert the elements of the vector to binary and create a string
    lt=length(text);
    bin='';
    for i=1:lt
        character=dec2bin(text(i),8);
        bin=strcat(bin, character);
    end

    %Add ones if necessary
    lb=length(bin);
    ls=length(s);
    while mod(lb,ls)~=0
        bin=strcat(bin,'1');
        lb=length(bin);
    end
    
    %Regroup into blocks depending on the key length
    bin=reshape(bin, ls, []);
    bin=transpose(bin);
    
    %Transform the blocks as sums of elements from the key
    code=[];
    sz=size(bin);
    for i=1:sz(1)
        add=0;
        for j=1:sz(2)
            if (bin(i,j)=='1')
                add=add+s(j);
            end
        end
        code=[code add];
    end
end