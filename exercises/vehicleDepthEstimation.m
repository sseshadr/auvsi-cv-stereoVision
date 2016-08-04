% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear
clc
%% Vehicle Depth Extraction
vehicleDepthExtraction;
close all

%% Identify the depth of the vehicle in front
% Show rectified image which corresponds to the point cloud
figure
imshow(JL)
COD = vision.CascadeObjectDetector('CarDetector.xml','UseROI',true);
[nr,nc,~] = size(JL);
xleft = 380;
yupper = 160;
roi = [xleft yupper nc-2*xleft nr-yupper+1];
frame = insertObjectAnnotation(JL,'rectangle',roi,'ROI'); % title
bboxes = step(COD,JL,roi);
frame = insertObjectAnnotation(frame,'rectangle',bboxes,'Car'); % title
imshow(frame)
title('Bounding Boxes for Car detected with Cascade Object Detector');

% Extract a roi from z layer of point cloud
x1 = bboxes(:,1);
x2 = bboxes(:,1)+bboxes(:,3);
y1 = bboxes(:,2);
y2 = bboxes(:,2)+bboxes(:,4);
ptCloudZRoi = ptCloud(y1:y2,x1:x2,3);

% Calculate the average z value or distance
distance = mean(ptCloudZRoi(:),'omitnan');

% Overlay the average distance onto the image
frame = insertObjectAnnotation(JL,'rectangle',bboxes,num2str(distance));
figure
imshow(frame)
title('Depth of car extracted from Point Cloud');