function E = returnEdges(im, K)

%This algorithm returns edges within the image im. We also have the K
%included since we need the K values to figure out where the edges are. im
%is included just so after coarsening we can project according to the
%original image

E = edgesProjected(edgesCoarsened(K), im);
end
