%Comparison of character frequencies in Spanish and the given text.
function compare=bars(v) 
    [freq, freq_order]=crypt_ana_order(v);
    col=[0.1368 4; 0.1253 0];
    col=[col; 0.0868 15];
    col=[col; 0.0798 19];
    col=[col; 0.0687 18];
    col=[col; 0.0671 13];
    col=[col; 0.0625 8];
    col=[col; 0.0586 3];
    col=[col; 0.0497 11];
    col=[col; 0.0468 2];
    col=[col; 0.0463 20];
    col=[col; 0.0393 21];
    col=[col; 0.0315 12];
    col=[col; 0.0251 16];
    col=[col; 0.0142 1];
    col=[col; 0.0101 6];
    col=[col; 0.009 22];
    col=[col; 0.009 25];
    col=[col; 0.0088 17];
    col=[col; 0.007 7];
    col=[col; 0.0069 5];
    col=[col; 0.0052 26];
    col=[col; 0.0044 9];
    col=[col; 0.0031 14];
    col=[col; 0.0022 24];
    col=[col; 0.0002 10];
    col=[col; 0.0001 23];
    compare=[col freq_order];
    column=col(:,1);
    column2=col(:,2);
    column3=freq_order(:,1);
    column4=freq_order(:,2);
    figure
    bar(column2, column, 'red');
    title('Spanish frequencies')
    figure
    bar(column4, column3);
    title('Code frequencies')
end