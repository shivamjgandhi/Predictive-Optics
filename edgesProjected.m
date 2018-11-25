function E = edgesProjected(V, im)

%Edges projected takes the coarsened edges in V and increases their
%dimensionality back to the original size of. This is done by taking every
%pixel within V that's an edge and making it an 8x8 edge pixel within the
%original image. 

[a,b] = size(im);
E = zeros(a,b);
[c,d] = size(V);
for i = 1:c
    for j = 1:d
        if V(i,j) == 1
            E(8*(i-1) + 1: 8*i, 8*(j-1)+1:8*j) = ones(8);
            %E(8*(i-1) + 1: 8*i, 8*(j-1)+1:8*j) = eye(8);
        end
    end
end

end
