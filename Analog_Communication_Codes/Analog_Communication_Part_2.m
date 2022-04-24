%% Functions
 
Ts = 1/1000;
t = 0:Ts:3-Ts;                     
fs = 1/Ts;
 
 
x = cos(2*pi*9.*t);
 
plot(t,x,'linewidth',2)
xlim([-0.5 3.5])
ylim([-1.5 1.5])
title('Message in Time Domain');
xlabel('Time (Seconds)')
ylabel('Magnitude')
legend('Messsage')
f = -12:0.001:12;
FT = abs(3/2*((sinc(3.*(f-9)))+(sinc(3.*(f+9)))));
 
syms t omega;
x = cos(2*pi*9*t);
y = rectangularPulse(0,3,t);
x = x*y;
 
z = fourier(x,omega);
 
syms freq 
freq = omega/(2*pi);
 
%% BW
for i = 1:length(FT)
    if 0.0095 * max(FT)<= FT(i)& FT(i) <= 0.0105 * max(FT) & f(i)>9 & f(i)<9.5
        BW = f(i);
        y = FT(i);
        x = i;
    end
end
 
figure(2)
plot(f,FT,'r','linewidth',3.5)
hold on
fplot(freq,abs(z),[-2*pi*12 2*pi*12],'black','linewidth',1)
ylim([0 1.6])
xlim([-12 12])
xticks (-12:3:12)
title('Message in Frequency Domain');
xlabel('Frequency (Hz)')
ylabel('Magnitude')
legend('Analytical FT','FT Using Sampling')
 
figure(3)
plot(f,FT,'b','linewidth',1.5)
hold on
plot(f(x),FT(x),'-mo','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',6)
xline (BW,'black','linewidth',2);
ylim([0 1.6])
xlim([-12 12])
xticks (-12:3:12)
legend('Frequency Response','1% of Max Amplitude','BW Limit')
 
title('Message in Frequency Domain & its BW');
xlabel('Frequency (Hz)')
ylabel('Magnitude')
 
%% Part 7
fm = 9;
fc = 50;
Min_Tao = 1/fm;                 % Lower limit for tao
Max_Tao = 1/fc;                 % Higher limit for tao
ka = 0.4;
 
Tao = (Min_Tao + Max_Tao)/30;    % By experimentation, best tao is skewed towards the lower limit
 
Tm = 1/10000;
t = 0:Ts:3-Ts;                     
fs = 1/Ts;
 
Message = cos(2*pi*fm*t);
Envelope  =  1 + ka * Message;
ct = cos(2*pi*fc*t);
Modulated_Signal =  Envelope .* ct;
 
Detector_Output(1,1)=1+ka;
number_of_points = length(t);
 
for n = 1 : number_of_points - 1
    if Detector_Output(1,n) < Modulated_Signal(1,n)
        Detector_Output(1,n+1) = Modulated_Signal(1,n);
    else
        Detector_Output(1,n+1) = Detector_Output(1,n)*exp(-Tm/Tao);
    end
end
 
% The previous code starTm by giving the envelope output the same value of
% the modulating signal, then it starTm looping for the number of poinTm
% that was specified earlier. At each loop, the code checks whether the
% detector output signal is smaller than the modulated signal. If so, the
% detector output charges to the value of the modulated signal, and if not,
% it decays exponentially (RC-circuit behaviour) till it falls slightly
% below the modulated signal and the cycle repeats.
 
%% DSB
v = length(Message)*100;
DSB_SC =  Message .* ct;

        %%%%% DSB_SC Spectrum %%%%%

Sf_DSB_SC = (fftshift(fft(DSB_SC,v)));
mag_Sf_DSB_SC = abs(Sf_DSB_SC) / fs  ;                                                        
f = -fs/2 : fs/v : fs/2-fs/v ;
 
figure (4);
plot( f , mag_Sf_DSB_SC,'b','Linewidth',1.5 );
title( ' Spectrum of Modualeted Signal S(f) - " DSB-SC " ' );
xlim([-70 70]);
legend('DSB-SC-Spectrum');
 
st = DSB_SC;

        %%%%% DSB_SC Spectrum %%%%%
Sf_DSB_SC = (fftshift(fft(DSB_SC,v)));
mag_Sf_DSB_SC = abs(Sf_DSB_SC) / fs  ;                                                        
f = -fs/2 : fs/v : fs/2-fs/v ;
y =0.01*max(mag_Sf_DSB_SC);     %%%%%%line to estimate the band width
figure (5);
plot( f , mag_Sf_DSB_SC,'r','Linewidth',1.5 );
hold on;
 
for i = 1:length(mag_Sf_DSB_SC)
    if 0.0095 * max(mag_Sf_DSB_SC)<= mag_Sf_DSB_SC(i)& mag_Sf_DSB_SC(i) <= 0.0105 * max(mag_Sf_DSB_SC) & f(i)>59 & f(i)<59.335
        BW = f(i);
        y = mag_Sf_DSB_SC(i);
        x = i;
    end
