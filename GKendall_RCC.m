 function [GKendall,idx] = GKendall_RCC(n_k,epsilon,neighborX,neighborY,Xt,Yt,choose_plan,distX,distY)
       
%%  求非公共元素的数目        
        neighborX1 = neighborX(2:n_k+1, :);
        neighborY1 = neighborY(2:n_k+1, :);      
        neighborIndex = [neighborX1; neighborY1];
        index = sort(neighborIndex);
        temp1 = diff(index);
        temp2 = (temp1 == zeros(size(temp1, 1), size(temp1, 2)));
        m = sum(temp2);
        n_d = n_k-m;   %非公共给元素的数目
        
        N=max(size(Xt,1),size(Xt,2));
      
%%            
%%%%%%%%%plan1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if choose_plan=="plan1"
    sort_staX=distX;
    sort_staY=distY;
    [KRCC,idx] = GetKendall_RCC(n_k,epsilon,N,sort_staX,sort_staY,neighborX,neighborY);   
end
%%
%%%%%%%%%%%%%%%%%plan2 and plan3%%%%%%%%%%%%%%%%%%%%%%%%
if choose_plan=="plan2"||choose_plan=="plan3"
    neigX_line=zeros(2,(size(neighborX,1)),N);
    neigY_line=zeros(2,(size(neighborY,1)),N);


      
    for jj=1:size(neighborX,1)
        neigX_line(:,jj,:)=Xt(:,neighborX(jj,:))-Xt;
        neigY_line(:,jj,:)=Yt(:,neighborY(jj,:))-Yt;
    end
    
    theta_X=zeros((size(neighborX,1)),N);
    theta_Y=zeros((size(neighborY,1)),N);

    
    for mm=1:N        
        norm_den_X= repmat(sqrt(neigX_line(1,:,mm).^2+neigX_line(2,:,mm).^2),2,1);
        norm_den_Y= repmat(sqrt(neigY_line(1,:,mm).^2+neigY_line(2,:,mm).^2),2,1);
        neigX_line_norm=neigX_line(:,:,mm)./norm_den_X;
        neigY_line_norm=neigY_line(:,:,mm)./norm_den_Y;
        theta_X(:,mm)=acos(neigX_line_norm(1,:));
        theta_Y(:,mm)=acos(neigY_line_norm(1,:));
    end


 if choose_plan=="plan2"
   [KRCC,idx] = GetKendall_RCC(n_k,epsilon,N,distX,distY,neighborX,neighborY);
   [KRCC1,idx] = GetKendall_RCC(n_k,epsilon,N,theta_X,theta_Y,neighborX,neighborY);
   KRCC=(KRCC+KRCC1)./2;
 end
 if choose_plan=="plan3"
     sort_staX=distX.*cos(theta_X);
     sort_staY=distY.*cos(theta_Y);
     [KRCC,idx] = GetKendall_RCC(n_k,epsilon,N,sort_staX,sort_staY,neighborX,neighborY);
 end
 
end

%%
%%%%%%%%%%%%%%%%%%plan4%%%%%%%%%%%%%%%%%%%%%%%%
if choose_plan=="plan4"
clear neigX_line;clear neigY_line;
   neigX_line=zeros(2,(size(neighborX,1)),N);
   neigY_line=zeros(2,(size(neighborY,1)),N);
   vec_X=zeros(2,(size(neighborX,1)),N);
   vec_Y=zeros(2,(size(neighborY,1)),N);

   thetaX_0_line1=zeros(2,1,N);
   thetaY_0_line1=zeros(2,1,N);


    thetaX_0_line=Xt(:,neighborX(5,:))-Xt;
    thetaY_0_line=Yt(:,neighborX(5,:))-Yt;
    thetaX_0_line1(:,1,:)=thetaX_0_line;
    thetaY_0_line1(:,1,:)=thetaY_0_line;

    
    for jj=1:size(neighborX,1)
        neigX_line(:,jj,:)=Xt(:,neighborX(jj,:))-Xt;
        neigY_line(:,jj,:)=Yt(:,neighborY(jj,:))-Yt;
        vec_X(:,jj,:)= neigX_line(:,jj,:)-thetaX_0_line1;
        vec_Y(:,jj,:)= neigY_line(:,jj,:)-thetaY_0_line1;
    end
       
       sort_staX=squeeze(vec_X(1,:,:).^2+vec_X(2,:,:).^2);
       sort_staY=squeeze(vec_Y(1,:,:).^2+vec_Y(2,:,:).^2);

              [KRCC,idx] = GetKendall_RCC(n_k,epsilon,N,sort_staX,sort_staY,neighborX,neighborY);
end

        

        KRCC_rep= repmat(KRCC,2*n_k,1);%D的大小为（1，N）；
        KRCC_rep=KRCC_rep./max(max(KRCC_rep));
        KRCC_rep01 = KRCC_rep >= epsilon.*ones(2*n_k,size(KRCC_rep,2));%应该是对应公式（9） 0.7
        KRCC_rep01 = KRCC_rep01(1:end-1, :).*temp2; % 对应公式（10），目的是找到两个集合的交集
        KRCC_repSum = sum(KRCC_rep01); %求出交集的大小也就是p帽
         
        GKendall= (n_d +  KRCC_repSum) / n_k;  %对应公式（11）
%       GKendall= (n_d ) / n_k;  %对应公式（11）
%         GKendall= ( KRCC_repSum) / n_k;  %对应公式（11）
        

end