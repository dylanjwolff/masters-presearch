function [g, c, d,   check_GCD, k_divs] = gcd_SK_GHB(a)

b = 14;
%
% Sundar Krishnan (sundark100@yahoo.com)
% Release  : R14, R13, R12
% Sep 2004, Oct 2004
%
% Functional Description :
% ------------------------
% This method of finding gcd is a modification over Matlab's gcd.m ;
% it is based on the suppression of calculation of u2, v2 and t2
% at intermediate steps - as observed by Gordon H. Bradley - as given
% in 4.5.2, P343 of Vol 2, 3rd Ed of D E Knuth's book.
%
% However, I have not been able to observe any difference in time
% between the 2 methods ; it is "even" over several runs involving
% upto 20000 random numbers.
% See Case Mod 4 : Time Diff Test below.
%
%                                 &&&&&&&&&&&&
%
% Matlab's original Initial Comments :
%   GCD    Greatest common divisor.
%   G = GCD(A,B) is the greatest common divisor of corresponding
%   elements of A and B.  The arrays A and B must contain non-negative
%   integers and must be the same size (or either can be scalar).
%   GCD(0,0) is 0 by convention; all other GCDs are positive integers.
%
%   [G,C,D] = GCD(A,B) also returns C and D so that G = A.*C + B.*D.
%
%                                 &&&&&&&&&&&&
%
% Refer also to my code(s) for finding GCD of Complex Nos :
% CMPLX_GCD.m -> CMPLX_GCD_Supr_2.m where too, I have followed
% Aryabhatta's 0, 1 and 1, 0 logic as followed in Matlab's standard gcd.m
%
% Refer also to my other GCD related codes like Poly_GCD.m,
% Ch_Rem_Thr_Int.m, Ch_Rem_Thr_Poly.m etc as published in
% Matlab's File Exchange.
%
%                                 &&&&&&&&&&&&
%
% Author's Legal Disclaimer :
% ---------------------------
% I share my code, developed with lots of efforts, and based on lots of 
% studies, in good faith.
% Everyone is free to use this code at their own risk provided
% they include my name for this part in their works.
% However, I am still learning many facets of this subject ; there may be
% still some open unanswered technical questions for me on this subject
% and possibly in this programme.
% I am NOT responsible for any technical or legal complications
% directly or indirectly, arising out of any direct or indirect use
% of my codes or my interpretations.
% Any apparent TECHNICAL fault in interpreting any external references, 
% or others' replies in any Public User Group Forums, is my own, 
% not theirs. However, I am NOT LEGALLY responsible for any of my
% technical or other interpretation of others' comments in ANY Forum.
%
%                               ****************
%
% Working Egs :    (Usage Egs with "gcd_SK_GHB" are given at the end.)
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
% % Case Mod 3a :
% a = round ( randn ( 1, 10) * 10000 ) ;
% b = round ( randn ( 1, 10) * 10000 ) ;
% [G, c, d] = gcd_SK_GHB ( a, b )
%
% % Observe that for random numbers, the GCD would be 1 for 60.793%
% % the cases. Refer Knuth, Vol 2, Theorem D in P342.
%
% % Above Reversed : Case Mod 3b :
% clc
% [G, c, d] = gcd_SK_GHB ( b, a )
%
%                                 &&&&&&&&&&&&
%
% See more Usage Egs below at the end.
%
%                               ****************

% % Only for comapring with gcd.m : Foll line to be commented later.
% a_Orig = a ;
% b_Orig = b ;

%                                 &&&&&&&&&&&&

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


% k_divs = The no of HCF Divisions in the while iteration loop
k_divs = zeros ( 1, length(a) ) ;
k_divs = k_divs(:) ;

