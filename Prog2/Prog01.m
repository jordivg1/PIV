%% Entrenamiento

path_ima = 'D:\UPC\3B\PIV\Prueba\Prog1\Training-Dataset\Images';
path_mask = 'D:\UPC\3B\PIV\Prueba\Prog1\Training-Dataset\Masks-Ideal';

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


%% Validación

path_imav = 'D:\UPC\3B\PIV\Prueba\Prog1\Test-Dataset\Test-Images';
path_maskv = 'D:\UPC\3B\PIV\Prueba\Prog1\Test-Dataset\Test-Masks';
path_maskval = 'D:\UPC\3B\PIV\Prueba\Prog1\Test-Dataset\Test-Masks-Ideal';

lista_imav = dir(path_imav);
lista_maskval = dir(path_maskval);
P=0;
T=0;
TP=0;

for i = 3 : size(lista_imav,1)
    for k = 1 : size(lista_imav(i).name,2)
        name_imagesv(i-2,k) = lista_imav(i).name(k);
        name_masksval(i-2,k) = lista_maskval(i).name(k); %lee las mascaras de validación
    end 
   
    maskval = imread(name_masksval(i-2,:));
    imagev = rgb2ycbcr(imread(name_imagesv(i-2,:)));
    imagev=double(imagev)/255;
    maskv = zeros(size(imagev,1),size(imagev,2));    
    for j = 1 : size(imagev,1)
        for k = 1 : size(imagev,2)
            if (imagev(j,k,2) >= 0.64 || imagev(j,k,2) <= 0.4 || imagev(j,k,3) >= 0.54 || imagev(j,k,3) <= 0.34)
                maskv(j,k) = 0;
                
            else 
                maskv(j,k) = 1;
            end
        end
    end
    
    for l = 3 : size(maskval,1)
        for m= 1 : size(maskval,2)
            if maskv(l,m) == 0
                P=P+1;
            end
            if maskval(l,m) == 0
                T=T+1;
            end
            if maskv(l,m) == 0 && maskval(l,m)== 0
                TP=TP+1;
            end
        end
    end
                
    
    
    imshow(maskv)
    nombre=strcat('mask',int2str(i-2));
    nombre=[path_maskv,'\',nombre];
    saveas(gcf,nombre,'bmp');
end

RECALLTOT =TP/T;
PRECTOT = TP/P;
FSCORE = 2*(RECALLTOT*PRECTOT)/(RECALLTOT+PRECTOT);


%% FScore

fileID = fopen('FSCORE.txt','w');

fprintf(fileID,'FScore = %d\n',FSCORE');

fclose(fileID);