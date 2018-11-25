function [absBF] = AbsoluteBloodFlow(imCell, point)

%Time to put everything together!

%imCell is a cell containing the images we will be taking crossSections
%from in order to get our average k values

im1 = double(cell2mat(imCell(1)));
K1S = fastK(im1);
K1 = K1S/median(median(K1S));
E1 = returnEdges(im1, K1);
[~, edgePoint] = CrossSectionDetection(im1, point, K1);
point2 = GenerateSecondPoint(E1, edgePoint, point);
d = 400;
scaling = 4*10^(-6);
[a,~] = size(imCell);
K1 = zeros(a,1);
K2 = zeros(a,1);
for i = 1:a
    im = double(cell2mat(imCell(i)));
    KS = fastK(im);
    K = KS/median(median(KS));
    
    [crossSection1, ~, ~, E1] = CrossSectionDetection(im, point, K);
    [crossRegion1, newCross1] = createCrossRegion2(crossSection1, point, E1);
    vProfile1 = returnVelocities(crossRegion1, KS);
    K1(i) = mean(vProfile1);
    
    [crossSection2, ~, ~, E2] = CrossSectionDetection(im, point2, K);
    [crossRegion2, newCross2] = createCrossRegion2(crossSection2, point2, E2);
    vProfile2 = returnVelocities(crossRegion2, KS);
    K2(i) = mean(vProfile2);
end

[a,~] = size(crossSection1);
p1 = crossSection1(1,:);
p2 = crossSection1(a,:);
r = (norm(p1 - p2)/2)*scaling;

%Whitening step
W1 = (K1-mean(K1))/std(K1);
W2 = (K2-mean(K2))/std(K2);

phase = phdiffmeasure(W1, W2);
absBF = 30*d*scaling*pi*r^2/phase;

end
