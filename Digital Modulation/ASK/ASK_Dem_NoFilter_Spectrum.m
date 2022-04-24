function ASK_Dem_NoFilter_Spectrum(s_dem,n)

v = length(s_dem)*100 ;
L= length(s_dem);
f= -n/2:n/v:(n/2)-(n/v);
X = fftshift(fft(s_dem,v));
mag = abs(X);
figure(6);
plot(f,mag/L, 'Linewidth',1.5);
xlabel('Frequency');
ylabel('Demodulated Signal Before Filtration');
title('Spectrum Of Demodulated Signal Before Filtration');

end

