%Function that converts a numeric string into blocks of a given capacity,
%converts these blocks into numbers and stores them in a vector.
%Output: a vector of numeric blocks from the input string with length d.
function v=prepare_num_cipher(d, double)
    %Error control
    if d<=0 || mod(d,1)~=0 || ischar(d)
        error('First input must be natural');
    end
    
    str=double;
    ld=length(double);

    %If the module is not 0, it means that padding is required
    if mod(ld,d)~=0 
        diff=d-mod(ld,d);
        while diff~=0
            %Add 30 if the difference is greater than 1
            if diff>=2
                str=strcat(str,'30');
                diff=diff-2;
            %Add 0
            else
                str=strcat(str,'0');
                diff=diff-1;
            end
        end
    end

    %Split into blocks
    r=reshape(str,d,[])';
    v=[];

    %Each row corresponds to a block
    for i=1:size(r,1)
        v=[v str2double(r(i,:))];
    end
end