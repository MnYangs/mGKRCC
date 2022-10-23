
function [list,kendall_dist] = merge(list,li,mm,n_l,kendall_dist)
%将排列后的两个数组合并

L = list(li:mm);  %x的ll到mm的元素，表示左半部分元素
i = 1;
j = mm + 1;
k = li;
while ((k < j) && (j <= n_l))
    if (L(i) <= list(j))
        list(k) = L(i);  %这里的x(k)取小的那个值
        i = i + 1;
    else
        list(k) = list(j);
        j = j + 1;
        kendall_dist = kendall_dist + (mm-li-i+2);  %这里记录逆序数
    end
    k = k + 1;
end
list(k:(j - 1)) = L(i:(i + j - k - 1));  %将x从小到大排序

end
