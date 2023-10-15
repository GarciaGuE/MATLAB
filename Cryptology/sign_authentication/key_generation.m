%Program to generate the public and private keys required for RSA encryption.
%Outputs: public and private keys.

%Requesting input data
p=input('Introduce the prime number p:\n    ');
q=input('Introduce the prime number q:\n    ');
    
%Error control
v=[p q];
vn=v(0>=v | mod(v,1)~=0);
if ~isempty(vn) || ischar(v)
    error('Inputs must be naturals');
end

if ~isprime(p) || ~isprime(q)
    error('Inputs must be primes');
end

%Calculate the value of n
n=p*q;
fprintf('\nThe value n is n = p · q = %d\n', n);

%Calculate the value of e
fprintf('\nThe value e, of the public key, should satisfy gcd(e, ... fiden)=gcd(e,(p-1)(q-1))=gcd(e,1387620)=1.\n');
fiden=(p-1)*(q-1);

%Choose e=65537 if it's less than phi(n) - 2
%Otherwise, find another value that satisfies the condition
e=65537;
if e>(fiden-2)
    %Start from phi(n)-3 down to 2
    e=fiden-3;
    while e>2
        if gcd(e,fiden-2)==1
            break;
        end
        e=e-1;
    end
end
fprintf('It is selected e = %d\n',e);

%Calculate the inverse d
[g, u, v]=gcd(e, fiden);
d=mod(u, fiden);
fprintf('\nd is the inverse of e module fiden: d = %d\n', d);

%Generate keys
fprintf('\nPRIVATE KEY : (n, d) = (%d, %d)\n',n,d);
fprintf('PUBLIC KEY : (n, e) = (%d, %d)\n',n,e);