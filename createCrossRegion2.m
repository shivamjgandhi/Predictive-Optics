function [crossRegion, newCross] = createCrossRegion2(crossSection, pt, E)

%The crossSection is the initial crossSection for which we want to get
%nearby crossSections for the purpose of averaging together k values

%point is the point that generates this crossSection

%edges are the edges for that image that the crossSection is part of

[a,~] = size(crossSection);
crossRegion = zeros(7*a, 2);
crossRegion(1:a, :) = crossSection;
p1 = crossSection(1,:);
p2 = crossSection(a,:);
crossOrient = p1-p2;
direction = [crossOrient(2), -crossOrient(1)];
theta = acos(dot(direction, [0 1])/norm(direction))*180/pi;
if (theta >= 0) && (theta <= 22.5)
    increment = [0 1];
elseif (theta > 22.5) && (theta <= 67.5)
    increment = [-1 1];
elseif (theta > 67.5) && (theta <= 112.5)
    increment = [-1 0];
elseif (theta > 112.5) && (theta <= 157.5)
    increment = [-1 -1];
elseif (theta > 157.5) && (theta <= 180)
    increment = [0 -1];
end

newCross = E;
counter = a+1;
for i = 1:a
    for j = 1:3
        v1 = crossSection(i, :) + j*increment;
        v2 = crossSection(i, :) - j*increment;
        crossRegion(counter, :) = v1;
        crossRegion(counter+1, :) = v2;
        newCross(v1(1), v1(2)) = 1;
        newCross(v2(1), v2(2)) = 1;
        newCross(crossSection(i,1), crossSection(i,2)) = 1;
        counter = counter + 2;
    end    
end

end