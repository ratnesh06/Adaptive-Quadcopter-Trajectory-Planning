function [desired_state] = random_trajectory(t, qn)
% RANDOM_TRAJECTORY Generates a smooth random trajectory in the horizontal plane

% Total duration of the trajectory and update interval
T = 60;  % Total time for the trajectory
update_interval = 10;  % Interval at which new waypoints are generated

% Static seed to make the random behavior repeatable for testing
rng(1);

% Define waypoints and time vector only once using persistent variables
persistent waypoints times
if isempty(waypoints)
    num_waypoints = ceil(T / update_interval) + 1;
    times = linspace(0, T, num_waypoints);
    waypoints = [10 * rand(1, num_waypoints); 10 * rand(1, num_waypoints); zeros(1, num_waypoints)];
end

% Calculate the desired state using spline interpolation
pos = interp1(times, waypoints', t, 'spline')';
if t < T
    dt = 0.1;
    future_pos = interp1(times, waypoints', t + dt, 'spline')';
    vel = (future_pos - pos) / dt;
else
    vel = [0; 0; 0];
end

% Set acceleration and yaw values to zero as they are not dynamically calculated here
acc = [0; 0; 0];
yaw = 0;
yawdot = 0;

% Return the desired state structure
desired_state.pos = pos;
desired_state.vel = vel;
desired_state.acc = acc;
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
