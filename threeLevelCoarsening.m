function C = threeLevelCoarsening(K)

%This is the algorithm that actually coarsens the Kmap to 1/8th of its
%original size to reduce computation time. 

%These steps need us to change the Kmap to its UINT analogue. We then apply
%individual coarseners three times, which halve the size by 1/2 each time.

K = doubleToUINT(K);
D = double(coarsening(coarsening(coarsening(K))));

%We increase the variation in the values within our coarsened image in
%order to get better quality edges for our image. 

[a,b] = size(D);
C = zeros(a,b);
for i = 2:a-1
    for j = 2:b-1
        C(i,j) = floor(1/5*(D(i,j) + D(i-1,j) + D(i+1,j)...
            + D(i,j-1) + D(i,j+1)));
        if C(i,j) > 150
            C(i,j) = 150;
        end
    end
end

C = floor(C*5/3);

C = uint8(C);
        
end