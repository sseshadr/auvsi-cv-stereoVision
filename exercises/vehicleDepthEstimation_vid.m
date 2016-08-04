% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear
clc
%% Initialize variables
% Number of stereo images in the source
nimages = 181; 

% Load stereo parameters
load stereoParams

% Set range for disparity and point cloud
disparityRange = [0 64];
thresholds=[-5 5;-5 10;0 30]; 

% Create DeployableVideoPlayer for visualization
VP = vision.DeployableVideoPlayer;

%% Loop algorithm

for frameIdx = 1:nimages

    %% Load stereo images
    [IL,IR] = returnStereoImages(frameIdx);

    %% Rectify the Images
    [JL,JR] = rectifyStereoImages(IL,IR,stereoParams);

    %% Generate Disparity Map
    disparityMap = disparity(rgb2gray(JL),rgb2gray(JR),'DisparityRange',disparityRange);

    %% Reconstruct Point Cloud
    ptCloud = reconstructScene(disparityMap,stereoParams);

    %% Convert from millimeters to meters.
    ptCloud = ptCloud/1000;

    %% Limit the range of Z and X for display.
    ptCloud = thresholdPC(ptCloud,thresholds);

    %% Identify the depth of the vehicle in front
    COD = vision.CascadeObjectDetector('CarDetector.xml');
    bboxes = step(COD,JL);

    %% Extract a roi from z layer of point cloud
    x1 = bboxes(:,1);
    x2 = bboxes(:,1)+bboxes(:,3);
    y1 = bboxes(:,2);
    y2 = bboxes(:,2)+bboxes(:,4);
    ptCloudZRoi = ptCloud(y1:y2,x1:x2,3);

    %% Calculate the average z value or distance
    distance = mean(ptCloudZRoi(:),'omitnan');
    
    %% Overlay the average distance onto the image
    frame = insertObjectAnnotation(JL,'rectangle',bboxes,num2str(distance));
    
    %% Update video player
    step(VP,frame)
    
end

%% Clean up
release(VP)