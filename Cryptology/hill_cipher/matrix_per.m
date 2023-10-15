%Check if the input sequence is a valid permutation and create the associated permutation matrix.
function matrix=matrix_per(p)
    if permutation(p)==0
        fprintf('The input is not a permutation.\n');
        matrix=[];
    else
        l=length(p);
        A=zeros(l, l);
        for i=1:l
            A(i,p(i))=1;
        end
        matrix=A;
    end
end