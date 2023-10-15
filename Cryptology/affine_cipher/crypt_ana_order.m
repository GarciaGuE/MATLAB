%Analysis of letter frequencies in a text, stored in a matrix
%and ordered by frequency.
function [freq, freq_order]=crypt_ana_order(v)
    long=length(v);
    num=letter_number(v);
    abc='abcdefghijklmnñopqrstuvwxyz';
    numabc=letter_number(abc);
    labc=length(abc);
    freq=zeros(27, 2); 
    for i=1:labc
        count=0;
        for j=1:long
            if num(j)==numabc(i)
                count=count+1;
            end
        end
        freq(i, 1)=count/long;
        freq(i, 2)=round(numabc(i));
    end
    freq_order=sortrows(freq, 1, 'descend');
    disp(freq_order)
end