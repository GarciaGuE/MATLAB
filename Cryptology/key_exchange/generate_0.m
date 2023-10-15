%Function that checks, through the generator definition, if the number
%natural g is the generator of the multiplicative group determined by the prime p.
%Outputs:
%   gen=0 in case it is not a generator.
%   gen=g in case it is a generator.
function gen=generate_0(g,p)
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
    
    %Power vector
    v=[];
    gen=g;

    for i=1:p-1
        prev=power_mod(g, i, p);
        v=[v prev];
    end

    %If any value is repeated, it is not a generator
    vu=unique(v);
    if length(vu)~=length(v)
        gen=0;
    end
    %Chronometer stop
    toc
end