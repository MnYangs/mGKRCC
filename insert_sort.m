
function [list,kendall_dist] = insert_sort(list,li,mm,kendall_dist)
%%插值法
for j = (li + 1):mm
    pivot = list(j);
    i = j;
    while ((i > li) && (list(i - 1) > pivot))
        list(i) = list(i - 1);
        i = i - 1;
        kendall_dist = kendall_dist + 1;
    end
    list(i) = pivot;
end
end