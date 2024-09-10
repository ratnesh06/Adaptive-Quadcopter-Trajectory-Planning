% Use this space to pre-compute the trajectory to avoid
% repeatedly computing the same trajectory in every call of the
% "trajectory_generator" function

% Generate trajectory
disp('Generating Trajectory ...');
trajectory_generator([], [], map, path);
