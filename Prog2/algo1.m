path_ima = 'C:\Users\piv137\Desktop\PIV3\Prog2\Training-Dataset\Images';
path_mask = 'C:\Users\piv137\Desktop\PIV3\Prog2\Training-Dataset\Masks-Ideal';

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
hist3([aux1 aux2],[256 256])

llmaxcr = max(aux2);
llmaxcb = max(aux1);
llmincr = min(aux2);
llmincb = min(aux1);