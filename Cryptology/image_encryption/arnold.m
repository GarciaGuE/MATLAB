%Function that orders or unorders a photo, according to the option chosen by the user.
%Output: ordered/unordered image
function arnold(photo, A)
    %Elegir opcion
    op=input('Introduce 1 to disorder or 2 to order: ');
    switch op
        case 1
            %Show initial image
            imshow(photo);
            pause(1);

            %Apply pixel disorder
            pixel_disorder(photo,A);
            picture=getappdata(0,'result');

            %Show image
            imshow(picture);

            %Save image
            imwrite(picture, './imgDesord.bmp');

        case 2
            %Photo matrix
            matriximg=imread(photo);
            imshow(photo);
            pause(1);

            %Calculate the inverse of the matrix and pixel disorder
            [fil,~,~]=size(matriximg);
            inv=inv_module(A,fil);
            pixel_disorder(photo,inv);
            picture=getappdata(0,'result');

            %Show image
            imshow(picture);
            
            %Save image
            imwrite(picture, './imgOrd.bmp');
    end
end