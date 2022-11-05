function [yout, validity] = intersection_y_plane(x,y, offset)
%INTERSECTION_Y_PLANE From data without function finds intersection of
%                     the data with an offset Y plane

ind = find(x > offset);
if(numel(ind) == 0)
    validity = 0;
    yout = 0;
else
    yout = y(ind(1));
    validity = 1;
end

end

