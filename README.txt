This MATLAB FileExchange entry contains files related to the "Stereo Vision" video of the AUVSI Foundation: Computer Vision Training.

examples - Files used in the video
[~] DepthExtractionExample.m : Example MATLAB code file to show depth extraction using stereo images.
[~] singleCapture.m : Example MATLAB code file to acquire a single set of stereo images.
[~] timedCapture.m : Example MATLAB code file to acquire stereo images for a specified timed interval.
[~] thresholdPC.m : Utility MATLAB function to return thresholded point clouds with specified thresholds.
[~] sceneLeft.jpg : Example left stereo image of a scene.
[~] sceneRight.jpg : Example right stereo image of a scene.
[~] exampleStereoParams.mat : Example stereo camera calibration parameters obtained through the app shown in the training video.
[~] stereoParameters.mat : Example stereo camera calibration parameters to be used for depth extraction example.
[~] stereo : Folder containing example images having 'left' and 'right' folders containing respective stereo images for calibration.

exercises - Files for exercise and practice tasks 
[~] auvsi_ipcv_exercises_11_note.pdf : Note introducing the exercise tasks and presenting respective solutions.
[~] vehicleDepthExtraction_start.m : Example starter MATLAB code file for the exercise "Vehicular Stereo Vision".
[~] vehicleDepthExtraction.m : Solution MATLAB code file for the exercise "Vehicular Stereo Vision".
[~] vehicleDepthEstimation.m : Solution MATLAB code file for the "Extra 2" section of exercise 
                               involving vehicle depth estimation for a single frame.
[~] vehicleDepthEstimation_vid.m : Solution MATLAB code file for the "Extra 2" section of exercise
                                   involving vehicle depth estimation for a video.
[~] returnStereoImages.m : Utility MATLAB function to return specified set of stereo images through an index
                           from the "media/RecordedImages" folder.
[~] returnTrainingPath.m : Utility MATLAB function to return path to the training files.
[~] thresholdPC.m : Utility MATLAB function to return thresholded point clouds with specified thresholds.
[~] stereoParams.mat : Example stereo camera calibration parameters to use for the exercise
                       "Vehicular Stereo Vision".
[~] CarDetector.xml : Example trained cascade object detector to use for detecting rear of cars
                      for the "Extra 2" section of exercise involving vehicle depth estimation.
[~] media : Folder containing two image folders 'CalibrationImages' and 'RecordedImages'.
            [~] CalibrationImages : Images to use for 'Extra 1' section of the exercise for
                                    Stereo Camera Calibration.
            [~] RecordedImages : Images to use for "Vehicular Stereo Vision" and "Extra 2"
                                 section of the exercise for vehicle depth estimation. Use
                                 the utility function "returnStereoImages" to access these
                                 images in any MATLAB code file.