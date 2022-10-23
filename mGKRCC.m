
function [precision, recall,times,idt]=mGKRCC(X,Y,CorrectIndex) 

CorrectIndex=CorrectIndex';
Delte =0.5;
epsilon=0.6;
n_k_sizes = [16,17,18];
sorting_plan=["plan1","plan2","plan3","plan4"];
choose_plan=sorting_plan(1);%选择排序方案

X(:,3)=1;
Y(:,3)=1;%转化为其次坐标，X的大小为（101，3）
[Xn, T] = normalise2dpts(X');  %Xn的大小为（3，101）
%把一系列的齐次坐标［x y 1］归一化，使得这些点以原点为中心，距离原点均值为sqrt(2)。Xn=T*X’
[Yn, T] = normalise2dpts(Y');
X=Xn(1:2,:);  %此时X的大小为（2，101）
Y=Yn(1:2,:);  %此时Y的大小为（2，101）
X=double(X');  %把其它形式的数组转换为double类型
Y=double(Y');  %把其它形式的数组转换为double类型，并转置，大小为（101，2）

tic;
[P,C] = Multi_neighbourhoods(n_k_sizes,X,Y,Delte,epsilon,choose_plan);
idt = find(P == 1);  %找到内点的索引
times=toc;
[inlier_num,inlierRate,precision,recall]=get_evaluate(X,CorrectIndex,idt);

end   







