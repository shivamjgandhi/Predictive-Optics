function [crossSection, edgePoint, crossE] = CrossSectionDetectionE(point, E)

%This algorithm returns two things. First, the crossSection is the
%crossSection within the blood vessel that includes that original point,
%which we specify. Next, edgePoint is the point on the edge of the vessel
%that starts the crossSection. We return this in order to find the second
%point using the GenerateSecondPoint algorithm.

%The first part of this algorithm is to initialize a bunch of variables. We
%need E, the edges, in order to figure out the crossSection within that.
%The queue allows a BFS. 

import java.util.LinkedList;
q = LinkedList();

converged = 0;
q.add(point);
[a,b] = size(E);
Visited = zeros(a,b);
iterations = 0;

%The second part of this algorithm is to find the edgePoint which is
%required to build our crossSection. We do this by using a queue and doing
%a BFS to find the nearest point that is part of an edge, which will be the
%start of the crossSection

while converged == 0
    while q.size > 0
        next = q.remove();
        next = fix(next);
        Visited(next(1), next(2)) = 1;
        if E(next(1), next(2)) == 1
            converged = 1;
            edgePoint = next;
            break
        end
        if Visited(next(1)+1, next(2)) == 0
            q.add([next(1)+1, next(2)]);
            Visited(next(1)+1, next(2)) = 1;
            iterations = iterations + 1;
        end
        if Visited(next(1)-1, next(2)) == 0
            q.add([next(1)-1, next(2)]);
            Visited(next(1)-1, next(2)) = 1;
            iterations = iterations + 1;
        end
        if Visited(next(1), next(2)+1) == 0
            q.add([next(1), next(2)+1]);
            Visited(next(1), next(2)+1) = 1;
            iterations = iterations + 1;
        end
        if Visited(next(1), next(2)-1) == 0
            q.add([next(1), next(2)-1]);
            Visited(next(1), next(2)-1) = 1;
            iterations = iterations + 1;
        end
    end
end

hitOtherSide = 0;
currPoint = edgePoint;
q2 = LinkedList();
q2.add(currPoint);

%The third part of the algorithm is to figure out in which direction the
%crossSection will be made. We first need to find the direction in which
%edgePoint lies to the original point, as the crossSection will run
%parallel to that vector. We also need to figure out biases to get which
%way our algorithm should build the crossSections.

v = fix(point.' - currPoint);
if (v(1) ~= 0) && (v(2) ~= 0)
    G = gcd(v(1), v(2));
    v = v/G;
elseif (v(1) == 0)
    v = v/abs(v(2));
else
    v = v/abs(v(1));
end

if v(1) > 0
    xBias = 1;
elseif v(1) < 0
    xBias = -1;
else
    xBias = 0;
end
if v(2) > 0
    yBias = 1;
elseif v(2) < 0
    yBias = -1;
else
    yBias = 0;
end
    
%We need to figure out which direction the crossSection will be built in
%first by figuring out which component of the vector v is longer. This will
%allow us to be more accurate in our crossSection, which fundamentally is
%an approximation.

longitude = abs(v(1));
latitude = abs(v(2));
if latitude > longitude
    priv = 2;
else
    priv = 1;
end

%During this final section, we actually build the crossSection. This is
%done by repeatedly using the vector v to go towards the other side. 

section = 1;
counter = 0;
if (xBias ~= 0) && (yBias ~= 0)
    while hitOtherSide == 0
        currPoint = q2.getLast();
        if section == 1
            if priv == 1
                nextPoint = [currPoint(1)+xBias, currPoint(2)];
                counter = counter +1;
                if counter == abs(v(1))
                    section = 2;    
                    counter = 0;
                end
            else
                nextPoint = [currPoint(1), currPoint(2) + yBias];
                counter = counter + 1;
                if counter == abs(v(2))
                    section = 2;
                    counter = 0;
                end
            end
        else
            if priv == 1
                nextPoint = [currPoint(1), currPoint(2) + yBias];
                counter = counter + 1;
                if counter == abs(v(2))
                    section = 1;
                    counter = 0;
                end
            else
                nextPoint = [currPoint(1)+xBias, currPoint(2)];
                counter = counter +1;
                if counter == abs(v(1))
                    section = 1;
                    counter = 0;
                end
            end
        end
        q2.add(nextPoint);
        if E(nextPoint(1), nextPoint(2)) == 1
            hitOtherSide = 1;
        end
    end
    
%The above algorithm does not work if one of xBias or yBias is 0, since it
%will get stuck in an infinite loop. As a result, we add these cases.

elseif (xBias == 0)
    while hitOtherSide == 0
        currPoint = q2.getLast();
        nextPoint = [currPoint(1), currPoint(2)+yBias];
        q2.add(nextPoint);
        if E(nextPoint(1), nextPoint(2)) == 1
            hitOtherSide = 1;
        end
    end
else
    while hitOtherSide == 0
        currPoint = q2.getLast();
        nextPoint = [currPoint(1)+xBias, currPoint(2)];
        q2.add(nextPoint);
        if E(nextPoint(1), nextPoint(2)) == 1
            hitOtherSide = 1;
        end
    end
end

%The final step is to actually build the crossSection from our LinkedList.

crossSection = zeros(q2.size-1, 2);
crossE = E;
while q2.size > 1
    point = q2.remove();
    crossSection(q2.size, :) = point;
    crossE(point(1), point(2)) = 1;
end

end