%Function that applies the fast or binary exponentiation method to calculate modular powers
%Output:
%   pow=fast exponentiation result
function pow=power_mod(b, e, m)
    %Check if inputs are natural
    v=[b e m];
    %Excepcion exponente==0
    if e==0
        pow=1;
        return;
    end
    
    vn=v(0>=v | mod(v,1)~=0);
    if ~isempty(vn) | ischar(v)
       error('Inputs are not natural');
    end

    %Change to uint64
    b=uint64(b);
    e=uint64(e);
    m=uint64(m);
    
    %Transform exponent to binary
    binary=dec2bin(e);
    
    %Calculate the module of the base
    modbase=mod(b,m);

    %We go through the binary starting from the end
    lb=length(binary);
    pow=1;
    for i=lb:-1:1
        %If the bit is 1, we multiply the result by the module of the base
        if binary(i)=='1'
            pow=mod(pow*modbase,m);
        end
        
        %We increase for each position that is advanced by 1
        modbase=mod(modbase*modbase,m);
    end
end