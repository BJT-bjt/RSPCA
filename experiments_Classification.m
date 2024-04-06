clear all;
warning('off');
% addpath('./FINCH');
addpath('./noise_data');
addpath('./Measures');
 Files = dir(fullfile('./noise_data', 'ORL_64x64_1_2nosis.mat'));
 Max_datanum = length(Files);   % 数据集的个数
for kk=1:length( Files )
    data_num = kk;                  
    Dname = Files(data_num).name; % data name
    disp(['***********The test data name is: ***' num2str(data_num) '***'  Dname '****************'])
    data = load(Dname);
    X = data.X;
    Y = data.y;
    X = sparse(double(X));
    [n1,n2]=size(X);
    n0=max(size(Y));
    if n1==n0
        X=X';
    else
        X=X;
    end
    X = mapminmax(X,0,1);
    
    % 
    [dim, num] = size(X);

    
    cluster_n = length(unique(Y));
    c=cluster_n;
    k = 5;

    fea_nums = [256:256:2048];
    sigmas = 10.^[-3];
    sigma = sigmas;
          for fea_num = fea_nums
              for sigma = sigmas
              pdims = [0.25*fea_num:4:fea_num];
%               pdims = 10;
              for pdim = pdims
                [P,idx]=RSPCA(X,  pdim, sigma, fea_num);
                newfea = X(idx(1:fea_num), :);
                newfea=newfea';
                [TrainX, TrainY, TestX, TestY] = Ransample_vecrate(newfea,Y,0.6);
                [acc1] = ClassificationMeasure(TrainX, TrainY, TestX, TestY);

                
                fea_num_idx = find(fea_nums == fea_num);
                pdim_idx = find(pdims == pdim);
                sigma_idx = find(sigmas == sigma);
                
                accuracy{fea_num_idx}(sigma_idx, pdim_idx)  = acc1; 

                
                name = Files(kk).name;
                filename = strrep(name, '.mat', '_RSPCA');
                save (filename, 'accuracy')
                disp(['when fea_num = ' , num2str(fea_num), ', sigma = ' , num2str(sigma), ', pdim = ' , num2str(pdim),', the acc is:',int2str(acc1*100),'%'])
              end
              end
          end
end