function timedCapture
% Copyright 2015-2016 The MathWorks, Inc.
% clc
% clear
close all

%% Set up local data
t = 0;

%% set up timer
dt = 3.0;
timers = timerfindall;
if ~isempty(timers)
    stop(timers);
end
delete(timers);

tobj = timer;
tobj.ExecutionMode = 'fixedRate';
tobj.Period = dt;
tobj.TimerFcn = @CaptureFrames;

%%
% Multiple Cameras
VDR = imaq.VideoDevice('winvideo',1);
VDL = imaq.VideoDevice('winvideo',2);
VDR.VideoFormat = 'MJPG_1280x720';
VDL.VideoFormat = 'MJPG_1280x720';

% % Integrated Camera
% VD = imaq.VideoDevice('winvideo',1);
% VD.VideoFormat = 'YUY2_2560x720';
% VD.ReturnedColorSpace = 'rgb';

%% This section is used to set the stop time of the code
% can be removed if you want code to run indefinitely
tobj.TasksToExecute = 60;
tobj.stopFcn = @(~,event)StopCallback; % function which stops timer objects

% start timer
start(tobj)

    %% timerfcn
    function CaptureFrames(~,~)
        t = t + dt; 

        % Multiple Cameras
        frameL = step(VDL);
        frameR = step(VDR);
        
%         % Integrated Camera
%         frame = step(VD);
%         frameL = frame(:,1:end/2,:);
%         frameR = frame(:,end/2+1:end,:);   
        
        %Build a name for the matfile
        dtv=datestr(now);
        dtv=strrep(dtv,':','_'); %Replace colon with underscore
        dtv=strrep(dtv,'-','_');%Replace minus sign with underscore
        dtv=strrep(dtv,' ','_');%Replace space with underscore
        
        % Save the frames to images in Calibration Images folder
        imwrite(frameL,fullfile(pwd,'CalibrationImages','left', ['frameL_',dtv,'.jpg']));
        imwrite(frameR,fullfile(pwd,'CalibrationImages','right',['frameR_',dtv,'.jpg']));
        
%         % Save the frames to images in Recorded Images folder
%         imwrite(frameL,fullfile(pwd,'RecordedImages','left', ['frameL_',dtv,'.jpg']));
%         imwrite(frameR,fullfile(pwd,'RecordedImages','right',['frameR_',dtv,'.jpg']));        
        
        % visualize images
        imshowpair(frameL,frameR,'montage');
    end

    function StopCallback
        % Multiple Cameras
        release(VDR)
        release(VDL);

%         % Integrated Camera
%         release(VD);
    end

end

