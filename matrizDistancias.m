%implementa a matriz de distancias do tp

function D = matrizDistancias(n,posicao)

D = zeros(n);

for i=2:n
   for j=1:i-1
      a = posicao{i}; b = posicao{j};
      dist = sqrt((a(1)-b(1)).^2 + (a(2)-b(2)).^2);
      
      D(i,j) = dist;
      D(j,i) = dist;
   end
end

end