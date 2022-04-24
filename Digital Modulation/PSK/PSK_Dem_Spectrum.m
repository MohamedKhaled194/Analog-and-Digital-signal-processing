function PSK_Dem_Spectrum(y,Filteredsignal,n)
v = length(y)*100 ;
L= length(Filteredsignal);
f= -n/2:n/v:(n/2)-(n/v);
X = fftshift(fft(Filteredsignal,v));
mag = abs(X);
figure(4);
plot(f,mag/L,'Linewidth',1.5);
xlabel('Frequency');
ylabel('Demodulated Signal After Filtration');
title('Spectrum Of Demodulated Signal After Filtration');
xlim([-4 4]);
ylim([0 0.15]);

end

