function PNRZ_Spectrum(y,n)
v = length(y)*100 ;
Mf = (fftshift(fft(y,v)));
mag_Mf = abs(Mf) / length(y)  ;
f = -n/2 : n/v : n/2-n/v ;

figure(2);
plot( f , mag_Mf ,'b','Linewidth',1.5 );
xlim([-4 4]);
end

