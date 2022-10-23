
clear; 
close all;
initialization; 

[imagename1 imagepath1]=uigetfile('.\data\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));    %选择第一幅图像
[imagename2 imagepath2]=uigetfile('.\data\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2=imread(strcat(imagepath2,imagename2));    %选择第二幅图像
[GTname2 GTpath2]=uigetfile('.\data\*.jpg;*.mat;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
load(strcat(GTpath2,GTname2));                         %选择ground truth

I1=image_input1;
I2=image_input2;

[precision, recall,times,inliers_ind]=mGKRCC(X,Y,CorrectIndex);
fscore=2*precision*recall/(recall+precision);
[FP,FN] = matches_lines(I1, I2, X, Y, inliers_ind, CorrectIndex);%画出图像匹配特征点连线图


disp(['Precision=' num2str(precision) ', Recall=' num2str(recall) ', F-socre=' num2str(fscore)]);
disp(['Runtime=' num2str(times*1000) 'ms']);
