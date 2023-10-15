%Program that includes all the steps to encrypt and decrypt a message by 
%the RSA method with signature authentication.

%Key input for AGENT A
fprintf('AGENT A\n');
PUBLICKEYA=input('Introduce the public key of A, (na,ea):\n    ');
PRIVATEKEYA=input('Introduce the private key of A, (na,da):\n    ');

%Error control
v=[PUBLICKEYA PRIVATEKEYA];
vn=v(0>v | mod(v,1)~=0);
if ~isempty(vn) || ischar(v)
    error('Inputs must be naturals');
end

%Key input for AGENT B
fprintf('\nAGENT B\n');
PUBLICKEYB=input('Introduce the public key of B, (nb,eb):\n    ');
PRIVATEKEYB=input('Introduce the private key of B, (nb,db):\n    ');

%Error control
v=[PUBLICKEYB PRIVATEKEYB];
vn=v(0>v | mod(v,1)~=0);
if ~isempty(vn) || ischar(v)
    error('Inputs must be naturals');
end

%Sending a message by AGENT A
fprintf('\nAGENT A\n');
SENDA=input('Introduce the text you want to send to B:\n    ','s') ;
SIGNATUREA=input('Introduce your signature:\n    ', 's');

%Concatenation of message and signature
CONCATA=strcat(SENDA, SIGNATUREA);

%Encryption
fprintf('\nThe two cryptograms that A send to B are:\n');
%Encryption of the concatenated text and signature with B's public key
text_ciph=rsa_cipher(PUBLICKEYB(1), PUBLICKEYB(2), CONCATA);

%Display encrypted text
fprintf('text_ciph=     ');
fprintf('%d     ', text_ciph);

%Encryption of the signature with A's private key
dbc=rsa_cipher(PRIVATEKEYA(1), PRIVATEKEYA(2), SIGNATUREA);

%Padding with leading zeros if it does not match the size of A's public key
size=length(num2str(PUBLICKEYA(1)));
block=[];
for i=1:length(dbc)
    aux=num2str(dbc(i));
    if length(aux)<size
        while length(aux)~=size
            aux=strcat('0', aux);
        end
    end
    block=[block aux];
end

%Blocks concatenation
concat='';
for j=1:length(block)
    concat=strcat(concat, block(j));
end

%Prepare blocks with the length of B's public key
size2=length(num2str(PUBLICKEYB(1)))-1;
prepbloc=prepare_num_cipher(size2, concat);

%Encryption with B's public key
sign_ciph_da_eb=rsa_num_cipher(PUBLICKEYB(1), PUBLICKEYB(2), prepbloc);
fprintf('\nsign_ciph_da_eb=     ');
fprintf('%d     ', sign_ciph_da_eb);

%Message received by AGENT B
fprintf('\n\nAGENT B\n');
fprintf('B starts deciphering the codes.\n');
fprintf('The text he has received jointly with the signature is:\n');

%Decryption of the text with B's private key
text=rsa_decipher(PRIVATEKEYB(1), PRIVATEKEYB(2), text_ciph);
fprintf('text = ''%s''\n',text);
fprintf('B obtains the signature:\n');

%Incomplete decryption of the signature
text2=rsa_num_decipher(PRIVATEKEYB(1), PRIVATEKEYB(2), sign_ciph_da_eb);

%Complete with leading zeros if it does not match the length of the
% B's public key
size=length(num2str(PUBLICKEYB(1)))-1;
block=[];
for i=1:length(text2)
    aux=num2str(text2(i));
    if length(aux)<size
        while length(aux)~=size
            aux=strcat('0', aux);
        end
    end
    block=[block aux];
end

%Concatenate the blocks
concat='';
for j=1:length(block)
    concat=strcat(concat, block(j));
end

%Prepare blocks with the length of A's public key
size2=length(num2str(PUBLICKEYA(1)));
prepbloc=prepare_num_cipher(size2, concat);

%CCheck and remove padding
blockf=[];
for i=1:2:size2-1
    blockf=[blockf '30'];
    if i+1==size2-1
       blockf=[blockf '0']; 
    end
end
blockf=str2num(blockf);
descsig=[];
for j=1:length(prepbloc)
    if prepbloc(j)~=blockf
        descsig=[descsig prepbloc(j)];
    end
end

%Decryption of the signature
signature=rsa_decipher(PUBLICKEYA(1), PUBLICKEYA(2), descsig);
fprintf('signature = ''%s''\n',signature);

%End of authentication
fprintf('We have succeeded with the signature authentification.\n');