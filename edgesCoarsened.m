function BW = edgesCoarsened(K)

%This function will take the initial K map and reduce the size while
%retaining most of the variation in the data (via threeLevelCoarsening) and
%then create edges from that final lower dimension approximation to K

C = threeLevelCoarsening(K);
[BW, ~] = edge(C, 'canny', 0.08);

end
