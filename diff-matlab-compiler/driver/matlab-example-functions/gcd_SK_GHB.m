function [g, c, d,   check_GCD, k_divs] = gcd_SK_GHB(a)

b = 14;

































































































































































































































if length(a) == 1
   a = a(ones(size(b))) ;
elseif length(b) == 1
   b = b(ones(size(a))) ;
end

if ~isequal(size(a),size(b))
    error('Inputs must be the same size.')
else
    siz = size(a) ;
    a = a(:) ;      b = b(:) ;
end

if ~isequal(round(a),a) | ~isequal(round(b),b)
    error('Requires integer input arguments.')
end



k_divs = zeros ( 1, length(a) ) ;
k_divs = k_divs(:) ;


for k = 1 : length(a)    % length(a) decides the no of sets.
    




    u = [ 1  abs(a(k)) ] ;    % middle 0 removed wrt gcd.m
    v = [ 0  abs(b(k)) ] ;    % middle 1 removed wrt gcd.m
    



    while v(2)    % ie, till the rem becomes 0 for EACH set

        
        k_divs(k) = k_divs(k) + 1 ;
        



        q = floor( u(2) / v(2) ) ;
        t = u - v * q ;
        u = v ;
        v = t ;
    end
    
    c(k) = u(1) * sign(a(k)) ;
    g(k) = u(2) ;    % Old was g(k) = u(3) ; in gcd.m
    


    if b(k) ~= 0




        old_u_2 = ( u(2) - abs ( a(k) ) * u(1) ) / abs ( b(k) ) ;
        

        


        
    else


        old_u_2 = 0 ;
    end
    


    
    d(k) = old_u_2 * sign(b(k)) ;
    
end




c = reshape(c, siz) ;
d = reshape(d, siz) ;
g = reshape(g, siz) ;

k_divs = reshape(k_divs, siz) ;


a = reshape(a, siz) ;
b = reshape(b, siz) ;






check_GCD = zeros ( 1, length (a) ) ;

check_GCD = a.*c + b.*d ;


for k = 1 : length(a)
    Diff(k) = check_GCD(k) - g(k) ;
    



    if abs ( Diff(k) ) > abs ( 1e-8 * g(k) )
        k, g, check_GCD, Diff(k), c, d
        error (strcat('The abs diff betwen GCD and a*c + b*d for k = ', ...
               num2str(k), 'st/rd/nd/th set is = ', ...
               num2str ( abs ( Diff (k) ) ) ) ) ;
    end
end


































































































































































