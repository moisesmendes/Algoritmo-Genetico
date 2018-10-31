% leitura do arquivo txt do tp

function [n,p,posicao] = leitura(filename)

fp = fopen(filename,'r');
A = textscan(fp,'%f %f');
n = A{1}(1); 
p = A{2}(1);

posicao = cell(n,1);
for i=1:n
   posicao{i} = [A{1}(i+1), A{2}(i+1)];
end

end
