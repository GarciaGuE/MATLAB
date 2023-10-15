%Function that rearranges the pixels of the matrices associated with an image 
%according to the transformation associated with the given matrix.
%Output: unordered image matrix.
function pixel_disorder(photo,A)
    %Error control
    An=A(mod(A,1)~=0);
    if ~isempty(An)
        error('Second input must be natural.');
    end
        
    %Matrix of the image
    matriximg=imread(photo);
    [fil,col,~]=size(matriximg);
    
    %Matrix of the image to a square matrix
    if fil<col
        matriximg=matriximg(:,1:fil,:);
        [fil,col,can]=size(matriximg);
    else
        matriximg=matriximg(1:col,:,:);
        [fil,col,can]=size(matriximg);
    end

    %Check if the matrix is invertible and its order is 2
    [F,C]=size(A);
    d=det(A);
    dr=round(d);
    [g, ~, ~]=gcd(dr,fil);
    if F~=2 || C~=2 || g~=1
        error('Invalid matrix(Ord 2).');
    end

    %Pixel disorder
    disimg=zeros(fil,col,can);
    for i=1:fil
        for j=1:col
            %Matrix multiplication and module
            v=mod(A*[i j]',fil);
            x=v(1);
            y=v(2);

            %Null values are assigned to length and width
            if x==0
                x=fil;
            end
            if y==0
                y=col;
            end
            disimg(x,y,:)=matriximg(i,j,:);
         end
    end
    
    %Uint8 type
    disimg=uint8(disimg);
    setappdata(0, 'result', disimg);
end