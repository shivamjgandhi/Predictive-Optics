function nextFrameCS = multiFrameCrossSection(im1, im2, pt)
pos = findSamePoint(pt, im1, im2);
nextFrameCS = CrossSectionDetection(im2, pos);
end