function [pt2] = GenerateSecondPoint(edges, edgePoint, initialPoint)

%Phase 1: find the point right next to edgePoint within the vessel that
%will begin our queue

v1 = [1 0 0 -1 1 1 -1 -1];
v2 = [0 1 -1 0 1 -1 1 -1];
for i = 1:4
    newPoint = [edgePoint(1)+v1(i), edgePoint(2)+v2(i)];
    if edges(newPoint(1), newPoint(2)) == 0
        break
    end
end

%Phase 2: create a path that is optDist pixels long alongside the edge of
%the blood vessel to get to a crossSection that is going to allow optimal
%calculations

optDistance = 400;
j = 0;
[a,b] = size(edges);
visited = zeros(a,b);
visited(edgePoint(1), edgePoint(2)) = 1;
visited(newPoint(1), newPoint(2)) = 1;
while j < optDistance
    for i = 1:8
        nextPoint = [newPoint(1) + v1(i), newPoint(2) + v2(i)];
        sum = edges(nextPoint(1), nextPoint(2)+1) + ...
            edges(nextPoint(1), nextPoint(2)-1) + ...
            edges(nextPoint(1)+1, nextPoint(2)) + ...
            edges(nextPoint(1)-1, nextPoint(2)) + ...
            edges(nextPoint(1)+1, nextPoint(2)+1) + ...
            edges(nextPoint(1)+1, nextPoint(2)-1) + ...
            edges(nextPoint(1)-1, nextPoint(2)+1) + ...
            edges(nextPoint(1)-1, nextPoint(2)-1);
        if edges(nextPoint(1), nextPoint(2)) == 0 && sum ~= 0 && ...
                visited(nextPoint(1), nextPoint(2)) == 0
            newPoint = nextPoint;
            visited(newPoint(1), newPoint(2)) = 1;
            break
        end
    end
    j = j+1;
end

v = newPoint - edgePoint.';
pt2 = initialPoint + v;

end