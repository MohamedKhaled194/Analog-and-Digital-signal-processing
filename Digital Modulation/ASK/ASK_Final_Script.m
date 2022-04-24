bits = randi([0 1],1,100);
phi = input('please enter the phase shift in the detector ');
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
UP_Time = UPNRZ_TimeDomain(bits,t,n);
UPNRZ_Spectrum(UP_Time,n);
UP_Time_DSB_SC = UPNRZ_ASK_TransmitterModulation(UP_Time,t);
UPNRZ_ASK_TransmitterSpectrum(UP_Time_DSB_SC,n);
UP_Time_Dem_NoFilter = ASK_Dem_NoFilter(UP_Time_DSB_SC,t,phi);
ASK_Dem_NoFilter_Spectrum(UP_Time_Dem_NoFilter,n);
UP_Time_Dem_AfterFilter = ASK_Received_WithFilter(UP_Time_Dem_NoFilter,t,n);
ASK_Received_WithFilter_Spectrum(UP_Time_Dem_AfterFilter,n);

