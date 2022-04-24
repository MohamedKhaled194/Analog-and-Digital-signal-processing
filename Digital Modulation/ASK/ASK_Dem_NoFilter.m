function s_dem = ASK_Dem_NoFilter(x,t,phi)

at = cos(2 * pi * 100 * t + phi );
s_dem= x .* at;   % Demodulated Signal
figure(5);
plot(t,s_dem,'b');
xlim([0 10]);
title('ASK Demodulated Signal In Time Domain Before Filtration');
ylim([-2 2]);

end

