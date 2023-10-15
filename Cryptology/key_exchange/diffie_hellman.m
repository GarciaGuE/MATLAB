%%Program in which the Diffie and Hellman protocol for key exchange is implemented.
fprintf('COMMON ELEMENTS\n');

%Inputs values
p=input('Introduce a prime number p:\n    ');
fprintf('Introduce a generator g of the multiplicative group determine by %d:', p);
g=input('\n    ');

%Error control
v=[g p];
vn=v(0>=v | mod(v,1)~=0);
if ~isempty(vn)|| ischar(v)
    error('Inputs must be natural');
end

if isprime(p)==0 
    error('Second input must be prime');
end

%Agent A
fprintf('\nAGENT A\n');
fprintf('A should introduce its private number a between %d and %d:\n', 2, p-2);
randA=randi([2 p-2]); %Random way
%randA=3; %Manual way
fprintf('    %d\n',randA);
powA=power_mod(g, randA, p);
fprintf('A sends to A power_mod (%d, %d, %d) = %d\n', g, randA, p, powA);

%Agent B
fprintf('\nAGENT B\n');
fprintf('B should introduce its private number a between %d and %d:\n', 2, p-2);
randB=randi([2 p-2]); %Random way
%randB=5; %Manual way
fprintf('    %d\n',randB);
powB=power_mod(g, randB, p);
fprintf('B sends to A power_mod (%d, %d, %d) = %d\n', g, randB, p, powB);

%Result
fprintf('\nBOTH AGENTS\n');
fprintf('A obtains power_mod (%d, %d, %d) = %d\n', powB, randA, p, power_mod(powB, randA, p));
fprintf('B obtains power_mod (%d, %d, %d) = %d\n', powA, randB, p, power_mod(powA, randB, p));