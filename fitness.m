function [dist, cliente, mediana, path] = fitness(facilidade,n,D)
% FITNESS Calcula a aptidão de uma solução candidata, que é a soma das
% menores distâncias de cada vértice a uma mediana.
% INPUTS
%     facilidade: vetor com as p medianas
%     n: numero total de vertices
%     D: matriz de distancias entre os vertices
% OUTPUTS
%     dist: soma das menores distancias de cada cliente a uma facilidade
%     cliente: vetor de clientes atendidos pelas facilidades
%     mediana: facilidade que atende a cada cliente na mesma ordem do vetor
%     cliente
%     path: distancia de cada cliente à facilidade mais próxima

cliente = zeros(1,n-length(facilidade)); % vertices que nao sao medianas

j=1;
for i=1:n
   if isempty(find(facilidade==i, 1))
      cliente(j) = i;
      j=j+1;
   end
end

mediana = zeros(1,length(cliente)); %vetor que guarda as medianas de cada cliente
path = zeros(1,length(cliente)); %vetor que guarda a distancia de cada cliente à mediana mais próxima
dist = 0;

for k=1:length(cliente) %para cada cliente procura a facilidade mais proxima
   menor = D(cliente(k),facilidade(1)); 
   mediana(k) = facilidade(1);
   
   for j=2:length(facilidade) %verifica se ha uma facilidade mais proxima que a primeira
       if D(cliente(k),facilidade(j)) < menor
          menor = D(cliente(k),facilidade(j));
          mediana(k) = facilidade(j);
       end
   end
   
   path(k) = menor; 
   dist = dist + menor;
end

end