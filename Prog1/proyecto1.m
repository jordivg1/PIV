image = rgb2ycbcr(imread('1_P_hgr1_id01_1.jpg'));
mask = imread('1_P_hgr1_id01_1.bmp');
%imshow(image)
%imshow(mask)
image=double(image)/255;
ima_mask(:,:,1)=image(:,:,1).*(1-mask);
ima_mask(:,:,2)=image(:,:,2).*(1-mask);
ima_mask(:,:,3)=image(:,:,3).*(1-mask);  

imshow(ima_mask)

test = zeros(422,229,2);
cb = double(ima_mask(:,:,2));
cr=double(ima_mask(:,:,3));
%imshow(g);
cbb = reshape(cb,[96638,1]);
crr =  reshape(cr,[96638,1]);

cbb(cbb==0) = [];
crr(crr==0) = [];

prueba = [cbb crr];
hist3(prueba,[256 256])



