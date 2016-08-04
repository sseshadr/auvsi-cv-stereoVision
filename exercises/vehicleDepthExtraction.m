% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear
clc
%% Load images
% Choose idx'th image
idx = 61;
[IL,IR] = returnStereoImages(idx);

% View the extracted image
figure; 
imshowpair(IL,IR,'montage'); 
title('Extracted Portion of Original Images');

%% Rectify the Images
% Load Stereo Parameters
load stereoParams

% Rectify the images
[JL, JR] = rectifyStereoImages(IL,IR,stereoParams);

%% Generate Disparity Map
disparityRange = [0 64];
disparityMap = disparity(rgb2gray(JL),rgb2gray(JR),'DisparityRange',disparityRange);

% View the disparity map
figure; 
imshow(disparityMap,disparityRange); 
title('Disparity Map'); 
colormap('jet'); 
colorbar;

%% Reconstruct Point Cloud
% Create point cloud
ptCloud = reconstructScene(disparityMap,stereoParams);

% Convert from millimeters to meters.
ptCloud = ptCloud/1000;

% Limit the range of Z and X for display.
thresholds=[-5 5;-5 10;0 30];  
ptCloud = thresholdPC(ptCloud,thresholds);

% View point cloud
figure
pcshow(ptCloud, JL)
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Point Cloud');

%% Extract Image corresponding to the distance 20 to 30 meters
lb = 20;
ub = 30;
Z = ptCloud(:,:, 3);
mask = repmat(Z>lb & Z<ub, [1,1,3]);
KL = JL;
KL(~mask) = 0;

figure; 
imshow(KL); 
title('Distance Thresholded Image')