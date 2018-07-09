## Number Recognition

Fangchen Li  
email: fangchen.li@wustl.edu  
date: 07/08/2018  
Washington University in St.Louis  

### Description
Simple hand-written number recognition using ideas from physics.  

### Usage
.To run the program, first include the folder  to the path. Then simply run the script mnist.  
The script viewImage can be used to graph overlay plot of the original image and the transformed image.  

stdFrameGenerator: generate a standard  frame for digits.  
MapToFrame_PointCharge: the main transform function.  
removeShortStroke: process the transformed image to remove the short strokes (discontinued lines).  
getSimilarity: calculate the similarity between two images.  
findReducedFrame: find the max and min index of a reduced frame.  
evaluate: evaluate the transformed images and generate final results.  

### To-do

#### For the current point charge approach:
1. include more info in the evaluation step.
2. explore other algorithms that measure image similarity.
3. dynamically assign frames of different size or even shape to each image. (maybe) 

#### For the future field approach:
1. implement the electric field.


