function y= PNRZ_Time(bits,t,n)
y = zeros(1,length(t));
for i = 0:length(bits)-1
  if bits(i+1) == 1
    y(i*n+1:(i+1)*n) = 1;
  else
    y(i*n+1:(i+1)*n) = -1;
  end
end
figure (1);
plot(t, y, 'Linewidth', 2);
title('Polar non return to zero');
xlim([0 10]);
ylim([-1.5 1.5]);

end

