% mutacao

function children = mutacao(new_gen,crossMut, n)
%new_gen: 2 vetores coluna, cada um de tamanho p (numero de medianas)

p = size(new_gen,1); %numero de medianas
%children = zeros(size(new_gen));

if rand <= crossMut
    for i=1:2
        existe = false;
        while existe == false
            new = randi([1,n]);
            if size(find(new_gen(:,i) == new),1) == 0
                pos = randi([1,p]);
                new_gen(pos,i) = new;
                existe = true;
            end
        end
    end
end

children = new_gen;

end