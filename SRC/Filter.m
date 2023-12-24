% Digital Filter
% Author : Zhong-Hsiang Kuo
% Content : Different digital filter implement

clear;
close all;
%% Signal
Fs = 500;                % Sampling Frequency
Ts = 1/Fs;                % Sampling period
Ns = 128;                 % Number of samplings to be plotted
t = [0:Ts:Ts*(Ns-1)];     % Range of time

f1 = 5;                 % Frequency(Hz)
f2 = 15;
f3 = 20;
f4 = 30;

x1 = sin(2*pi*f1*t);      % create sampled sinusoids at different frequencies
x2 = sin(2*pi*f2*t);
x3 = sin(2*pi*f3*t);
x4 = sin(2*pi*f4*t);
signal = x1 + x2;
noise = 0.4*rand(1,Ns) - 0.2;
x = signal + noise;    % Mixture different frequency signals
%% FIR filter 
N = 5;                    % Order of filter
weight = [1/5 1/5 1/5 1/5 1/5];   % Weights

y = FIR_filter(x,N,weight);

figure;
plot(t,signal,'b-*'); hold on
plot(t,x,'r-o');
legend('Signal','Measure')
legend boxoff
figure;
plot(t,signal,'b-*'); hold on
plot(t(N:end),y,'r-o');
legend('Signal','Filter')
legend boxoff

%% IIR Filter
N = 256;
w = 0:(pi/(N-1)):pi;   % chosse 256 points between 0 and pi
alpha = 0.767326;
const = (1 + alpha)/2;
H = const.*((1 - exp(-1i*w))./(1 - (alpha.*exp(-1i*w))));
figure;
subplot(2,1,1)
plot(w,abs(H),'LineWidth',1.2); grid on
title('Magnitude |H(e^{j\omega})|')
xlabel('\omega, Hz');
ylabel('Amplitude');
subplot(2,1,2)
plot(w,angle(H),'LineWidth',1.2); grid on
title('Phase arg[H(e^{j\omega})]')
xlabel('\omega');
ylabel('Phase, Hz')

function y = FIR_filter(x, N, w)
    y = zeros(1, length(x)-N);
    for i = N:length(x)
        y(i-N+1) = x(i-N+1:i)*w';
    end
end