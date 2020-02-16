function [y_min,y_max,idx,distance] = euclidean(x,cb)














idx = ones(1,2);
distance = zeros(1,2);

distance(1)=norm(x-cb(:,1));
distance(2)=norm(x-cb(:,1));



for index=2:size(cb,2)
    d=norm(x-cb(:,index));
    if d < distance(1)
        distance(1)=d;
        idx(1)=index;
    end
    if d > distance(2)
        distance(2)=d;
        idx(2)=index;
    end
end


y_min=cb(:,idx(1));
y_max=cb(:,idx(2));

end