end
 
xline(BW,'black','linewidth',2);
hold off;
title( ' BandWidth  " DSB-SC " ' );
xlim([40 70]);
legend('DSB-SC-Spectrum','BW');
 
st_dem = DSB_SC .* ct;   % Demodulated Signal
Filteredsignal=lowpass(st_dem,20,fs);
%Time Domain Of Filtered Signal Compared To Original Signal
figure(6);
plot(t,2*Filteredsignal,'r','Linewidth',3.5);
hold on;
plot(t,Message,'black','Linewidth',1);
hold off;
xlabel('Time');
ylabel('Amlitude');
title('Demodulated Signal After Filtration In DSB & Original Signal In Time Domain');
legend('Demodulated Signal','Original Signal');
 
%% SSB
c1 = cos(2*pi*50*t);                                         % carrier
c2 = sin(2*pi*50*t);  
v = length(Message)*100;
a = Message.*c1;                                                             
b = imag(hilbert(Message)).*c2; 
st = a-b;                                    %modulated signal of the transmitter  
                        %FT of the modulated signal
Sf_USB=fftshift(fft(st,v)); 
mag_Sf_USB = abs(Sf_USB)/fs  ; 
f = -fs/2 : fs/v : fs/2-fs/v ; 
figure(7);
plot(f,mag_Sf_USB, 'Linewidth',1.5);                                                    
xlabel("frequency")
ylabel("|S(f)|")
title("FT of the modulated signal - 'USB' ")
xlim([-70 70]);
 
for i = 1:length(mag_Sf_USB)
    if 0.0095 * max(mag_Sf_USB)<= mag_Sf_USB(i)& mag_Sf_USB(i) <= 0.0105 * max(mag_Sf_USB) & f(i)>59 & f(i)<59.335
        BW = f(i);
        y = mag_Sf_DSB_SC(i);
        x = i;
    end
end
 
figure(8);
plot(f,mag_Sf_USB,'r', 'Linewidth',1.5); 
hold on;
xline(BW,'black','linewidth',2);
title("BW of the modulated signal - 'USB' ")
xlim([40 70]);
legend('USB-Spectrum','BW');
 
c1 = 2*cos(50*2*pi*t); 
z = st.*c1;                                                        %demodulation of s(t)
x = lowpass(z,20,fs);     
                                    
figure(9);                                                                 
plot(t,x,'r','Linewidth',3.5);                                      
hold on ;
plot(t,Message,'black','Linewidth',1);
hold off;

xlabel("time");
ylabel("m(t) & x(t)");
title('Demodulated Signal After Filtration In USB & Original Signal In Time Domain');
legend('Demodulated Signal','Original Signal');
 
%% PLOTS
% Modulated Signal 
figure (10)
plot(t,Modulated_Signal,'b','linewidth',0.8);
hold on 

% Ideally Expected Envelope
plot(t, Envelope,'g','linewidth',1.5)
hold on
plot(t, -Envelope,'g','linewidth',1.5)
 
% Envelope Detector Output
% plot(t,Detector_Output-1,'r','linewidth',1.5);
% Graph Appearance
 
ylim([-1/2-(1+ka) 1/2+(1+ka)])
title('Demodulated Signal & Original Message')
legend('Original Message','Demodulated Signal')
xlabel('Time(s)');ylabel('Amplitude');
%% Fourier Transform
syms t freq 
freq = omega/(2*pi);
 
x = cos(2*pi*fm*t);
y = rectangularPulse(0,3,t);
x = x*y;
 
Envelope  =  (1 + ka * x);
ct = cos(2*pi*fc*t);
ct = ct * y;
Modulated_Signal =  Envelope * ct;
 
z = fourier(Modulated_Signal ,omega);

figure(11)
fplot(freq,abs(z),[-2*pi*70 2*pi*70],'black','linewidth',1)
xticks([-70 -59 -50 -41 -30 -20 -10 0 10 20 30 41 50 59 70])
title('The frequency spectrum of the AM modulated signal for ka = 0.4')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
 
syms t omega;
x = cos(2*pi*9*t);
y = rectangularPulse(0,3,t);
x = x*y;
 
z = fourier(x,omega);
 
syms freq 
freq = omega/(2*pi);
 
figure(12)
fplot(freq,abs(z),[-2*pi*70 2*pi*70],'black','linewidth',3)
hold on
 
z = fft(Detector_Output);
n = length(Detector_Output);        
fshift = (-n/2:n/2-1)*(fs/n);
yshift = fftshift(z);
Freq_response = 0.005*abs(yshift);
plot(fshift,Freq_response,'r','linewidth',1)
xlim([-70 70])
ylim([0 2])
xticks([-70 -59 -50 -41 -30 -20 -9 0 9 20 30 41 50 59 70])
title('The Frequency Spectrum of the Detector Output')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
legend('Original Message','Demodulated Message')
