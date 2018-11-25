function [path, pathLength, newE] = pathFinder(p1, p2, edges)

%p1 and p2 are the endpoints respectively that we want to find our shortest
%path to
import java.util.LinkedList;
q = LinkedList();
rowNum = [-1, 0, 0, 1];
colNum = [0, 1, -1, 0];
[a,b] = size(edges);
visited = zeros(a,b);
cost = zeros(a,b);
cost(p1(1), p1(2)) = 0;
visited(p1(1),p1(2)) = 1;
q.add(p1);
pathLength = 0;
while q.size() > 0
    pt = q.removeFirst();
    if (pt(1) == p2(1) && pt(2) == p2(2))
        pathLength = cost(pt(1), pt(2));
        break
    end
    for i=1:4
        row = pt(1) + rowNum(i);
        col = pt(2) + colNum(i);
        bool = isValid(row,col,edges);
        if bool == 1 && edges(row,col) == 0 && visited(row,col) == 0
            visited(row,col) = 1;
            cost(row,col) = cost(pt(1),pt(2)) + 1;
            q.add([row col]);
        end
    end
end

path = zeros(2,pathLength);
currSpot = p2; 
newE = edges;
for i = 1:pathLength
    path(1:2, pathLength - i + 1) = currSpot.';
    newE(currSpot(1), currSpot(2)) = 1;
    for j=1:4
        if cost(currSpot(1) + rowNum(j), currSpot(2)+colNum(j)) == ...
                cost(currSpot(1), currSpot(2)) - 1
            newSpot = [currSpot(1) + rowNum(j), currSpot(2) + colNum(j)];
        end
    end
    currSpot = newSpot;
end

end