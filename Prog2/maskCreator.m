function maskv = maskCreator(imagev)

 maskv = zeros(size(imagev,1),size(imagev,2));
 
    for j = 1 : size(imagev,1)
        for k = 1 : size(imagev,2)
            if (imagev(j,k,2) >= 0.64 || imagev(j,k,2) <= 0.3 || imagev(j,k,3) >= 0.54 || imagev(j,k,3) <= 0.34 )
                maskv(j,k) = 0;               
            else 
                maskv(j,k) = 1;
            end
        end
    end
    
end

