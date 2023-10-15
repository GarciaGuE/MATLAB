%Function that associates each letter with its corresponding Z27 value using two digits for each letter.
%Output: numeric string associated with the input text.
function double=letter_2numbers(text)

    %Error control
    double='';
    
    %Loop to transform each character to a number
    for i=1:length(text)
        num=num2str(letter_number(text(i)));
        
        %The first 9 characters have a leading zero
        if length(num)==1
            num=strcat('0', num);
        end
        double=strcat(double,num);
    end
end