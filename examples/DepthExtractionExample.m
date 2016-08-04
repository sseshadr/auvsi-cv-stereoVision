% Copyright 2015-2016 The MathWorks, Inc.
%% Section to Rectify Images

% Load stereoParameters
load stereoParameters

% Read in the stereo pair of images.
InL = imread('sceneLeft.jpg');
InR = imread('sceneRight.jpg');

% Display the images before rectification
subplot(2,1,1)
imshowpair(InL, InR)
title('Unrectified Images')

% Rectify images
[OutL, OutR] = rectifyStereoImages(InL, InR, stereoParams);

% Display the images after rectification.
subplot(2,1,2)
imshowpair(OutL, OutR)
title('Rectified Images')

%% Section to Generate Disparity Map 

% Generate disparity map
disparityMap = disparity(rgb2gray(OutL),rgb2gray(OutR));

% Visualize the disparity map
figure
imshow(disparityMap)
title('Disparity Map')

% Make adjustments
figure
imshow(disparityMap,[0 64])
title('Disparity Map with modified image contrast')

% Add some color by changing the color map
colormap jet

% Add a colorbar to get some perspective
colorbar

%% Section to Generate Disparity Map with unrectified images

% Generate disparity map
disparityMapUnrectified = disparity(rgb2gray(InL),rgb2gray(InR));

% Visualize the disparity map
figure
imshow(disparityMapUnrectified)
title('Disparity Map')

% Make adjustments
figure
imshow(disparityMapUnrectified,[0 64])
title('Disparity Map with modified image contrast')

% Add some color by changing the color map
colormap jet

% Add a colorbar to get some perspective
colorbar
%% Section to Reconstruct Scene

% Generate point cloud
ptCloud = reconstructScene(disparityMap, stereoParams);

% Display point cloud
pcshow(ptCloud)
xlabel('x')
ylabel('y')
zlabel('z')

% Threshold point cloud to remove noise
th = [-5000 5000;-2000 2000;0 10000];
ptCloud = thresholdPC(ptCloud,th);

% View point cloud after thresholding
pcshow(ptCloud,OutL)
xlabel('x')
ylabel('y')
zlabel('z')
%% Extract the lady from the image based on depth range

% create mask 
z = ptCloud(:,:,3);
zlow = 3200;
zhigh = 3700;
idx = z > zlow & z < zhigh;

% visualize mask 
figure
imshow(idx)
title('Binary Mask')

% apply mask
mask = repmat(idx,[1 1 3]);
I = OutL;
I(~mask) = 0;

% visualize final image
figure
imshow(I)
title('Extraction based on depth')