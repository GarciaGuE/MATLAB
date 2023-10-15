% Computes the MD5 hash of a message.
%
% Output: MD5 of the previous message in hexadecimal format.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1st STEP.- INTRODUCING NECESSARY VARIABLES AND CONSTANTS.
clc
%1.1. STEP.- MESSAGE.

message=input('Write the message:\n','s');


% 1.2. STEP.- WORK MODULE: m=2^32.
m=2^32;

% 1.3. STEP.- CREATE A MATRIX S FOR THE BIT ROTATION.
% NUMBERS ARE NEGATIVE SINCE IT IS A LEFT ROTATION.
s = [-7, -12, -17, -22;-5,  -9, -14, -20;-4, -11, -16, -23;-6, -10, -15, -21];

% 1.4. STEP.- t IS THE VECTOR WITH THE T_i CONSTANTS (sin...).
t=fix(abs(sin(1:64)).*m);

% 1.5. STEP.- INITIAL WORDS. MD5 USES THE FOLLOWING 4 WORDS:
% A=01 23 45 67, but in little endian:67 45 23 01
% B=89 ab cd ef --> ef cd ab 89 
% C=fe dc ba 98 --> 98 ba dc fe
% D=76 54 32 10 --> 10 32 54 76

fhash=[hex2dec('67452301'), hex2dec('efcdab89'), hex2dec('98badcfe'), hex2dec('10325476')];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 2nd STEP.- PREPARING THE MESSAGE FOR THE MD5 ALGORITHM.
bitlen=length(message)*8;
message=abs(message);
bytelen=numel(message);

% 2.1. STEP.- COMPLETE THE MESSAGE WITH 1 AND 0'S SO THAT THE NUMBER OF BITS
% IS CONGRUENT WITH 448 MOD 512. IF WORKING WITH BYTES, COMPLETE WITH 128
% AND 0'S SO THAT THE NUMBER OF BYTES IS CONGRUENT WITH 56 MOD 64.
message=[message, 128];
while 1
    bytelen=numel(message);
    if mod(bytelen, 64)==56
        break;
    else
        message=[message, 0];
    end
end
% 2.2. STEP.- 1 WORD = 4 BYTES. THUS, MAKE A 4-ROW MATRIX WITH THE BYTES OF 
% THE MESSAGE: EACH COLUMN WOULD BE A WORD. 
matrixmessage=reshape(message, 4, []);

% 2.3. STEP.- CONVERT EACH COLUMN TO 32-BITS INTEGERS (little endian).
x32=[];
for i=1:size(matrixmessage, 2)
    aux=matrixmessage(1,i) + 2^8*matrixmessage(2,i) + 2^16*matrixmessage(3,i) + 2^24*matrixmessage(4,i);
    x32=[x32, uint32(aux)];
end

% 2.4. STEP- COMPLETE WITH THE LENGTH OF THE ORIGINAL MESSAGE WITH A 64-BIT 
% INTEGER -> 8 BYTES -> 2 WORDS (little endian each word).
x64=[x32, mod(bitlen,m), mod(floor(bitlen/m),m)];
message=double(x64);
fprintf('\nmessage=\n   [');
fprintf(' %d', message);
fprintf(' ]\n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 3rd STEP.- MD5 ALGORITHM.
% WORK WITH 512-BITS BLOCKS. EACH BLOCK HAS 16 WORDS.
for k=1:16:numel(message)
    a=fhash(1); b=fhash(2); c=fhash(3); d=fhash(4);
    for i=1:64
        % Convert b, c and d to row vectors of bits.
        bv=dec2bin(b, 32)-'0';
        cv=dec2bin(c, 32)-'0';
        dv=dec2bin(d, 32)-'0';
        % obtain the logical functions  f(b,c,d).
        %      ki=index  0:15 of the message (k + ki).
        %      sr=rows 1:4 of  s(sr, :).
        if i<=16          % 1st  round
            f=(bv & cv) | (~bv & dv);
            ki=i - 1;
            sr=1;
        elseif i<=32      %2nd round
            f=(bv & dv) | (cv & ~dv);
            ki=mod(5*i-4, 16);    %from 5 to 5 starting at 1
            sr=2;
        elseif i<=48      %3rd round
            f=xor(bv, xor(cv, dv));
            ki=mod(3*i+2, 16);    %from 3 to 3 starting at 5
            sr=3;
        else                %4th round
            f=xor(cv, bv | ~dv);
            ki=mod(7*i-7, 16);    %from 7 to 7 starting at 0
            sr=4;
        end
        % CONVERT f, FROM A ROW VECTOR OF BITS TO 32-BIT INTEGERS.
        f=bin2dec(int2str(f));
       
        % APPLYING THE OPERATIONS OF THE ROUNDS.
        sc=mod(i-1, 4)+1;
        sum=mod(a+f+message(k+ki)+t(i), m);
        sum=dec2bin(sum, 32);
        sum=circshift(sum, [0, s(sr, sc)]);
        sum=bin2dec(sum);

        % MODIFYING a, b, c AND d. ROTATION IS NECESSARY.
        a=d;
        d=c;
        c=b;
        b=mod(sum+b,m);

    end
    
    % MODIFYING THE HASH.
    fhash=mod(fhash+[a,b,c,d],m);
end


% CONVERT THE HASH FROM 32-BIT INTEGERS (little endian) TO BYTES.
bytes=[];
for i=1:size(fhash, 2)
    bytes(i)=swapbytes(uint32(fhash(i)));
end

% CONVERT THE HASH TO HEXADECIMAL.
hexhash='';
hx=dec2hex(bytes);
for i=1:size(hx,1)
    hexhash=strcat(hexhash,hx(i,:));
end

fprintf('\nMD5= \n');
fprintf('   ''%s''', lower(hexhash));
fprintf('\n');