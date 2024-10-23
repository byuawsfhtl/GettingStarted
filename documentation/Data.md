# Testing and Training Data
While most of the handwriting data we utilize will belong to a public dataset (IAM, Bentham, etc.), you may need to create or find your own truthy data so that the network can learn to segment, recognize, or classify correctly.

This documentation contains procedures for manual truthy data creation.

## Segmentation
In our ARU-Net Segmentation and Word Segmention, baseline and seam data must be provided as ground truth. To create the seams and baselines, we use a 3rd-party software called "Transkribus", which allows you to draw the baselines and text regions yourself. Transkribus data can be converted into binary images using a python script, and then fed to the NN.

[Transkribus Instructions](https://docs.google.com/document/d/1MImHRAeJ60WogIQCYJhTUdV2klgECAl53IoMJSruy5I/edit?usp=sharing) 

## New Method for Labelling LineSegmentation Data
[Here](NewData.md) is the new documentation for labelling baselines using *AWS Textract* combined with scripts and other methods.
