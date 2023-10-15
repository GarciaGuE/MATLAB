%Decrypt text using the Affine cipher with checks to avoid decimals and ensure gcd(k, 27) is 1.
function text=dec_affine(k, d, code)
    if mod(k,1)~=0 || mod(d,1)~=0
        fprintf('Error using affine (line ...)\nThe values of k and d must be integers')
        text=[];
        return
    end
    g=gcd(k,27);
    if g~=1 
        fprintf('Error using affine (line ...)\nThe multiplicative key should satisfy gcd(k,27)=1')
        text=[];
    else
       abc='abcdefghijklmnñopqrstuvwxyz';
       labc=length(abc);
       num=letter_number(code);
       lnum=length(num);
       text=[];
       xchng=[];
       [g, u, v]=gcd(k,27);
       if u<0
            ki=u+27;
       else
           ki=u;
       end
       for i=1:lnum
           letra=num(i);
           xchng=[xchng (mod(ki*(letra-d), 27))];
           for j=1:labc
               if xchng(i)==j
                   text=[text abc(j+1)];
               elseif xchng(i)==0
                   text=[text abc(1)];
                   break;
               end
           end
       end
    end
end