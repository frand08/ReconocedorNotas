function [frec_Ffund] = FindPitch(in,fs)

% Halla la fundamental del bloque de entrada

MIN_FREC = 80;                          % Va a detectar a partir de esta frecuencia
in_hann = in.*hann(length(in))';        % Aplico una ventana Hann

in_hann_corr = xcorr(in_hann);          % Y autocorrelaciono

[fft_in_hann_corr,f_corr] = plotFFT(in_hann_corr,fs);   % Obtengo la FFT
[Fm_corr,Fm_x_corr] = max(fft_in_hann_corr);        % Calcula el maximo absoluto
f=f_corr(Fm_x_corr);            % Frecuencia en la que se ubica el maximo absoluto


d = floor(MIN_FREC/(fs/length(in)));  % Distancia minima entre harmonicos
M = floor(f/d);                 % El maximo absoluto va a ser menor a M*f0
Ffund = zeros(length(M));
for i=1:M
    Ffund(i) = f/i;             % Calculo los posibles valores de la f0
end

piso_corr = Fm_corr*0.0001;         % Determino un piso para no considerar el ruido

[max_y_corr,max_x_corr] = max_relativos(fft_in_hann_corr,piso_corr);

max_frec_corr=zeros(length(max_x_corr));    % Vector de frecuencias obtenidas de maximos relativos

for i=1:length(max_x_corr)
    max_frec_corr(i)=f_corr(max_x_corr(i));
end
entro = 1;  % Flag
for i=1:length(max_frec_corr)
    if entro
        if max_frec_corr(i)>MIN_FREC
            for j=1:length(Ffund)
                if (((max_frec_corr(i) + 1.5) > Ffund(j)) && ((max_frec_corr(i) - 1.5) < Ffund(j)))
                    frec_Ffund = Ffund(j);      % Si se condice algun valor de Ffund con un valor de los maximos 
                                                % relativos (dentro de un entorno), entonces esa sera la fundamental,
                                                % suponiendo que exista
                    entro = 0;
                end
            end
        end
    end
end


end