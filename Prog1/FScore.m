path_imav = 'C:\Users\piv137\Desktop\PIV\Prog1\Validation-Dataset\Images';
path_maskv = 'C:\Users\piv137\Desktop\PIV\Prog1\Validation-Dataset\Masks';
path_maskval = 'C:\Users\piv137\Desktop\PIV\Prog1\Validation-Dataset\Masks-Ideal';

lista_imav = dir(path_imav);
lista_maskval = dir(path_maskval);
P=0;
T=0;
TP=0;
RECALLTOT=0;
PRECTOT=0;



for i = 3 : size(lista_imav,1)
    for k = 1 : size(lista_imav(i).name,2)
        name_imagesv(i-2,k) = lista_imav(i).name(k);
        name_masksval(i-2,k) = lista_maskval(i).name(k); %lee las mascaras de validación
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
                
    
    
    
  
end
RECALLTOT =TP/T
PRECTOT = TP/P
FSOCRE = 2*(RECALLTOT*PRECTOT)/(RECALLTOT+PRECTOT)
