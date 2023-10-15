%Cryptanalysis of letter frequencies for decryption,
%checking the GCD (Greatest Common Divisor) of k and if the values entered are decimals.
%The program prompts for options with 1 (Manual), 0 (Cryptanalysis) or any other key to exit.
function affine_cryptanalysis(v) 
    menu=1;
    [freq, freq_order]=crypt_ana_order(v);
    x=[7 20; 0 1];
    y=[freq_order(1,2) 0; freq_order(2,2) 0]; 
    sol=x*y;
    sol=mod(sol,27);
    k=sol(1,1);
    d=sol(2,1);
    g=gcd(k,27);
    if g==1
        text=dec_affine(k, d, v);
        disp(text)
    end
    count=0;
    it=0;
    while menu==1 || menu==0
        prompt="If you want to prove with different keys write 1, otherwise write 0: 1\n";
        menu=input(prompt);
        if menu==0
            if count==0
                y=[freq_order(2,2) 0; freq_order(1,2) 0];
                sol=x*y;
                sol=mod(sol,27);
                k=sol(1,1);
                d=sol(2,1);
                g=gcd(k,27);
                if g~=1
                    fprintf('Try again with 0, the key k does not have an inverse.\n')
                else
                    text=dec_affine(k, d, v);
                    disp(text)
                end
                it=it+1;
            elseif mod(count, 2)==0
                z=y(1,1);
                y(1,1)=y(1,2);
                y(1,2)=z;
                sol=x*y;
                sol=mod(sol,27);
                k=sol(1,1);
                d=sol(2,1);
                g=gcd(k,27);
                if g~=1
                    fprintf('Try again with 0, the key k does not have an inverse.\n')
                else
                    text=dec_affine(k, d, v);
                    disp(text)
                end
                it=it+1;
            elseif mod(it,3)==0 && count~=0
                s=y(1,1);
                y(1,1)=y(1,1)-2;
                sol=x*y;
                sol=mod(sol,27);
                k=sol(1,1);
                d=sol(2,1);
                g=gcd(k,27);
                if g~=1
                    fprintf('Try again with 0, the key k does not have an inverse.\n')
                else
                    text=dec_affine(k, d, v);
                    disp(text)
                end
                y(1,1)=s;
                it=it+1;
            else
                y(1,1)=y(1,1)+2;
                y(1,2)=y(1,2)+2;
                sol=x*y;
                sol=mod(sol,27);
                k=sol(1,1);
                d=sol(2,1);
                g=gcd(k,27);
                if g~=1
                    fprintf('Try again with 0, the key k does not have an inverse.\n')
                else
                    text=dec_affine(k, d, v);
                    disp(text)
                end
                it=it+1;
            end
            count=count+1;
        elseif menu==1
            prompt="k=";
            k=input(prompt);
            prompt="d=";
            d=input(prompt);
            if mod(k,3)==0 || mod(k,1)~=0 || mod(d,1)~=0
                fprintf('Try again with 1, the key k does not have an inverse or you entered decimals.\n')
            else
                text=dec_affine(k, d, v);
                disp(text)
            end
        end
    end
end