%% Danny Hong ECE 211 HW 8 
clc;
clear;
close all;
%% 2.)

p = [1, 0.2, 0.8];
z = [1, 0.5, 0.4];
zplane(z, p);
title("The Zeros and Poles of H");
%It's confirmed that H is minimum phase since all zeros and poles lie
%inside the unit circle.
%% 3.)

%a.)
v = randn(1, 10000);
x = filter(z, p, v);

%b.)
r = zeros(1, 6);
for m = 0:5
    for n = 1:10000-m
    r(m+1) = dot(x(n+m),x(n))+ r(m+1);
    end
    rx = r/(10000-m);
end

fprintf('\n3b) rx(m) = [%f, %f, %f, %f, %f, %f]\n', rx);

%c.)
r1 = zeros(1,11);
for m = -5 : 5
    for n = 1 : 10000 - abs(m)
    r1(m + 6) = dot(x(n + abs(m)),x(n))+ r1(m + 6);
    end
    rx1 = r1/(10000 - abs(m));
end

t = -5 : 5;
figure;
stem(t, rx1);
xticklabels(["-5", "-4", "-3", "-2", "-1", "0", "1", "2", "3", "4", "5"]);
title("rx(m)");
ylabel("rx");
xlabel("m");

%d.)
R = toeplitz(rx);
fprintf('\n3d) For M = 6, R = \t%f\t%f\t%f\t%f\t%f\t%f\n\t\t\t%f\t%f\t%f\t%f\t%f\t%f\n\t\t\t%f\t%f\t%f\t%f\t%f\t%f\n\t\t\t%f\t%f\t%f\t%f\t%f\t%f\n\t\t\t%f\t%f\t%f\t%f\t%f\t%f\n\t\t\t%f\t%f\t%f\t%f\t%f\t%f\n', R);

%e.)
Eigenvalues = eig(R);
fprintf('\n3e) Eigenvalues of R are \t%f\t%f\t%f\n\t\t\t\t%f\t%f\t%f\n', Eigenvalues);
%% 4.)

%a.)
[s_est, w] = pwelch(x, hamming(512), 256, 512);
figure;
plot (w, s_est);
title("Power Spectral Density with respect to \omega");
xlabel('\omega');
ylabel('PSD');

%b.)
[max, position] = max(s_est);
w0 = w(position);
fprintf('\n4b) w0 = %f\n', w0);

%c.)
[z1, p1, k] = tf2zp(z, p);
Pole_Angle = angle(p1);
fprintf('\n4c) The Pole Angles are %f and %f\n', Pole_Angle(1), Pole_Angle(2));