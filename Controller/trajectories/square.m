function [desired_state] = square(t, qn)
% SQUARE trajectory generator for a square in the vertical plane
% This function creates a trajectory that forms a square path vertically.

% Define time intervals and total cycle time
T = 12;  % Total time for a complete loop
side_time = T / 4;  % Time to complete each side of the square

% Define key points for square corners in [x; y; z]
% The square will rise and fall in the z-plane while moving horizontally in the x-plane
points = [0, 0, 1, 1; 0, 0, 0, 0; 0, 1, 1, 0];  % Four corners along the x-z plane

% Initialize variables
pos = [0; 0; 0];
vel = [0; 0; 0];
acc = [0; 0; 0];
yaw = 0;
yawdot = 0;

% Calculate position, velocity based on current time
if t < T
    % Determine current segment based on time
    segment = floor(t / side_time) + 1;
    factor = (t - (segment - 1) * side_time) / side_time;

    % Linear interpolation for position
    current_point = points(:, segment);
    next_point = points(:, mod(segment, 4) + 1);  % Wrap around using mod
    pos = current_point * (1 - factor) + next_point * factor;

    % Velocity calculation
    vel = (next_point - current_point) / side_time;
else
    % Ensure the trajectory holds position after completing the loop
    pos = points(:, 1);
end

% Set the desired state
desired_state.pos = pos;
desired_state.vel = vel;
desired_state.acc = acc;
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
