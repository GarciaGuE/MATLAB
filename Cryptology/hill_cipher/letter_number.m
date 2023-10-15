%Conversion of a text into a numeric array representing letter positions in the alphabet.
function  num=letter_number(text) 
    abc='abcdefghijklmnñopqrstuvwxyz'; 
    abct='ábcdéfghíjklmnñópqrstúvwxyz'; 
    word=lower(text); 
    num=[];
    ltxt=length(text); 
    labc=length(abc);
    for i=1:ltxt
       for j=1:labc
            if word(i)==abc(j) || word(i)==abct(j)
                num=[num j-1]; 
            end
       end
    end
end

