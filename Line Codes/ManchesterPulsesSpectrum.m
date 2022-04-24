function ManchesterPulsesSpectrum(x,n)
v = length(x)*100 ;
xf = (fftshift(fft(x,v)));
mag_xf = abs(xf) / length(x)  ;
f = -n/2 : n/v : n/2-n/v ;

figure(2);
plot( f , mag_xf ,'b','Linewidth',1.5 );
title('Manchester line code in frequency domain');
xlim([-4 4]);
end

