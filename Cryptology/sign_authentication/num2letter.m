%Function to convert numbers to letters of the alphabet.
function text=num2letter(num)
    %Transform the alphabet into numbers
    alphabet='abcdefghijklmnñopqrstuvwxyz';

    %Choose from double values
    alphabet(15)=char(241);
    text=[];
    ln=length(num);
    for i=1:ln
       pos=num(i)+1;
       text=[text alphabet(pos)];
    end
end