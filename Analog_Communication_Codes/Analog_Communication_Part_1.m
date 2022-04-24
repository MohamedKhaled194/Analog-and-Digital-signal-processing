Ts = 1/10;
t = -50:Ts:50-Ts;                     
fs = 1/Ts;
 
x = 2*tripuls(t,4);
figure(1)
plot(t, x, 'b','linewidth',2);
title({'';'Triangular Pulse in Time Domain'});
xlim ([-5,5]);
ylim ([0,2.5]);
xlabel('Time (Seconds)')
ylabel('Magnitude')
 
y = fft(x);
n = length(x);        
fshift = (-n/2:n/2-1)*(fs/n);
yshift = fftshift(y);
figure(2)
plot(fshift,0.1*abs(yshift),'r','linewidth',5)
Freq_response = abs(yshift);
hold on
syms m;
fplot(4*(sin(2*pi*m)/(2*pi*m))^2,'black','linewidth',1)
ylim ([-0.5,4.5]);
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Triangular Pulse in Frequency Domain');
legend('FT Using Sampling','Analytical FT')
 
figure(3)
power_spectrum = ((0.1*abs(yshift)).^2/n);
 
for i = 1:length(power_spectrum)
    if 0.045 * max(power_spectrum)<= power_spectrum(i)& power_spectrum(i) <= 0.055 * max(power_spectrum) & fshift(i)>0
        BW = fshift(i);
        y = (power_spectrum(i));
    end
end
 
plot(fshift,power_spectrum,'linewidth',2)
hold on
 
yline(y,'r','linewidth',2);
xline(BW,'r','linewidth',2);
xline(-BW,'r','linewidth',2);
title('Power Spectral Density for Triangular Pulse');
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([-1 1])
legend('Power Spectral Density','Bandwidth Limits (0.31Hz)')
 
%% Filter
 
Filter1 = rectpuls(fshift,2);

figure(4)
plot(fshift,Filter1,'linewidth',2)
hold on
Filtered_signal = 0.1*Freq_response.*Filter1;
plot(fshift,0.1*Freq_response,'red','linewidth',4)
plot(fshift,Filtered_signal,'black','linewidth',1)
xlim ([-2.5,2.5]);
title('Filtering Triangular Pulse Spectrum Using Filter (BW = 1Hz)');
legend('Filter Response','Original Signal','Filtered Signal')
 
z = ifft(Filtered_signal);
k = length(Filtered_signal);        
fshift1 = (-k/2:k/2-1)*(fs/k);
yshift1 = ifftshift(z);
 
figure(5)
plot(t, x, 'r','linewidth',5)
hold on
plot(t,10*abs(yshift1),'black','linewidth',2)
xlim ([-2.5,2.5]);
title('Original Triangular Pulse VS Filtered Triangular Pulse (BW = 1Hz)');
legend('Original Signal','Filtered Signal')
 
Filter2 = rectpuls(fshift,0.6);
 
figure(6)
Filtered_signal_2 = 0.1*Freq_response.*Filter2;
plot(fshift,Filter2,'linewidth',2)
hold on
plot(fshift,0.1*Freq_response,'red','linewidth',4)
plot(fshift,Filtered_signal_2,'black','linewidth',1)
xlim ([-2.5,2.5]);
title('Filtering Triangular Pulse Spectrum Using Filter (BW = 0.3Hz)');
legend('Filter Response','Original Signal','Filtered Signal')
 
z = ifft(Filtered_signal_2);
k = length(Filtered_signal_2);        
yshift1 = ifftshift(z);
 
figure(7)
plot(t, x, 'black','linewidth',2)
hold on
plot(t,10*abs(yshift1),'linewidth',2)
xlim ([-2.5,2.5]);
title('Original Triangular pulse VS Filtered Triangular Pulse (BW = 0.3Hz)');
legend('Original Signal','Filtered Signal')
 
%% Convolution
 
Ts = 1/10;
t = -50:Ts:50-Ts;         
 
x = 2*tripuls(t,4);
y = fft(x);
Freq_response = abs(yshift);
            
Filter3 = rectpuls(t,2);
figure(8)
title('Original Triangular pulse VS Filtered Triangular Pulse');
plot(t,x,'black','linewidth',4)
hold on
convo = conv(x,Filter3,'same');
plot(t,0.05*convo,'blue','linewidth',4)
 
%% Multiply by filter response
 
yshift = fftshift(y);
y = fft(Filter3);
n = length(Filter3);        
fshift = (-n/2:n/2-1)*(fs/n);
yshift = fftshift(y);
Freq_response_2 = abs(yshift);
Filtered_signal_3 = 0.1*Freq_response.*Freq_response_2;
 
z = ifft(Filtered_signal_3);
k = length(Filtered_signal_3);        
yshift1 = ifftshift(z);
plot(t,0.5*abs(yshift1),'r','linewidth',2)
xlim ([-4,4]);
title('Original Signal, Convolution Output and Multiplying by Filter Response');
legend('Original Signal','Convolution','Multiplying by Filter Response')
 
%% Analytical
 
figure(9)
 
a = -3:0.01:-1;
b = -1:0.01:1;
c = 1:0.01:3;
 
z = (a.^2/2 + 3.*a + 4.5);     % Analytical Expression
x = (-b.^2 + 3);               % Analytical Expression
y = (c.^2/2 - 3.*c + 4.5);     % Analytical Expression
 
plot(t,0.1*convo,'red','linewidth',4)
hold on
plot(a,z,'b','linewidth',2)
plot(b,x,'b','linewidth',2)
plot(c,y,'b','linewidth',2)
title('Convolution Output VS Analytical Solution');
xlim([-5 5]);
legend('Convolution Output','Analytical Solution')
