%Function that transforms a numeric vector into letters (using two digits
%per letter). It completes the blocks with leading zeros to have a length of (n) - 1 digits,
%concatenates them, groups them in pairs, removes possible '30's and/or '0's at the end and converts them into letters.
%Output: a text string.
function text=num_decipher(n,blocks)

    %Error control
    v=[n blocks];
    vn=v(0>=v | mod(v,1)~=0);
    if ~isempty(vn) || ischar(v)
        error('Inputs must be naturals');
    end
    
    %Block length
    size=length(num2str(n))-1;
    
    %Complete incomplete blocks with leading zeros
    block=[];
    for i=1:length(blocks)
        aux=num2str(blocks(i));
        if length(aux)<size
            while length(aux)~=size
               aux=strcat('0', aux);
             end
        end
        block=[block aux];
    end
    
    %Reshape and transformation into numbers
    while mod(length(block),2)~=0
        block=[block '0'];
    end
    block=reshape(block, 2, [])';
    num=[];
    for i=1:length(block)
       num=[num str2num(block(i,:))];
    end

    %Remove 30s
    numabc=[];
    for i=1:length(num)
       if num(i)~=30
           numabc=[numabc num(i)];
       end
    end

    %Transformation into characters
    text=num2letter(numabc);
end