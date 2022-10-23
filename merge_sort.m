
function [list,kendall_dist] = merge_sort(list,li,n_l,k_n,kendall_dist)
%%合并排序
mm = floor((li + n_l) / 2);  %floor()函数表示朝负无穷大方向取整


if ((mm + 1 - li) <= k_n)  %如果这个区间中心元素距离起点的大小小于15
    [list,kendall_dist] = insert_sort(list,li,mm,kendall_dist);  %插值法排序，x是排序后的结果从小到大，dist是插值的次数
else
    [list,kendall_dist] = merge_sort(list,li,mm,k_n,kendall_dist);
end

if ((n_l - mm) <= k_n)  %如果这个区间中心元素距离终点的大小小于15
    [list,kendall_dist] = insert_sort(list,mm + 1,n_l,kendall_dist);  %同样是使用插值法进行排序
else
    [list,kendall_dist] = merge_sort(list,mm + 1,n_l,k_n,kendall_dist);
end

%将排序后的数组合并
[list,kendall_dist] = merge(list,li,mm,n_l,kendall_dist);
%这里得到的dist是kendall距离，x是排序后的结果，从小到大

end