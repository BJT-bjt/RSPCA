function [resurt_mean,resurt_std,predY]=Measure(Y, NewData, cluster_n)
    Y=Y;
    iter=20;                  %æ€¿‡¥Œ ˝
    ACC=[];
    NMI=[];
    F=[];
    S_ACC=[];M_ACC=[];
    S_NMI=[];M_NMI=[];
    S_F=[];M_F=[];

    for i=1:iter
        [predY,center]=kmeans(NewData,cluster_n);
%         [c, num_clust]= FINCH(NewData,[], cluster_n);
%         [val,ind]=min(num_clust-cluster_n);
%         predY= req_numclust(c(:,ind), NewData, cluster_n);
%         predY = c(:,find(num_clust == cluster_n));
        result = ClusteringMeasure_new(Y, predY);
        ACC=[ACC,result(1,1)];
        NMI=[NMI,result(1,2)];
        F=[F,result(1,3)];
    end
    m_acc=mean(ACC);
    m_nmi=mean(NMI);
    m_F=mean(F);


    s_acc = std(ACC);
    s_nmi = std(NMI);
    s_F = std(F);
    
    resurt_mean.m_acc = m_acc;
    resurt_mean.m_nmi = m_nmi;
    resurt_mean.m_F = m_F;
    resurt_std.s_acc = s_acc;
    resurt_std.s_nmi = s_nmi;
    resurt_std.s_F = s_F;
%     Result_mean=[M_ACC,M_NMI];
%     Result_std=[S_ACC,S_NMI];
%     result=[[Result_mean],[Result_std]];
end
