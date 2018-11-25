function imCell = CreateCell(pathName, amtImages)

myPath = strcat('C:\Users\sjgandhi1998\Desktop\Transfer\Images\', pathName);
cd(myPath)
P = string(pathName);
imCell = cell(amtImages, 1);
if (P == '102117-8')
    for i=1:amtImages
        num = string(24+i);
        order = strlength(num);
        prefix = "";
        for j=1:(5-order)
            prefix = strcat("0", prefix);
        end
        imCell(i,1) = {imread(char(strcat('MagLSCIFem8_s001t', prefix, num, ".bmp")))};
    end
elseif (P == '102217-5')
    for i=1:amtImages
        num = string(i);
        order = strlength(num);
        prefix = "";
        for j=1:(5-order)
            prefix = strcat("0", prefix);
        end
        M = imread(char(strcat('MagLSCICereb-5_s001t', prefix, num, ".bmp")));
        imCell(i,1) = {M(:,:,1)};
    end
elseif (P == '1152018-3')
    for i = 1:amtImages
        num = string(i);
        order = strlength(num);
        prefix = "";
        for j=1:(5-order)
            prefix = strcat("0", prefix);
        end
        imCell(i,1) = {imread(char(strcat('60bpm2mLcrooked_s001t', prefix, num, ".bmp")))};
    end
elseif (P == '1162018-2')
    for i = 1:amtImages
        num = string(i);
        order = strlength(num);
        prefix = "";
        for j=1:(5-order)
            prefix = strcat("0", prefix);
        end
        imCell(i,1) = {imread(char(strcat('10bpm2mLnomag_s001t', prefix, num, ".bmp")))};
    end
end

cd('C:\Users\sjgandhi1998\Desktop\Transfer\Images');

end