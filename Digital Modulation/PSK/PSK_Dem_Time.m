function Filteredsignal = PSK_Dem_Time(y,t,n,phi)
ct = cos(2 * pi * 100 * t );
DSB_SC =  y .* ct;
at = cos(2 * pi * 100 * t + phi );
s_dem= DSB_SC .* at;   % Demodulated Signal
Filteredsignal=lowpass(s_dem,50,n);
median = medfilt1(Filteredsignal,100);
figure(3);
plot(t,median,'b-', 'Linewidth',1.5);
xlim([0 10]);
ylim([-1 1]);

xlabel('Time');
ylabel('Demodulated Signal After Filtration');
title('Time Domain Of Demodulated Signal After Filtration');

end

