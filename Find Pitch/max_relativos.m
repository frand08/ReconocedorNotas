function [maximos_y, maximos_x] = max_relativos(signal,max_ruido)
    % Devuelve dos vectores con la ubicacion de los maximos relativos en x
    % e y
    % max_ruido: nivel maximo de ruido (para eliminar el ruido)

    maximos_y = [];
    maximos_x = [];
    if length(signal) < 2
        return;
    end
    
    start = 0;
    for i = 1:length(signal)
        if signal(i) <= max_ruido
            continue
        end
        if i == 1
            if signal(1) > signal(2)
                maximos_y = signal(1);
                maximos_x = 1;
                start = 1;
            end
        else
            if i == length(signal)
                if signal(i) > signal(i-1)
                    if start == 1
                        maximos_y = [maximos_y signal(i)];
                        maximos_x = [maximos_x i];
                    else
                        maximos_y = signal(i);
                        maximos_x = i;
                        start = 1;
                    end
                end
            else
                if signal(i) > signal(i+1) && signal(i) > signal(i-1)
                    if start == 1
                        maximos_y = [maximos_y signal(i)];
                        maximos_x = [maximos_x i];
                    else
                        maximos_y = signal(i);
                        maximos_x = i;
                        start = 1;
                    end
                end
            end
        end
    end
end