function [desired_state] = zigzag(t, qn)
% ZIGZAG trajectory generator for a zigzag in the horizontal plane
% This function creates a zigzag trajectory along the x-y plane, moving
% linearly in sharp turns at specified intervals.

% Define total time for one complete cycle and segments within the cycle
T = 12;  % Total time for a complete cycle
segment_time = T / 6;  % Time to complete each segment of the zigzag

% Define key points for zigzag corners in [x; y; z]
% Pattern moves in x and y while maintaining constant z
points = [0, 1, 2, 3, 4, 5, 6; 0, 1, 0, 1, 0, 1, 0; 0, 0, 0, 0, 0, 0, 0];  % Points defining the zigzag

% Initialize variables for position, velocity, and acceleration
pos = [0; 0; 0];
vel = [0; 0; 0];
acc = [0; 0; 0];
yaw = 0;
yawdot = 0;

% Calculate position, velocity based on current time
if t < T
    % Determine current segment based on time
    segment = floor(t / segment_time) + 1;
    factor = (t - (segment - 1) * segment_time) / segment_time;

    % Linear interpolation for position
    current_point = points(:, segment);
    next_point = points(:, segment + 1);  % Assumes looping in a closed cycle
    pos = current_point * (1 - factor) + next_point * factor;

    % Velocity calculation
    vel = (next_point - current_point) / segment_time;
else
    % Ensure the trajectory holds position after completing the loop
    pos = points(:, end);
end

% Set the desired state
desired_state.pos = pos;
desired_state.vel = vel;
desired_state.acc = acc;
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
