function[parents] = roleta(npop, fit)
    prob_sel = fit./sum(fit); % SPF
    reta = cumsum(prob_sel); % Vetor soma SPF
    parents = zeros(1,npop);
    
    % Roleta
    individuo = 1;
    while (individuo <= npop)
        r = rand;
        i = 1;
        while (reta(i) < r)
            i = i + 1;
        end
        parents(individuo) = i;
        individuo = individuo + 1;
    end