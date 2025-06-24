% Phasor Diagram for Synchronous Motor
% This script plots the phasor diagram of a synchronous motor to analyze
% the effect of excitation (under-excited, over-excited, unity power factor)
% on terminal voltage (V), back EMF (Eb), resultant voltage (Er), and
% armature current (Ia).
% Inputs: V, Eb, angle_eb, Ra, Xl, Xa
% Output: Phasor diagram with labeled vectors
clc;
clear;
% %let us suppose v is at 90 degree
angle_V=90;
try
    V = input('Enter the magnitude of supplied voltage to motor (V): ');
    if ~isnumeric(V) || V <= 0
        error('Voltage must be a positive number.');
    end
    Eb = input('Enter the magnitude of back EMF (V): ');
    if ~isnumeric(Eb) || Eb < 0
        error('Back EMF must be non-negative.');
    end
    angle_eb = input('enter the angle of back emf(degree) ');

    Ra = input('Enter the armature resistance (ohms): ');
    if ~isnumeric(Ra) || Ra < 0
        error('Resistance must be non-negative.');
    end
    Xl = input('Enter the leakage reactance (ohms): ');
    if ~isnumeric(Xl) || Xl < 0
        error('Leakage reactance must be non-negative.');
    end
    Xa = input('Enter the armature reactance (ohms): ');
    if ~isnumeric(Xa) || Xa < 0
        error('Armature reactance must be non-negative.');
    end
catch e
    fprintf('Error: %s\n', e.message);
    return;
end
Xs=Xl+Xa;%synchronous reactance
theta=atand(Xs/Ra); %angle of ia with v
%plotting v in polar form
V_complex = V * exp(1j * deg2rad(angle_V));
%calculating power factor
power_factor=cosd(theta);
epsilon = 1e-3;%took for float conversion
if Eb < V-epsilon
    condition = 'Under-excited (Inductive)';
    %Eb is 90 oppostie to V if lossless system.But in real it is deflected
    %by some degree from lossless system.Thats why we took alpha 
    alpha=19;


elseif Eb > V+epsilon
    condition = 'Over-excited (Capacitive)';
    alpha=39;
        
else
    condition = 'Unit power factor (Resistive)';
    alpha = 30;
end
%calculating the angle of eb used in graph assuming V is in 90 degree
EB_ANGLE=angle_V+180-alpha;
%original Eb from what we calculated
EB_complex = Eb * exp(1j * deg2rad(angle_eb));
%the Eb used in the plot
Eb_complex_plot= Eb * exp(1j * deg2rad(EB_ANGLE));
Resultant = V_complex - EB_complex;
Resultant_a = abs(Resultant);                 % Magnitude of resultant
Angle_resultant_used = rad2deg(angle(Resultant)); % Angle in degrees


if Eb < V-epsilon
    Angle_resultant_new=90+Angle_resultant_used;

elseif Eb > V+epsilon 
    Angle_resultant_new=270-Angle_resultant_used;

else
    Angle_resultant_new=180

end

Resultant=Resultant_a*exp(1j*deg2rad(Angle_resultant_new));
Ia = (V_complex - EB_complex) / (Ra + 1j*Xs);
% Ia lags behind resultant by 90 degree
Ia_angle_deg = rad2deg(angle(Resultant)) - 90;  % angle in degrees
Ia_magnitude = abs(Ia);  % keep the same magnitude
Ia_rotated = Ia_magnitude * exp(1j * deg2rad(Ia_angle_deg));
%Extract real and imaginary parts
u = [real(V_complex), real(Eb_complex_plot),real(Resultant),real(Ia_rotated)];
v = [imag(V_complex), imag(Eb_complex_plot),imag(Resultant),imag(Ia_rotated)];

%Plotting the phasor diagram
figure;
hold on;
grid on;
axis equal;

% Plot V phasor
%for voltage
quiver(0, 0, u(1), v(1), 0, 'b', 'LineWidth', 2);
text(u(1)*1.05, v(1)*1.05, 'V', 'FontSize', 12, 'Color', 'b');

%for back emf
quiver(0,0,u(2),v(2),'r','lineWidth',2);
text(u(2)*1.05,v(2)*1.05,'Eb','FontSize',12,'Color','r');

%for resultant
quiver(0,0,u(3),v(3),'g','lineWidth',2);
text(u(3)*1.05,v(3)*1.05,'Er','FontSize',12,'Color','g');

%for Armature current
quiver(0,0,u(4),v(4),'Color', [0.5 0 0.5],'lineWidth',2);
text(u(4)*1.05, v(4)*1.05, 'Ia', 'FontSize', 12, 'Color', [0.5 0 0.5]);

xlabel('Real Axis');
ylabel('Imaginary Axis');
if Eb < V
    title("Under Excited(Inductive)");
elseif Eb > V
    title('Over-excited (Capacitive)');

else
    title( 'power factor=1(Resistive)');

end
legend('V (Terminal Voltage)', 'Eb (Back EMF)', 'Er = resultant of V and Eb', 'Ia (Armature Current)', ...
        'Location', 'bestoutside');

max_range = max(abs([u, v])) * 1.2;
xlim([-max_range, max_range]);
ylim([-max_range, max_range]);