function [KRCC,idx] = GetKendall_RCC(n_k,epsilon,N,sort_staX,sort_staY,neighborX,neighborY)


n_k = n_k+1; %代表公式（5）中的K

KRCC = zeros(1,N);  %D的大小为1*Num
    for id = 1:N
            [KRCCi,~]  = Get_KRCCid(neighborX(:,id),neighborY(:,id),sort_staX(:,id),sort_staY(:,id),n_k);
             KRCC(id) = KRCCi;
    end

      idx = find(KRCC<= epsilon); 
  end