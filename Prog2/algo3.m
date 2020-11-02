path_imav = 'D:\UPC\3B\PIV\PIV3\Prog2\Test-Dataset\Test-Images';
path_maskv = 'D:\UPC\3B\PIV\PIV3\Prog2\Test-Dataset\Test-Masks';
path_maskval = 'D:\UPC\3B\PIV\PIV3\Prog2\Test-Dataset\Test-Masks-Ideal';
path_fingers = 'D:\UPC\3B\PIV\PIV3\Prog2\Test-Dataset\Fingers';

lista_imav = dir(path_imav);
lista_maskval = dir(path_maskval);
%fileID = fopen('Fingers.txt','w');

T = zeros(1,6); Tmask = 0;
P = zeros(1,6); Pmask = 0;
TP = zeros(1,6); TPmask = 0;
FSCORE = zeros(1,6);
matriu = zeros(6,6);

for i = 3 : size(lista_imav,1)
   
   for k = 1 : size(lista_imav(i).name,2)
        name_imagesv(i-2,k) = lista_imav(i).name(k); %lee el nombre de la lista de imagenes
        name_masksval(i-2,k) = lista_maskval(i).name(k); %lee el nombre de la lista de mascaras de validación
    end 
    
   maskval = imread(name_masksval(i-2,:));
   imagev = rgb2ycbcr(imread(name_imagesv(i-2,:)));
   imagev=double(imagev)/255;
   maskv = maskCreator(imagev); 
   maskOriginal = maskv;
   [numberOfFingers,fingers,maskv] = fingersDetector(maskv,i-2,name_imagesv(i-2,:));
   
   [FSCOREmask,Tmask,Pmask,TPmask] = maskFSCORE(maskval,1-maskOriginal,Tmask,Pmask,TPmask);
   
   name_mask = [path_maskv,'\',name_masksval(i-2,:)];
   name_finger = [path_fingers,'\',name_masksval(i-2,:)];
   imwrite(maskOriginal,name_mask);
   imwrite(fingers,name_finger);
   
   number = str2double(name_imagesv(i-2,1));
   %matriu(numberOfFingers+1,number+1) = matriu(numberOfFingers+1,number+1) + 1;

   %FSCORE(number+1) = FScore(matriu,number+1,TP,T,P);
    
end

%fclose(fileID);

    