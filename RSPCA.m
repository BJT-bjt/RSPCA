function [P,opt_index]=RSPCA(X,  pdim, sigma, k)
[dim, num] = size(X);

P = orth(rand(dim, pdim));
d = ones(num,1);
e = ones(num, 1);
for iter = 1:1
        bi = X*d;
        b = bi/sum(d);
        A = X- b*ones(1,num);
        B = A - P*(P'*A);
        
        Bi = sqrt(sum(B.*B,1).^(1)+eps);
        d = (1+sigma)*((Bi+2*sigma)./(2*(Bi+sigma).^2));
        Oi = ((1+sigma)*(Bi.^2))./(Bi+sigma);
        d=d';
        D = diag(d);
        Hd = D - (D*e*e'*D)/(e'*D*e);
        Q = X*Hd*X';

        [P, opt_index] = IPU(Q, dim, pdim, k, P);
        

        obj(iter) = sum(Oi);

end
    
    
    
    
    
    
    



end


