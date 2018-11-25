function [crossRegion, newCross] = createCrossRegion(crossSection, point, edges)

%The crossSection is the initial crossSection for which we want to get
%nearby crossSections for the purpose of averaging together k values

%point is the point that generates this crossSection

%edges are the edges for that image that the crossSection is part of

import java.util.LinkedList;
q = LinkedList();
[a,~] = size(crossSection);
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

%Orientation to one side
newCross = edges;
for i = 1:5
    [crossSectionNew, ~, ~] = CrossSectionDetectionE(point ...
        + i*increment, edges);
    [t, ~] = size(crossSectionNew);
    for j = 1:t
        q.add([crossSectionNew(j,1) crossSectionNew(j,2)]);
    end
end

%Orientation to the other side
for i = 1:5
    [crossSectionNew, ~, ~] = CrossSectionDetectionE(point ...
        - i*increment, edges);
    [t, ~] = size(crossSectionNew);
    for j = 1:t
        q.add([crossSectionNew(j,1) crossSectionNew(j,2)]);
    end
end

for i = 1:a
    q.add([crossSection(i,1) crossSection(i,2)]);
end

qSize = q.size;
crossRegion = zeros(qSize, 2);
for i = 1:qSize
    nextPoint = q.remove;
    crossRegion(i,1) = nextPoint(1);
    crossRegion(i,2) = nextPoint(2);
    newCross(nextPoint(1), nextPoint(2)) = 1;
end

end