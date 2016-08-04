% Copyright 2015-2016 The MathWorks, Inc.
%%
clc
clear
close all
%% Setup
% Multiple Cameras
VDR = imaq.VideoDevice('winvideo',1);
VDL = imaq.VideoDevice('winvideo',2);
VDR.VideoFormat = 'MJPG_1280x720';
VDL.VideoFormat = 'MJPG_1280x720';

% % Integrated Camera
% VD = imaq.VideoDevice('winvideo',1);
% VD.VideoFormat = 'YUY2_2560x720';
% VD.ReturnedColorSpace = 'rgb';

%% Save Images
% Multiple Cameras
frameR = step(VDR);
frameL = step(VDL);

% % Single Camera
% frame = step(VD);
% frameL = frame(:,1:end/2,:);
% frameR = frame(:,end/2+1:end,:);

%Build a name for the matfile
dt=datestr(now);
dt=strrep(dt,':','_'); %Replace colon with underscore
dt=strrep(dt,'-','_');%Replace minus sign with underscore
dt=strrep(dt,' ','_');%Replace space with underscore

% Save images to the CalibrationImages directory
imwrite(frameL,fullfile(pwd,'CalibrationImages','left',['frameL_',dt,'.jpg']));
imwrite(frameR,fullfile(pwd,'CalibrationImages','right',['frameR_',dt,'.jpg']));

% Save images to the RecordedImages directory
% imwrite(frameL,fullfile(pwd,'RecordedImages','left',['frameL_',dt,'.jpg']));
% imwrite(frameR,fullfile(pwd,'RecordedImages','right',['frameR_',dt,'.jpg']));

imshowpair(frameL,frameR,'montage');

%% Cleanup
% Multiple Cameras
release(VDR)
release(VDL);

% % Integrated Camera
% release(VD);