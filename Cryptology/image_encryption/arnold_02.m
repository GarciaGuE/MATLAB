%Function that rearranges the pixels of the photo image according to matrix A successively. 
%Output: unordered image
function power=arnold_02(photo, A)
    %Error control
    An=A(mod(A,1)~=0);
    if ~isempty(An)
        error('Second input must be natural.');
    end
    
    %Photo matrix
    matriximg=imread(photo);
    [fil,col,can]=size(matriximg);
    opt=input('Introduce 1 to disorder until getting the original image or 2 to apply a certain number of transformations: ');
    picture=0;  
    switch opt
        case 1
            power=power_a(A,fil);

            %Show initial image
            imshow(photo);
            pause(0.4);
            for i=1:power
                %Apply pixel disorder
                pixel_disorder(photo,A);
                picture=getappdata(0,'result');
                if i>1
                    delete(photo);
                end
                archivo=strcat('Photopow',num2str(i));
                archivo=strcat(archivo,'.bmp');
                imwrite(picture,archivo);
                photo=archivo;

                %Show pow image
                imshow(photo);
                archivo='';
            end
        case 2
            n=input('\nHow many transformations do you want to apply? ');

            %Calculate the possible transformations and apply module
            power=power_a(A,fil);
            power=mod(n,power);

            %Show initial image
            imshow(photo);
            pause(0.5);
            for i=1:power
                %Apply pixel disorder
                pixel_disorder(photo,A);
                picture=getappdata(0,'result');
                if i>1
                    delete(photo);
                end
                archivo=strcat('Photopow',num2str(i));
                archivo=strcat(archivo,'.bmp');
                imwrite(picture,archivo);
                photo=archivo;

                %Show pow image
                imshow(photo);
                archivo='';
            end
    end
end