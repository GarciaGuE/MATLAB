%Affine Cipher where it checks that the passed values are integers 
%and performs a double loop for the transformation.
function code=affine(k, d, text)
    if mod(k,1)~=0 || mod(d,1)~=0 
       fprintf('Error using affine (line ...)\nThe values of k and d must be integers')
       code=[];
    elseif gcd(k,27)~=1
        fprintf('Error using affine (line ...)\nThe multiplicative key should satisfy gcd(k,27)=1')
        code=[];
    else
       abc='abcdefghijklmnñopqrstuvwxyz';
       labc=length(abc);
       num=letter_number(text);
       lnum=length(num);
       code=[];
       for i=1:lnum
            letter=num(i);
            cambio(i)=mod((letter*k)+d, 27);
            for j=1:labc
                if cambio(i)==j
                    code=[code abc(j+1)];
                elseif cambio(i)==0
                   code=[code abc(1)];
                   break;
                end
            end
       end
    end
end