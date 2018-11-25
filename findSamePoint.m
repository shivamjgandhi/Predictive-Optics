function pos = findSamePoint(position, im1, im2)

subSquare1 = im1(position(1)-5:position(1)+5, position(2)-5:position(2)+5);
subSquarePos1 = [position(1)+5 position(1)-5 position(2)+5 position(2)-5];
subSquare2 = im2(position(1)-15:position(1)+15, position(2)-15:position(2)+15);
subSquarePos2 = [position(1)+15 position(1)-15 position(2)+15 position(2)-15];
c = normxcorr2(subSquare1, subSquare2);
[max_c, imax] = max(abs(c(:)));
[ypeak, xpeak] = ind2sub(size(c),imax(1));
corr_offset = [(xpeak-size(subSquare1,1))
    (ypeak-size(subSquare1,2))];
rect_offset = [10; 10];

offset = corr_offset + rect_offset;

pos = position + offset;

end
