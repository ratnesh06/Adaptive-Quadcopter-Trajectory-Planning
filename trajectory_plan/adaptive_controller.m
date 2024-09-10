function [F, M, trpy, drpy] = controller(qd, t, qn, params)
% CONTROLLER quadrotor controller
% This function computes control outputs for a quadrotor given its state
% and desired state, along with vehicle parameters.

% Extract necessary parameters
g = params.grav;
m = params.mass;
I = params.I;

% Proportional and derivative gains for position and attitude control
kp = [7, 7, 58];
kd = [4.3, 4.3, 18];
kpt = [2500, 2500, 20];
kdt = [300, 300, 7.55];

% Desired acceleration
acc_des = qd{qn}.acc_des - diag(kd)*(qd{qn}.vel - qd{qn}.vel_des) - diag(kp)*(qd{qn}.pos - qd{qn}.pos_des);

% Desired angles (roll, pitch) calculated to achieve desired acceleration
phi_des   = (sin(qd{qn}.yaw_des)*acc_des(1) - cos(qd{qn}.yaw_des)*acc_des(2)) / g;
theta_des = (cos(qd{qn}.yaw_des)*acc_des(1) + sin(qd{qn}.yaw_des)*acc_des(2)) / g;
psi_des   = qd{qn}.yaw_des;

% Control input u for thrust and torques
u = zeros(4,1);
u(1) = acc_des(3)*m + m*g;  % Total thrust

% Angular error and angular velocity error
ang_error = angdiff([phi_des; theta_des; psi_des], qd{qn}.euler);
ang_vel_error = qd{qn}.omega - [0; 0; qd{qn}.yawdot_des];

% Torque calculation
u(2:4) = I * (-diag(kpt) * ang_error - diag(kdt) * ang_vel_error);

% Output assignment
F = u(1);
M = u(2:4);
trpy = [F, phi_des, theta_des, psi_des];
drpy = [0, 0, 0, 0];

end

% Additional helper functions (if needed) should be included here or in separate files.
