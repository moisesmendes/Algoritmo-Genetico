function [distancia, vertices, medianas, path] = pmedianas(filename,npop,crossProb,crossMut)
% PMEDIANAS Algoritmo que resolve o problema das p-medianas através de um algoritmo
% genético geracional com elitismo.
%
% Inputs:
%     filename: instancia do problema (.txt)
%     npop = número de indivíduos da população;
%     crossProb = probabilidade de cruzamento (alta);
%     crossMut = probabilidade de mutação (alta);
%
% Outputs:
%     distancia: soma das menores distancias de cada vertice a uma mediana
%     vertices: vetor de vertices atendidos pelas medianas
%     medianas: mediana que atende a cada vertice na mesma ordem do vetor
%        de vertices
%     path: distancia de cada vertice à mediana mais próxima
%
% Example:
%     [distancia, vertices, medianas, path] = pmedianas;
% 
% Autores:
%     Gilson Urbano
%     Moises Mendes


% Parâmetros default do método
if nargin<1
   filename = 'pmedian324.txt';
   npop = 30;
   crossProb = 0.95;
   crossMut = 0.55;
   tmax = 1000;
end

[n,p,posicao] = leitura(filename);
D = matrizDistancias(n,posicao);
f = zeros(1,npop);
new_gen = zeros(p,npop);
Fitmelhor = zeros(1,tmax);
Fitmedio = zeros(1,tmax);

P = zeros(p,npop); % Cada coluna é um individuo (solução canditata)

for i=1:npop
   P(:,i) = randperm(n,p)';
   f(i) = fitness(P(:,i),n,D);
end

XY = cell2mat(posicao); % Coordenadas X,Y

parada = 1;
t=1;
while t <= tmax && parada < 30
   
   % Seleção dos pais - Roleta
   parents = roleta(npop, f); % Indices dos pais
   
   % Cruzamento e Mutação
   for i=1:2:npop
      pais = [P(:,parents(i)),P(:,parents(i+1))];
      % Crossover
      new_gen(:,i:i+1) = cross(pais,crossProb);
      % Mutação
      new_gen(:,i:i+1) = mutacao(new_gen(:,i:i+1),crossMut,n);
   end
   
   fnew = zeros(1,size(new_gen,2));
   for i=1:size(new_gen,2)
      fnew(i) = fitness(new_gen(:,i),n,D);
   end
   
   % Avaliação mi+lambda
   candidatos = [P, new_gen];
   fit = [f, fnew];
   
   % Seleção mais aptos;
   [fit_ord, index] = sort(fit);
   
   f = fit_ord(1:npop);
   P = candidatos(:,index(1:npop));
   
   Fitmelhor(t) = f(1);
   Fitmedio(t) = mean(f);
   
   % Plota gráfico iterativo dos vértices n e p
   figure(1)
   hold on
   scatter(XY(:,1),XY(:,2), 'filled', 'blue')
   for i=1:p
      scatter(XY(P(i),1), XY(P(i),2), 'filled', 'red');
   end
   hold off
   pause(0.01);
   
   % Critério de Parada
   if t > 2 && Fitmelhor(t) == Fitmelhor(t-1) && Fitmedio(t) == Fitmedio(t-1)
      parada = parada + 1;
   else
      parada = 0;
   end
   
   t = t + 1;
end

% Resultados
solution = sort(P(:,1));
[distancia, vertices, medianas, path] = fitness(solution,n,D);
vertices = [solution' vertices];
medianas = [solution' medianas];
path = [zeros(1,length(solution)) path];


% Gráfico: Melhor individuo e Individuo medio 
Fitmelhor = Fitmelhor(1:t-1);
Fitmedio = Fitmedio(1:t-1);

figure(2)
%close all;
H(1) = plot(Fitmelhor, 'b');
hold on
H(2) = plot(Fitmedio, 'r');
legend('Melhor Indivíduo','Indivíduo Médio')
title('Evolução')
xlabel('Num Gerações')
ylabel('Aptidão')
set(H, 'linewidth',2);
grid on
hold off

end