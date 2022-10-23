function  [KRCCi,new_pos2] = Get_KRCCid(rank_list1,rank_list2,sort_staX,sort_staY,n_k)


%%  这一段函数的目的是保留两个图像点X，Y的邻域中的都有的点，也就是公共点
RL1 = rank_list1(1:n_k);%X的邻域中的前n_k个点的索引  list1大小为（n_k，1），所以L1的大小为（n_k,1）
RL2 = rank_list2(1:n_k);%Y的邻域中的前n_k个点的索引  L2的大小为（n_k,1）
RLIST = [[RL1;RL2],[1:2*n_k]']; %将两个图像的的邻域点拼接起来，大小为（2*n_k，2），其中第二列表示原来的排列
RL = sortrows(RLIST,1);  %对第1列进行排序，从小到大
temp1 = logical(diff(RL(:,1)));%函数diff是用来求差分的，就是下一个元素减去上一个元素的差值

RL_in1= RL([~temp1;false],2);  %[~temp1;false]相当于在~temp1的下一行加了逻辑值元素false，其大小变为（2*n_k，1）
%ia中保存了L第2列中对应的~temp1为1的元素，最后一个元素不保留，相当于保留了相同元素的索引
RL_in2= RL([false;~temp1],2)-n_k;
%ib中保留了L第二列中对应的~temp1为1的元素，第一个元素不保留，然后减去n_k，因为它排在了第二位
%%
sort_staX=sort_staX(RL_in1); sort_staY=sort_staY(RL_in2);  %提取公共点的距离
[~,S1] = sort(sort_staX); [~,S2] = sort(sort_staY);  %对公共点根据距离进行从小到大排序
[~,pos1] = sort(S1); [~,pos2] = sort(S2);  %在对序号进行排序得到的就是每个序列的


normal_factor=(1/2)*n_k*(n_k-1);
other_kendall = (n_k-length(pos1)).*(n_k-length(pos1))/(n_k*(n_k-1));


[~,sort_pos1] = sort(pos1);
new_pos2=sort_pos1(pos2);
[~, kendall_dist] = get_kendallDist(new_pos2);%求kendall距离

KRCCi=(kendall_dist)/normal_factor+other_kendall;


end
