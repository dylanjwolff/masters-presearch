function [x,y]=foo(z);

    if ischar(z)
        z=str2num(z);
    else
        z=z;
    end
    x=2*z
    y=z^2
end