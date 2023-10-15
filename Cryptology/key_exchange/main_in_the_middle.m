%Program that shows the vulnerability of the Diffie and Hellman protocol for key exchange.
fprintf('COMMON ELEMENTS\n');

%Inputs values
p=input('Introduce a prime number p:\n    ');
fprintf('Introduce a generator g of the multiplicative group determine by %d:', p);
g=input('\n    ');

%Errors control
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
%randA=randi([2 p-2]); %Random way
randA=1599; %Manual way
fprintf('    %d\n',randA);
powA=power_mod(g, randA, p);
fprintf('A sends to A power_mod (%d, %d, %d) = %d\n', g, randA, p, powA);

%Agent C Intercepts
fprintf('This number is intercepted by C\n');

%Agent B
fprintf('\nAGENT B\n');
fprintf('B should introduce its private number a between %d and %d:\n', 2, p-2);
%randB=randi([2 p-2]); %Random way
randB=843; %Manual way
fprintf('    %d\n',randB);
powB=power_mod(g, randB, p);
fprintf('B sends to A power_mod (%d, %d, %d) = %d\n', g, randB, p, powB);

%Agent C Intercepts
fprintf('This number is intercepted by C\n');

%Agent C
fprintf('\nAGENT C\n');
fprintf('C intercepts %d fromt A and %d from B and saves these numbers.\n', powA, powB);
fprintf('C should introduce its private number a between %d and %d:\n', 2, p-2);
%randC=randi([2 p-2]); %Random way
randC=284; %Manual way
fprintf('    %d\n',randC);
powC=power_mod(g, randC, p);
fprintf('C sends to A and B power_mod (%d, %d, %d) = %d\n', g, randC, p, powC);
fprintf('\nB thinks he has received such number form A and A from B.\n');

%Agents A and B calculate the result
fprintf('\nAGENTS A AND B\n');
fprintf('A obtains power_mod (%d, %d, %d) = %d\n', powC, randA, p, power_mod(powC, randA, p));
fprintf('B obtains power_mod (%d, %d, %d) = %d\n', powC, randB, p, power_mod(powC, randB, p));


%Agent C calculates the result
fprintf('\nAGENT C\n');
fprintf('For A computes power_mod (%d, %d, %d) = %d\n', powA, randC, p, power_mod(powA, randC, p));
fprintf('For B computespower_mod (%d, %d, %d) = %d\n', powB, randC, p, power_mod(powB, randC, p));