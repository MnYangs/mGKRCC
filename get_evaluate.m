function [inlier_num,inlierRate,precision_rate,Recall_rate]=get_evaluate(X,CorrectIndex,ind)
 N=size(X,1);
inlier_num = length(CorrectIndex);
inlierRate = inlier_num./N;

Correct_num=sum(double(ismember(ind,CorrectIndex)));
precision_rate=Correct_num/length(ind);
Recall_rate=Correct_num/length(CorrectIndex);
if Recall_rate==0
    precision_rate=inlierRate;
    Recall_rate=1;
end
