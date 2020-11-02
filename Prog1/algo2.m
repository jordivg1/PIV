path_imav = 'C:\Users\piv137\Desktop\PIV\Prog1\Validation-Dataset\Images';
path_maskv = 'C:\Users\piv137\Desktop\PIV\Prog1\Validation-Dataset\Masks-Ideal';

lista_imav = dir(path_imav);
lista_maskv = dir(path_maskv);

% for i = 3 : size(lista_ima,1)
%     for k = 1 : size(lista_ima(i).name,2)
%         name_imagesv(i-2,k) = lista_imav(i).name(k);
% %         name_masksv(i-2,k) = lista_maskv(i).name(k);
% %     end 
%    
%     imagev = rgb2ycbcr(imread(name_images(i-2,:)));

imagev = rgb2ycbcr(imread('1_P_hgr1_id06_1.jpg'));
imagev=double(imagev)/255;
maskv = zeros(size(imagev,1),size(imagev,2))    
    for j = 1 : size(imagev,1)
        for k = 1 : size(imagev,2)
            if (imagev(j,k,2) >= 0.55 || imagev(j,k,2) <= 0.33 || imagev(j,k,3) >= 0.55 || imagev(j,k,3) <= 0.33 )
                maskv(j,k) = 0;
                
            else 
                maskv(j,k) = 1;
               
       
            end
        end
    end
    imshow(maskv)
    