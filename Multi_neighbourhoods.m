    function [P,mGKendall]= Multi_neighbourhoods(n_k_sizes,X,Y,Delte,epsilon,choose_plan)
        mGKendall=zeros(1,size(X,1));
        num=0;
        Xt = X';
        Yt = Y';
        N=max(size(X,1),size(X,2));
        idx=1:N;
        for n_k = n_k_sizes 
             kdtreeX = vl_kdtreebuild(Xt(:,idx));
             kdtreeY = vl_kdtreebuild(Yt(:,idx));
            [neighborX, distX] = vl_kdtreequery(kdtreeX, Xt(:,idx), Xt, 'NumNeighbors', n_k+1) ;
            [neighborY, distY] = vl_kdtreequery(kdtreeY, Yt(:,idx), Yt, 'NumNeighbors', n_k+1) ;
            [GKendall,idx] = GKendall_RCC(n_k,epsilon,neighborX,neighborY,Xt,Yt,choose_plan,distX,distY);
            mGKendall=mGKendall+GKendall;    
            num=num+1;
        end
        mGKendall=(mGKendall)/num;  %求均值）
        P= mGKendall<= Delte.*ones(1,size(X,1));  
    end
    
    
      