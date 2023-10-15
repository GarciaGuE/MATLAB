%Hill cipher of a text from a matrix A, checking that it is
%square. A reshape of the vector of numbers belonging to the
%text, being divisible by the order of the given matrix and the
% multiplication between matrices to give rise to the ciphertext.
function code=hill_cipher(A,text)
    if size(A,1)~=size(A,2)
        fprintf('Error using hill cipher(line ...)\n The matrix must be square.\n')
        code="";
    else
        abc='abcdefghijklmnñopqrstuvwxyz';
        labc=length(abc);
        orden=size(A,1);
        txt=letter_number(text);
        long=length(txt);
        if mod(long, orden)~=0
            while mod(long, orden)~=0
                txt(end+1)=23;
                long=length(txt);
            end
        end
        B=reshape(txt, orden, []);
        C=[];
        for i=1:size(B,2)
            X=B(:, i);
            C=[C A*X];
        end
        C=mod(C,27);
        C=reshape(C, 1, []);
        code=[];
        for i=1:long
            for j=1:labc
                if C(i)==0
                    code=[code abc(1)];
                    break;
                end
                if C(i)==j
                    code=[code abc(j+1)]; 
                end
            end
        end
    end
end