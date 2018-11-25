p1 = '102117-8';
p2 = '102217-5';
p3 = '1152018-3';
p4 = '1162018-2';

prompt = 'How many images do you want to process? ';
num = input(prompt);

prompt2 = '1 for femoral, 2 for cerebral, 3 for test1, 4 for test2: ';
type = input(prompt2);

if type == 1
    imCell = CreateCell(p1, num);
elseif type == 2
    imCell = CreateCell(p2, num);
elseif type == 3
    imCell = CreateCell(p3, num);
elseif type == 4
    imCell = CreateCell(p4, num);
end

im1 = cell2mat(imCell(1));
imshow(im1)
[x,y] = getpts;
point = floor([y x]);
absBF = AbsoluteBloodFlow(imCell, point);
