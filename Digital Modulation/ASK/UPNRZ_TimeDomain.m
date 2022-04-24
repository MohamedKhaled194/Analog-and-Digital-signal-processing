function x = UPNRZ_TimeDomain(bits,t,n)
x = zeros(1,length(t));
for i = 0:length(bits)-1
  if bits(i+1) == 1     
    x(i*n+1:(i+1)*n) = 1;  
  else
    x(i*n+1:(i+1)*n) =0; 
  end
end
figure (1);
plot(t, x , 'Linewidth', 1.5);
title('UPNRZ In Time Domain');
xlim([0 10]);
ylim([-0.5 1.5]);
end

