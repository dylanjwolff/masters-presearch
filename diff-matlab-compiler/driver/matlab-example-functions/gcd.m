function [g, c, d] = gcd(a)

b = 17;
%
% [My notes on the working of 0, 1 and  1, 0 "trick",
% and Usage Examples have been added.
% Sundar Krishnan (sundark100@yahoo.com) Oct 2004]
%
% Pl also refer my modified code : gcd_SK_GHB.m which
% is based on the suppression of calculation of u2, v2 and t2
% at intermediate steps - as observed by Gordon H. Bradley - as given
% in 4.5.2, P343 of Vol 2, 3rd Ed of D E Knuth's book.
%
% Matlab's Original Initial Comments :
%
%GCD    Greatest common divisor.
%   G = GCD(A,B) is the greatest common divisor of corresponding
%   elements of A and B.  The arrays A and B must contain non-negative
%   integers and must be the same size (or either can be scalar).
%   GCD(0,0) is 0 by convention; all other GCDs are positive integers.
%
%   [G,C,D] = GCD(A,B) also returns C and D so that G = A.*C + B.*D.
%   These are useful for solving Diophantine equations and computing
%   Hermite transformations.
%   Refer also my code Diophantine_1.m and Diophantine_miniature9.pdf.
%
%   Algorithm: Originally of Aryabhatta (AD 499)
%   See Knuth Volume 2, Section 4.5.2, Algorithm X.
%   (P343 in 3rd Ed of D E Knuth's book)
%
%   See also LCM.
%   Author:    John Gilbert, Xerox PARC
%   Copyright 1984-2000 The MathWorks, Inc. 
%   $Revision: 5.12 $  $Date: 2000/06/01 15:13:59 $
%
%                                 &&&&&&&&&&&&
%
% Refer to my modified code gcd_SK_GHB.m incorporating Gordon H. Bradley's
% suggestion of suppression of calculation of u2, v2 and t2
% at intermediate steps.
%
% Refer also to my code CMPLX_GCD.m where too, I have followed
% Aryabhatta's 0, 1 and 1, 0 logic as followed in Matlab's standard gcd.m
% However, as of Sep 2004, I have not yet explored in CMPLX_GCD.m
% if similar u2, v2 and t2 calculations can be suppressed
% at intermediate steps.
%
% Refer also to my other GCD related codes like Poly_GCD.m, Ch_Rem_Thr_Int.m,
% Ch_Rem_Thr_Poly.m etc as published in Matlab's File Exchange.
%
%                               ****************
%
% Working Egs :
% The notation in this eg largely follows Richard Blahut's book :
% Algebraic Codes for Data Transmission / P71.
% Read this as a support for field_inv_test.m
%
% Let us work with this eg :
% [G, a, b] = gcd ( s, p ) = gcd ( 585, 3887 ) 
% Assumption : s < p    (I follow p instead of q.)
%
% Verify : G = a*s + b*p
%
% 585 ) 3887 ( 6
%       3510
%       ----
%        377 ) 585 ( 1
%              377
%              ---
%              208 ) 377 ( 1
%                    208
%                    ---
%                    169 ) 208 ( 1
%                          169
%                          ---
%                           39 ) 169 ( 4
%                                156
%                                ---
%                                 13 ) 39 ( 3
%                                      39
%                                      --
%                                      00
%
% IMP : Observe that all the Divisors : 13, 39, 169, 208, 377, 585
% are all multiples of the GCD = 13.
%
% So our qoutients have been : 6, 1, 1, 1, 4, 3
%
% The Procedure :
%
% Take : 0  1  higher no = 3887
% and  : 1  0  lower no  =  585
%
% Now, we need to operate on 0 1  and  1 0 the same way as with the main nos,
% but with the same quotients as we obtained for the main 2 nos.
%
%  1 ) 0 ( 6
%      6
%     --
%     -6 ) 1 ( 1
%         -6
%         --
%          7 ) -6 ( 1
%               7
%             ---
%             -13 )  7 ( 1
%                  -13
%                  ---
%                   20 ) -13 ( 4
%                         80
%                        ---
%              a =  -->  -93 )  20 ( 3    % a = -93, the multiple on s = 585, the lower no
%                             -279 
%                             ----
%                         -->  299        % abs (299) * (GCD = 13) = 3887 = p (higher no)
%                             
%
%  0 ) 1 ( 6
%      0
%      -
%      1 ) 0 ( 1
%          1
%         --
%         -1 ) 1 ( 1
%             -1
%             --
%              2 ) -1 ( 1
%                   2
%                  --
%                  -3 )  2 ( 4
%                      -12
%                      ---
%              b =  --> 14 ) -3 ( 3     
% b = 14, the multiple on p =3887, the higher no
%                            42
%                           ---
%                       --> -45         
% abs (-45) * (GCD = 13) = 585 = s (lower no)
%
%
%                                 &&&&&&&&&&&&
%
% [G, a, b] = gcd ( 21, 77 )
%
% 21 ) 77 ( 3
%      63
%      --
%      14 ) 21 ( 1
%           14
%           --
%            7 ) 14 ( 2
%                14
%                --
%                00
%
% IMP : Observe that all the Divisors : 7, 14, 21
% are all multiples of the GCD = 7.
%
% So our qoutients have been : 3, 1, 2
%
% The Procedure :
%
% Take : 0  1  higher no = 77
% and  : 1  0  lower no  = 21
%
% Now, we need to operate on 0 1  and  1 0 the same way as with the main nos,
% but with the same quotients as we obtained for the main 2 nos.
%
%  1 ) 0 ( 3
%      3
%     --
%     -3 ) 1 ( 1
%         -3
%         --
% a = -->  4 ) -3 ( 2       % a = 4, the multiple on s = 21, the lower no
%               8
%             ---
%        -->  -11           % abs (-11) * (GCD = 7) = 77 = p (higher no)
%
%
%  0 ) 1 ( 3
%      0
%     --
%      1 ) 0 ( 1
%          1
%         --
% b = --> -1 )  1 ( 2       % b = -1, the multiple on p = 77, the higher no
%              -2
%              --
%          -->  3           % abs (3) * (GCD = 7) = 21 = s (lower no)
%
%                                 &&&&&&&&&&&&
%
% % Case Mod 3a of gcd_SK_GHB.m :
% clc
% a = round ( randn ( 1, 10) * 10000 ) ;
% b = round ( randn ( 1, 10) * 10000 ) ;
% [G, c, d] = gcd ( a, b )
%
% % Observe that for random numbers, the GCD would be 1 for 60.793%
% % the cases. Refer Knuth, Vol 2, Theorem D in P342.
%
% % Above Reversed : Case Mod 3b of gcd_SK_GHB.m :
% clc
% [G, c, d] = gcd_SK_GHB ( b, a )
%
%                               ****************

% Do scalar expansion if necessary - to make both a and b of the same size
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
    
    % The "abs" above is the culprit why Bradley's suggestion did not
    % work directly in gcd_SK_GHB.m !
    
    while v(3)    % ie, till the rem becomes 0 for EACH set
    % Note that (3) => the 3rd el => each set is handled independently.
    
        % Fulcrum : The foll 4 steps do the HCF operation on the 2 main nos,
        % and similarly, with the same quotients on 1 0  and  0 1.
        % See 2 Working Egs above.
        % u(3), v(3)
        q = floor ( u(3) / v(3) ) ;
        t = u - v * q ;
        u = v ;
        v = t ;
    end
    
    % u, v, t, q, pause
    
    c(k) = u(1) * sign(a(k)) ;
    d(k) = u(2) * sign(b(k)) ;
    g(k) = u(3) ;
    
%     % Only for comapring the results of gdc_SK_GHB.m ;
%     % Foll line to be commented later.
%     fprintf ( '\n**** gcd.m        : k = %d ;    u(2) = %d\n', k, u(2) ) ;
    
end

c = reshape(c,siz) ;
d = reshape(d,siz) ;
g = reshape(g,siz) ;
