function PNRZ_PulsesSpectrum(x,n)
v = length(x)*100 ;
xf = (fftshift(fft(x,v)));
mag_xf = abs(xf) / length(x)  ;
f = -n/2 : n/v : n/2-n/v ;

figure(5);
plot( f , mag_xf ,'b','Linewidth',1.5 );
title('PNRA line code in frequency domain');
xlim([-4 4]);

end

