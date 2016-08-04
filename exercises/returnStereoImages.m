function [IL,IR] = returnStereoImages(idx)
% Copyright 2015-2016 The MathWorks, Inc.
% Create an image set for the Recorded Image directories
LeftImages = imageSet(fullfile(returnTrainingPath,'media','RecordedImages','left'));
RightImages = imageSet(fullfile(returnTrainingPath,'media','RecordedImages','right'));

% Load the idx'th images from the directories
ILO = imread(LeftImages.ImageLocation{idx});
IRO = imread(RightImages.ImageLocation{idx}); 

% Extract the middle of the image
[nr,~] = size(ILO);
tf = 1/4;
bf = 3/4;
IL = ILO(tf*nr:bf*nr,:,:);
IR = IRO(tf*nr:bf*nr,:,:);

end