% When inputs a, b are vectors, k will run through the length.
for k = 1 : length(a)    % length(a) decides the no of sets.
    
    % Bradley's Simplification : The modification wrt gcd.m : 
    % Suppressing the original u(2), v(2) and t(2) calcs
    % at intermediate steps
    % So, old u(3) is new u(2), ...
    u = [ 1  abs(a(k)) ] ;    % middle 0 removed wrt gcd.m
    v = [ 0  abs(b(k)) ] ;    % middle 1 removed wrt gcd.m
    
    % The "abs" above is the culprit why Bradley's suggestion does not
    % work directly here in gcd_SK_GHB.m !

    while v(2)    % ie, till the rem becomes 0 for EACH set
    % Note that (2) => the 2nd el => each set is handled independently.
        
        k_divs(k) = k_divs(k) + 1 ;
        
        % Fulcrum: The foll 4 steps do the HCF operation on the 2 main nos,
        % and similarly, with the same quotients on 1 [0]  and  0 [1].
        % See 2 Working Egs above.
        q = floor( u(2) / v(2) ) ;
        t = u - v * q ;
        u = v ;
        v = t ;
    end
    
    c(k) = u(1) * sign(a(k)) ;
    g(k) = u(2) ;    % Old was g(k) = u(3) ; in gcd.m
    
    % The old u(2) can be derived as given in the book in P343 :
    % abs (a(k)) * u(1)  +  abs (b(k)) * u(2)  =  u(3)   % u(3) is now u(2)
    if b(k) ~= 0
        % I have observed that calcs match with gcd.m only if we take
        % abs ( a(k) ) and abs ( b(k) ) !
        % Why ? Because, in gcd.m, they have started by using "abs"
        % in abs(a(k)) and abs(b(k)).
        old_u_2 = ( u(2) - abs ( a(k) ) * u(1) ) / abs ( b(k) ) ;
        
        % old_u_2 = ( u(2) - a(k) * u(1) ) / b(k) ;  % Does not work in gcd
        
        % NOTE : But in CMPLX_GCD, we do NOT need abs !
        % See CMPLX_GCD_Supr_2.m
        
    else
        % This is to ensure that d = 0 when input b = 0
        % An extreme case is when both a and b are 0 like: gcd_DK_GHB (0,0)
        old_u_2 = 0 ;
    end
    
    % Only for comapring with gcd.m : Foll line to be commented later.
    % fprintf('\n**** gcd_DK_GHB.m : k = %d ;  old_u_2 = %d\n', k, old_u_2)
    
    d(k) = old_u_2 * sign(b(k)) ;
    
end

% Comment : But I have not been able to observe any difference in time
% between the 2 methods ; it is "even" for upto 20000 random numbers.

c = reshape(c, siz) ;
d = reshape(d, siz) ;
g = reshape(g, siz) ;

k_divs = reshape(k_divs, siz) ;

% We need to also reshape a and b for check_GCD calcs below.
a = reshape(a, siz) ;
b = reshape(b, siz) ;

%                               ****************

% Verify :
% (This part copied from my code : CMPLX_GCD.m)

check_GCD = zeros ( 1, length (a) ) ;
% Check that a.*c + b.*d = g as vectors :
check_GCD = a.*c + b.*d ;

% Check that gcd = a*c + b*d for EACH set in the input vector :
for k = 1 : length(a)
    Diff(k) = check_GCD(k) - g(k) ;
    
    % Based on the experience with deconv in Poly_GCD.m,
    % and also because of complex multiplications / divisions,
    % I have chosen abs ( 1e-8 * g(k) )
    if abs ( Diff(k) ) > abs ( 1e-8 * g(k) )
        k, g, check_GCD, Diff(k), c, d
        error (strcat('The abs diff betwen GCD and a*c + b*d for k = ', ...
               num2str(k), 'st/rd/nd/th set is = ', ...
               num2str ( abs ( Diff (k) ) ) ) ) ;
    end
end

%                               ****************

