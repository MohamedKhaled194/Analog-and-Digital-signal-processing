function UPNRZ_Spectrum(x,n)
v = length(x)*100 ;
Mf = (fftshift(fft(x,v)));
mag_Mf = abs(Mf) / length(x)  ;
f = -n/2 : n/v : n/2-n/v ;

figure(2);
plot( f , mag_Mf ,'b','Linewidth',1.5 );
title('UPNRZ In Frequency Domain');
xlim([-2 2]);

end

