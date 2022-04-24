function UPNRZ_ASK_TransmitterSpectrum(DSB_SC,n)

v = length(DSB_SC)*100 ;
Sf_DSB_SC = (fftshift(fft(DSB_SC,v)));
mag_Sf_DSB_SC = abs(Sf_DSB_SC) / length(DSB_SC)  ;                                                        
f = -n/2 : n/v : n/2-n/v ;
figure (4);
plot( f , mag_Sf_DSB_SC,'Linewidth',1.5 );
title('UPNRZ DSB-SC in Frequency Domain "Transmitter"');

end