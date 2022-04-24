function ASK_Received_WithFilter_Spectrum(Filteredsignal,n)

v = length(Filteredsignal)*100 ;
L= length(Filteredsignal);
f= -n/2:n/v:(n/2)-(n/v);
X = fftshift(fft(Filteredsignal,v));
mag = abs(X);
figure(8);
plot(f,mag/L,'b', 'Linewidth',1.5);
title('Spectrum Of Demodulated Signal After Filtration');
xlim([-2 2]);
ylim([0 0.3]);

end

