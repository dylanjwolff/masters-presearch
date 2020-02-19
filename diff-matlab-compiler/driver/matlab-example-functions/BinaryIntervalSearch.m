
































function indexes = BinaryIntervalSearch(ref, varargin)
x = [-42   -39   -27   -27   -22   -10   -10    -8    -7    -3     1     6     8     9    10    15    16    16    18    25    40    42    50    50];
tol = 4;

lbound = ref-tol;
ubound = ref+tol;
from=1;
to=length(x);

if lbound <= x(1)
    if ubound < x(1)
        indexes=[];
        return
    end
    lindex=1;
else
    lindex=0;
end
if ubound >= x(end)
    if lbound > x(end)
        indexes=[];
        return
    end
    uindex=length(x);
else
    uindex=0;
end

go=uindex==0 || lindex==0;
while go
    mid = ceil(from+(to-from)/2);

    if x(mid) < ref %diff < 0  15/apr/2011
        if x(mid) >= lbound
            go=false;
        else
            from=mid+1;
            if x(from) >= lbound
                lindex=from;
                go=false;
            end
        end
    else       % x(mid) > ref
        if x(mid) <= ubound
            go=false;
        else
            to=mid-1;
            if x(to) <= ubound
                uindex=to;
                go=false;
            end
        end
    end
end


if (lindex > 0 && x(lindex) > ubound)...
        || (uindex > 0 && x(uindex) < lbound)
    indexes=[];
    return
end


cfrom=from;
if from==length(x) || x(from+1) > ubound
    uindex=from;
end
if nargin == 4
    to=min([to mid+varargin{1}]);
end
while uindex == 0
    mid = ceil(from+(to-from)/2);
    if x(mid) <= ubound
        from=mid+1;
        if x(from) > ubound 
            uindex=mid;
        end
    else 
        to=mid-1;
        if x(to) < ubound
            uindex=to;
        end
    end
end


from=cfrom;
to=uindex; 
if to==1 || x(to-1) < lbound
    lindex=to;
end
if nargin == 4
    from=max([from uindex-varargin{1}]); 
end
while lindex == 0
    mid = ceil(from+(to-from)/2);
    if x(mid) < lbound
        from=mid+1;
        if x(from) > lbound
            lindex=from;
        end
    else 
        to=mid-1;
        if x(to) < lbound
            lindex=mid;
        end
    end
end

indexes=lindex:uindex;


































