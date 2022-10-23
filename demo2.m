
clear; 
close all;
initialization; 

for k=1:40
tmp = num2str(k);
% correct_index = ['E:\我的文档\研究生文件\数据集\Daisy\daisy_order\1 (' tmp  ').mat'];
%  correct_index = ['E:\我的文档\研究生文件\数据集\DTU\DTU_order\1 (' tmp  ').mat'];
  correct_index = ['E:\我的文档\研究生文件\第二篇期刊\参数设置的实验\数据集\2 (' tmp  ').mat'];
%   correct_index = ['E:\我的文档\研究生文件\数据集\SUIRD\SUIRD_all\SUIRD_order\1 (' tmp  ').mat'];
%  correct_index = ['E:\我的文档\研究生文件\数据集\Multimodal_imagematching_dataset\Medical_total\Medical_order\1 (' tmp  ').mat'];
%  correct_index = ['E:\我的文档\研究生文件\数据集\corresp_dataset\groundtruth\1 (' tmp  ').mat'];
% correct_index = ['E:\我的文档\研究生文件\数据集\遥感数据集\SAR\ORDER\1 (' tmp  ').mat'];
% correct_index = ['E:\我的文档\研究生文件\数据集\遥感数据集\CIAP\ORDER\1 (' tmp  ').mat'];
%   correct_index = ['E:\我的文档\研究生文件\数据集\RS\RS_order\2 (' tmp  ').mat'];
%  correct_index = ['E:\我的文档\研究生文件\数据集\VGG\VGG40-SIFT_order\1 (' tmp  ').mat'];
%  correct_index = ['E:\我的文档\研究生文件\数据集\Cars & Motorbikes\Cars_and_Motorbikes_Dataset_and_Code\Cars_and_Motorbikes_Graph_Matching_Datasets_and_Code\Data_for_Cars_and_Motorbikes\Cars_groundtruth_high\1 (' tmp  ').mat'];
%  correct_index = ['E:\我的文档\研究生文件\数据集\Multimodal_imagematching_dataset\ALL_mat\chose_pro\all_chose\1 (' tmp  ').mat'];
% correct_index = ['E:\我的文档\研究生文件\数据集\Multimodal_imagematching_dataset\ALL_mat\chose_pro\RGB_NIR_SIFT\1 (' tmp  ').mat'];
% correct_index = ['E:\我的文档\研究生文件\数据集\遥感数据集\UAV\ORDER\1 (' tmp  ').mat'];
% correct_index = ['E:\我的文档\研究生文件\第二篇期刊\审稿意见回复\新的多模态图像数据集\nonrigid_GT_NOISE\all\0 (' tmp  ').mat'];
load(correct_index);

[precision, recall,times,inliers_ind]=mGKRCC(X,Y,CorrectIndex);
fscore=2*precision*recall/(recall+precision);



disp(['Precision=' num2str(precision) ', Recall=' num2str(recall) ', F-socre=' num2str(fscore)]);
disp(['Runtime=' num2str(times*1000) 'ms']);

      pre(k)=precision;
      rec(k)=recall;%将所有的30幅图像的精度和召回率的值存在数组里以便于画图用
      if precision==0&&recall==0
          F(k)=0;
      else
      F(k)=2*recall*precision/(precision+recall);%求出每个图像的F-score
      end
      runtime(k)=times;
end

 preLPM=sort(pre);
    recLPM=sort(rec);
    [FLPM,ii]=sort(F);
    timeLPM=sort(runtime);
    
    preLPMav=num2str((sum(preLPM)/size(preLPM,2))*100);
    recLPMav=num2str((sum(recLPM)/size(recLPM,2))*100);
    FLPMav=num2str((sum(FLPM)/size(FLPM,2))*100);
    timeLPMav=num2str((sum(timeLPM)/size(timeLPM,2)));

  
    fprintf([preLPMav '\n']);
    fprintf([recLPMav '\n']);
    fprintf([FLPMav '\n']);
    fprintf([timeLPMav '\n']);