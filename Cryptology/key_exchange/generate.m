%Function that checks, using the alternative criterion, if the
%natural number g is the generator of the multiplicative group determined by the prime p.
%Outputs:
%   gen=0 in case it is not a generator.
%   gen=g in case it is a generator.
function gen=generate(g,p)
    %Chronometer start
    tic

    %Errors control
    v=[g p];
    vn=v(0>=v | mod(v,1)~=0);
    if ~isempty(vn)|| ischar(v)
        error('Inputs must be natural');
    end

    if isprime(p)==0 
        error('Second input must be prime');
    end

    %Find the prime factors
    factors=factor(p-1);
    gen=g;
    for i=1:length(factors)
        %Criterion
        pow=power_mod(g, (p-1)/factors(i), p);
        
        %If we find 1, it is not a generator 
        if pow==1
            gen=0;

            %Chronometer stop
            toc
            return;
        end
    end
    %Chronometer stop
    toc
end