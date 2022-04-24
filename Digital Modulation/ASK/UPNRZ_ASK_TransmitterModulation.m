function DSB_SC = UPNRZ_ASK_TransmitterModulation(x,t)

ct = cos(2 * pi * 100 * t );
DSB_SC =  x .* ct;
figure (3);
plot( t , DSB_SC,'Linewidth',1.5);
xlim([0 10]);
ylim([-2 2]);
title('UPNRZ DSB-SC in Time Domain "Transmitter"');

end

