function [numberOfFingers,BW3,maskv] = fingersDetector(maskv,i,name)

path = 'D:\UPC\3B\PIV\PIV3\Prog2\Files\';
name = strcat(path,name,'.txt');

fileID = fopen(name,'w');

    CC = bwconncomp(1-maskv);
    S = regionprops(CC, 'Area');
    L = labelmatrix(CC); 
    BW2 = ismember(L, find([S.Area] >= 9000));
    SE = strel('rectangle',[5 5]);

     
    maskv=imopen(BW2,SE);
    maskv=imclose(BW2,SE);
    
   
    SH = strel('rectangle',[15 65]);
    SL = strel('rectangle',[50 15]);
    
    
    JL = imopen(maskv,SH);
    JG = imopen(maskv,SL);
    JJ = min(JL,JG);
    dedos = maskv - JJ;
    
    SU = strel('rectangle',[11 11]);
  
    dedosv2 = imopen(dedos, SU);
    SM = strel('rectangle',[11 11]);
    dedosv3 = imopen(dedosv2, SM);
    
%     CCC = bwconncomp(dedosv3);
    BW3 = bwareaopen(dedosv3, 2000);
    L = bwlabel(BW3);
    numberOfFingers = max(max(L));
     imshow(BW3)

  if(numberOfFingers > 5) 
       numberOfFingers = 5; 
   end

fprintf(fileID,'%d\n',numberOfFingers');
    
fclose(fileID);

end

