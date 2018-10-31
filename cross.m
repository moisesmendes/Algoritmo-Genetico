
function children = cross(parents,crossProb)
% parents: 2 vetores coluna, cada um de tamanho p (numero de medianas)

p = size(parents,1); %numero de medianas
children = zeros(size(parents));

if rand <= crossProb
   mascara = randi([0,1],1,p);
   for i=1:p
      if mascara(i)==1
         children(i,1) = parents(i,1);
         children(i,2) = parents(i,2);
      else
         children(i,1) = parents(i,2);
         children(i,2) = parents(i,1);
      end
      
   end
else
   children = parents;
end

end