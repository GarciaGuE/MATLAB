%Key matrix used for encryption found through cryptanalysis with a Gauss-Jordan type attack.
%The length of the text will be checked, if the matrices where the method will be applied 
%are of the same order and if it is possible to perform cryptanalysis.
function matrix=crypto_hill(text, code, d)
    txt=letter_number(text);
    lt=length(txt);
    if mod(lt, d)==0
        A=reshape(txt, d, []);
    else
        while mod(lt, d)~=0
             txt(end+1)=23;
             lt=length(txt);
        end
        A=reshape(txt, d, []);
    end
    encryption=letter_number(code);
    lc=length(encryption);
    if mod(lc, d)==0
        B=reshape(encryption, d, []);
    else
        while mod(lc, d)~=0
             encryption(end+1)=23;
             lc=length(encryption);
        end
        B=reshape(encryption, d, []);
    end
    
    A=transpose(A);
    B=transpose(B);
    lb=size(B);
    ld=d*d;
    la=size(A);

    if la(1,1)>lb(1,1)
        A=A(1:lb(1,1),1:lb(1,2));
    elseif la(1,1)<lb(1,1)
        B=B(1:la(1,1),1:la(1,2));
    end

    la=size(A);

    if lt<ld || lc<ld
        fprintf('The text is too short, its length should be at least %d.', ld)
        matrix=[];
        return
    end

    for i=1:la(1,2)
        if gcd(A(i,i),27)==1
            [g, u, v]=gcd(A(i,i), 27);
            A(i,:)=mod(u*A(i,:),27);
            B(i,:)=mod(u*B(i,:),27);
        else
            for j=i+1:la(1,1)
                if gcd(A(j,i), 27)==1
                    C=[];
                    C(1,:)=A(i, :);
                    C(2,:)=A(j, :);
                    A(j, :)=C(1,:);
                    A(i, :)=C(2,:);

                    D=[];
                    D(1,:)=B(i, :);
                    D(2,:)=B(j, :);
                    B(j, :)=D(1,:);
                    B(i, :)=D(2,:);
                end
            end
            [g, u, v]=gcd(A(i,i), 27);
            A(i,:)=mod(u*A(i,:),27);
            B(i,:)=mod(u*B(i,:),27);
        end
        for k=1:la(1,1)
            if k~=i 
                neg=A(k,i)-27;
                A(k, :)=mod(A(k,:)-neg*A(i,:), 27);
                B(k, :)=mod(B(k,:)-neg*B(i,:), 27);
            end
        end
    end
    I=zeros(d,d);
    for i=1:d
        for j=1:d
            if j==i
                I(i,j)=1;
            end
        end
    end
    A=A(1:d, 1:d);
    if A==I
        B=transpose(B);
        B=B(:, 1:d);
        matrix=B;
    else
        fprintf('We have not obtained the identity matrix. More text is needed for the cryptanalysis.\n')
        matrix=[];
    end
end