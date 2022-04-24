function median = ASK_Received_WithFilter(s_dem,t,n)

Filteredsignal=lowpass(s_dem,50,n);
median = medfilt1(Filteredsignal,100);


figure(7);
plot(t,median,'b', 'Linewidth',1.5);
xlim([0 10]);
ylim([-0.5 1]);


title('Time Domain Of Demodulated Signal After Filtration');
end

