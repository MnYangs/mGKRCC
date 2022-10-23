
function [list, kendall_dist] = get_kendallDist(list)
k_n = 15;
n_l = length(list);
kendall_dist = 0;
[list,kendall_dist] = merge_sort(list,1,n_l,k_n,kendall_dist);

end