% Uncomment foll and "inspect" if any problem arises.
%
% For a brief trial period, let us verify with the values obtained by
% the "unsuppressed" method gcd.m.
% I understand that this step implies some extra time and some extra vars,
% but this step is only for a trial period.
% After the trial period, let us comment out the whole stuff below
% except the Usage Egs which can be used for later regression testing.
%
% % Usage Eg :
% % Case Mod 1a :
% clc
% [G, c, d] = gcd_SK_GHB ( ...
%     [ -200,   200,     0,  10000,  -0, 318, -431,  151 ], ...
%     [ 1000, -1000, -1000,   -100,  -0, 456,  191, -379 ] )
%
% % Above Reversed : Case Mod 1b :
% [G, c, d] = gcd_SK_GHB ( ...
%     [ 1000, -1000, -1000,   -100,  -0, 456,  191, -379 ], ...
%     [ -200,   200,     0,  10000,  -0, 318, -431,  151 ] )
%
%                                 &&&&&&&&&&&&
%
% % Case Mod 2a :
% clc
% [G, c, d] = gcd_SK_GHB ( ...
%     [   839,  -941,  -857,   0,   0, -2 ], ...
%     [ -1000,  1000,   967,  -1,  -0,  0 ] )
%
% % Above Reversed : Case Mod 2b :
% [G, c, d] = gcd_SK_GHB ( ...
%     [ -1000,  1000,   967,  -1,  -0,  0 ], ...
%     [   839,  -941,  -857,   0,   0, -2 ] )
%
%                                 &&&&&&&&&&&&
%
% % Case Mod 3a :
% clc
% a = round ( randn ( 1, 10) * 10000 ) ;
% b = round ( randn ( 1, 10) * 10000 ) ;
% [G, c, d] = gcd_SK_GHB ( a, b )
%
% % Above Reversed : Case Mod 3b :
% [G, c, d] = gcd_SK_GHB ( b, a )
%
%                               ****************
% 
% fprintf ( '\n' ) ;
% 
% [g_Old, c_Old, d_Old] = gcd ( a_Orig, b_Orig ) ;
% 
% g_Old, c_Old, d_Old
% fprintf ( '\n ***************** \n' ) ;
% 
% g,     c,     d        % Current values with suppressed u2, v2, t2 method
% fprintf ( '\n ***************** \n' ) ;
% 
% % For Fault Simulation :
% % g = -14 ; c = -29 ; d = 100 ;
% 
% %                                 &&&&&&&&&&&&
% 
% fprintf ( '\n     ****  gcd_SK_GHB.m output begins here.  **** \n' ) ;
% 
% %                                 &&&&&&&&&&&&
% 
% % If everything goes well, we should never land in the foll fprintfs.
% if any ( g_Old - g ) == 1 | any ( c_Old - c ) == 1 | any ( d_Old - d ) == 1
%     
%     fprintf ( '\n**** gcd_SK_GHB.m failed. ****\n' ) ;
%     
%     if any ( g_Old - g ) == 1
%         fprintf ( 'g_Old = %d ;    g (with suppressed u2, v2, t2) = %d \n', ...
%                   g_Old, g ) ;
%     end
% 
%     if any ( c_Old - c ) == 1
%         fprintf ( 'c_Old = %d ;    c (with suppressed u2, v2, t2) = %d \n', ...
%                   c_Old, c ) ;
%     end
%     
%     if any ( d_Old - d ) == 1
%         fprintf ( 'd_Old = %d ;    d (with suppressed u2, v2, t2) = %d \n', ...
%                   d_Old, d ) ;
%     end
%     
%     fprintf ( '\n' ) ;
%     
%     error ( 'gcd_SK_GHB.m failed with suppression of u2, v2, t2 calcs.' ) ;
%     
% end
%
%                               ****************
%                               ****************
%
% % Case Mod 4 : Time Diff Test :
% % However, I have not been able to observe any difference in time
% % between the 2 methods ; it is "even" over several runs involving
% % upto 20000 random numbers.
% 
% clear, clc
% 
% a = round ( randn ( 1, 20000) * 10000 ) ;
% b = round ( randn ( 1, 20000) * 10000 ) ;
% 
% %                                 &&&&&&&&&&&&
% 
% t_start_1 = cputime ;
% 
% [G_gcd, c_gcd, d_gcd] = gcd ( a, b ) ;
% G_gcd ;
% 
% t_end_1 = cputime ;
% t_diff_1 = t_end_1 - t_start_1 
% 
% %                                 &&&&&&&&&&&&
% 
% t_start_2 = cputime ;
% 
% [G_gcd_SK_GHB, c_gcd_SK_GHB, d_gcd_SK_GHB] = gcd_SK_GHB ( a, b ) ;
% G_gcd_SK_GHB ;
% 
% t_end_2 = cputime ;
% t_diff_2 = t_end_2 - t_start_2 
% 
% %                                 &&&&&&&&&&&&
% 
% % G_gcd_SK_GHB - G_gcd    % should be all 0s.
% 
% t_diff_2_methods = t_diff_1 - t_diff_2 
%
% % Comment : But I have not been able to observe any difference in time
% % between the 2 methods ; it is "even" for upto 20000 random numbers.
% 
% if any ( abs (G_gcd - G_gcd_SK_GHB) > abs (G_gcd) * 1e-8 ) == 1  |  ...
%    any ( abs (c_gcd - c_gcd_SK_GHB) > abs (c_gcd) * 1e-8 ) == 1  |  ...
%    any ( abs (d_gcd - d_gcd_SK_GHB) > abs (d_gcd) * 1e-8 ) == 1
% 
%     fprintf ( '\n**** gcd_SK_GHB.m failed. ****\n' ) ;
%     
%     if any ( abs (G_gcd - G_gcd_SK_GHB) > abs (G_gcd) * 1e-8 ) == 1
%         G_gcd, G_gcd_SK_GHB
%     end
% 
%     if any ( abs (c_gcd - c_gcd_SK_GHB) > abs (c_gcd) * 1e-8 ) == 1
%         c_gcd, c_gcd_SK_GHB
%     end
%     
%     if any ( abs (d_gcd - d_gcd_SK_GHB) > abs (d_gcd) * 1e-8 ) == 1
%         d_gcd, d_gcd_SK_GHB
%     end
%     
%     fprintf ( '\n' ) ;
%     
%     error ('gcd_SK_GHB.m failed with suppression of u2, v2, t2 calcs.') ;
%     pause
% end
% 
% %                               ****************
