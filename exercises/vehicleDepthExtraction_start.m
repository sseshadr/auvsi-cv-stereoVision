% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear
clc
%% Load images
idx = 61;
[IL,IR] = returnStereoImages(idx);

% View the extracted image
figure; 
imshowpair(IL,IR,'montage'); 
title('Extracted Portion of Original Images');

%% Rectify the Images
% Load Stereo Parameters


% Rectify the images


%% Generate Disparity Map


% View the disparity map


%% Reconstruct Point Cloud
% Create point cloud


% Convert from millimeters to meters.


% Limit the range of Z and X for display.


% View point cloud


%% Extract Image corresponding to the distance 20 to 30 meters
