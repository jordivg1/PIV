function FSCORE = FScore(matriu,number,TP,T,P)

TP(number) = matriu(number,number);
            
            for i = 1 : size(matriu,1)
            P(number) = P(number) + matriu(number, i); 
            T(number) = T(number) + matriu(i,number);        
            end
            
Recall = TP(number)/T(number);
Precision = TP(number)/P(number);
FSCORE = 2*(Recall*Precision)/(Recall+Precision);

end

