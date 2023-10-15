%Function that performs the cryptanalysis of Shamir and Zippel
%Indicates the range in which is searching for the possible first element
%of the super growing knapsack. 
%Output:
%   s=associated supergrowing knapsack
%·It will be asked on the screen whether to continue or not
%·The execution time will be displayed
%·Even if one of the first two elements of the knapsack does not have an inverse module
%mu the function will continue.
function s=crypt_shamir_zippel(publ_l, mu)
    %Check if it is a knapsack
    if knapsack(publ_l)==-1
        error("The first input does not represent a knapsack.");
    end

    %Error if mu is not a integer
    if ischar(mu) || gt(0,mu) || mod(mu,1)~=0
        error('Second input must be a natural')
    end

    %Calculate the inverse b2 (No matter g)
    [~, u, ~]=gcd(publ_l(2), mu);
    inv=mod(u,mu);

    %Calculate q as a product of b1 and b2 inverse, applying module m
    q=mod(publ_l(1)*inv,mu);

    %Loop that searches for the supergrowing knapsack
    lb=length(publ_l);
    stop=0;
    increment=0;
    while stop==0
        %Chronometer start
        tic

        %Stablish the range
        rank2=2.^((lb+1)+increment);
        if increment>0
            rank1=(2.^((lb+1)+increment-1))+1;
        else
            rank1=1;
        end
        fprintf('Searching multiples in the rank [%d, %d]\n', rank1, rank2);
        vrank=[];
        for i=rank1:rank2
            vrank=[vrank, mod(i*q, mu)];
        end
        %Sort for the first element
        vrank=sort(vrank);
        for i=1:length(vrank)
           %Select candidate
           a=vrank(i);

           %Calculate the inverse of a
           [g, u, ~]=gcd(a, mu);
           ai=mod(u,mu);

           %Calculate w and its inverse
           w=mod(publ_l(1)*ai, mu);
           [g, u, ~]=gcd(w, mu);

           %Calculate the rest of the elements of the supergrowing knapsack
           wi=mod(u, mu);
           s=mod(publ_l*wi, mu);

           %A knapsack is found
           if knapsack(s)==1
                %Chronometer stop
                toc
                fprintf('We have found the simple knapsack: \n');
                return
            end
        end
        
        %Chronometer stop
        toc

        %Ask if you want to continue
        continuar=input('We have not found the simple knapsack. Do you want to continue with a bigger ...interval? (Y/N)', "s");
        if continuar=='Y'
            increment=increment+1;
        else
            stop=1;
            s=[];
        end
    end
end