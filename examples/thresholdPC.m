function ptCloudOut = thresholdPC(ptCloudIn,thresholds)
% Copyright 2015-2016 The MathWorks, Inc.
ptCloud = ptCloudIn;

% unpack thresholds
xl = thresholds(1,1);
xu = thresholds(1,2);
yl = thresholds(2,1);
yu = thresholds(2,2);
zl = thresholds(3,1);
zu = thresholds(3,2);

% unpackage point cloud
x = ptCloud(:,:,1);
y = ptCloud(:,:,2);
z = ptCloud(:,:,3);
% threshold point cloud
x(x < xl | x > xu) = NaN; 
y(y < yl | y > yu) = NaN;
z(z < zl | z > zu) = zu;
% package point cloud
ptCloud(:,:,1) = x;
ptCloud(:,:,2) = y;
ptCloud(:,:,3) = z;

ptCloudOut = ptCloud;