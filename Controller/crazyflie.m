function params = crazyflie()
% crazyflie: physical parameters for the Crazyflie 2.0
%
% This function returns a struct with the basic parameters for the
% Crazyflie 2.0 quad rotor, used for simulations and control applications.
%
% The Crazyflie 2.0 is modeled with specific physical characteristics:
% - Includes motor, mount, and Vicon markers totaling 30 grams
% - Arm length from center to mass point: 0.046 meters
% - Combined battery pack and main board as a cuboid
%
% The outputs are:
% - mass: Total mass in kilograms
% - I: Moment of inertia matrix (kg*m^2)
% - invI: Inverse of the moment of inertia matrix
% - grav: Gravitational acceleration (m/s^2)
% - arm_length: Length of an arm in meters
% - maxangle: Maximum angle for control commands (radians)
% - maxF: Maximum force output (Newtons)
% - minF: Minimum force output (Newtons)

    % Constants
    m = 0.030;  % Total mass in kg
    g = 9.81;   % Gravitational acceleration in m/s^2
    L = 0.046;  % Arm length in meters
    
    % Inertia tensor in kg*m^2
    I = [1.43e-5, 0,       0;
         0,       1.43e-5, 0;
         0,       0,       2.89e-5];

    % Assigning parameters to output struct
    params = struct(...
        'mass', m, ...
        'I', I, ...
        'invI', inv(I), ...
        'grav', g, ...
        'arm_length', L, ...
        'maxangle', 40*pi/180, ...
        'maxF', 2.5 * m * g, ...
        'minF', 0.05 * m * g);

    % Additional fields can be added to the struct as needed
end
