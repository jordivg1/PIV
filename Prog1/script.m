path_ima = 'C:\Users\piv137\Desktop\PIV\Prog1\Training-Dataset\Images';
path_mask = 'C:\Users\piv137\Desktop\PIV\Prog1\Training-Dataset\Masks-Ideal';

lista_ima = dir(path_ima);
lista_mask = dir(path_mask);
aux1 = [];
aux2 = [];
for i = 3 : size(lista_ima,1)
    for k = 1 : size(lista_ima(i).name,2)
        name_images(i-2,k) = lista_ima(i).name(k);
        name_masks(i-2,k) = lista_mask(i).name(k);
    end   
    
    image = rgb2ycbcr(imread(name_images(i-2,:)));
    mask = imread(name_masks(i-2,:));
    
    image=double(image)/255;
    ima_mask =[];
    ima_mask(:,:,1)=image(:,:,1).*(1-mask);
    ima_mask(:,:,2)=image(:,:,2).*(1-mask);
    ima_mask(:,:,3)=image(:,:,3).*(1-mask); 
    
    cb = double(ima_mask(:,:,2));
    cr=double(ima_mask(:,:,3));
    
    cbb = reshape(cb,[size(cb,1)*size(cb,2),1]);
    crr =  reshape(cr,[size(cr,1)*size(cr,2),1]);
    
    cbb(cbb==0) = [];
    crr(crr==0) = []; 
    
    aux1 = vertcat(aux1,cbb);
    aux2 = vertcat(aux2,crr);

end
llmaxcb= max(aux1);
llmincr=min(aux2)
llmincb=min(aux1)
llmaxcr=max(aux2)

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
            if (imagev(j,k,2) >= llmaxcb|| imagev(j,k,2) <= llmincb || imagev(j,k,3) >= llmaxcr|| imagev(j,k,3) <= llmincr )
                maskv(j,k) = 0;
                
            else 
                maskv(j,k) = 1;
               
       
            end
        end
    end
    imshow(maskv)
    

