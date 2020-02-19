function [g, c, d] = gcd(a)

b = 17;














































































































































































































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
 
for k = 1 : length(a)            % length(a) decides the no of sets.
    u = [ 1  0  abs(a(k)) ] ;
    v = [ 0  1  abs(b(k)) ] ;
    


    
    while v(3)    % ie, till the rem becomes 0 for EACH set

    




        q = floor ( u(3) / v(3) ) ;
        t = u - v * q ;
        u = v ;
        v = t ;
    end
    

    
    c(k) = u(1) * sign(a(k)) ;
    d(k) = u(2) * sign(b(k)) ;
    g(k) = u(3) ;
    



    
end

c = reshape(c,siz) ;
d = reshape(d,siz) ;
g = reshape(g,siz) ;
