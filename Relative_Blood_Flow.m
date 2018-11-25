clc
clear
%1. 7x7 panel calculations done here
myPath = 'C:\Users\sjgandhi1998\Desktop\Images\102217-5';
cd(myPath)
fileNames = dir(fullfile(myPath, '*.bmp'));
C = cell(length(fileNames), 1);

for k = 1:1
    filename = fileNames(k).name;
    C{k} = imread(filename);
    D(k,:,:) = cell2mat(C(k,:));
end

F = permute(D, [2 3 1]);
[m,n,t] = size(F);
f = zeros(m,n,t);
K = zeros(m,n,1);

%Perform sliding window operation (nlfilter command) accross frames. 
%The value assigned to each central pixel within the sliding window is std/mean
%instensity
for k = 1:1
    f(:,:,k) = im2double(F(:,:,k));
    t = @(x) ((std(x(:))/(mean(x(:)))));
    K(:,:,k) = nlfilter(f(:,:,k),[5 5],t);
end

imshow(K(:,:,1))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2. Boundary detection for the vessels

%If a pixel's whiteness is higher than the 
%surrounding pixels' whiteness values, then
%turn all the pixels around it to a 1. Otherwise,
%turn it into a 0
% 
% I = imread('102217-5/MagLSCICereb-5_s001t00300.bmp');
% [a,b] = size(I);
% newI = ones(a,b);
% thresh = 30;
% for i = 3:a-2
%     for j = 3:b-2
%         if (I(i,j) - I(i,j-1) > thresh) || (I(i,j) - I(i,j+1) > thresh)...
%                 || (I(i+1,j) - I(i,j-1) > thresh)...
%                 || (I(i,j) - I(i-1,j) > thresh)
%             newI(i,j) = 0;
%             newI(i+1, j) = 0;
%             newI(i+2, j) = 0;
%             newI(i-1, j) = 0;
%             newI(i-2, j) = 0;
%             newI(i, j-1) = 0;
%             newI(i, j-2) = 0;
%             newI(i, j+1) = 0;
%             newI(i, j+2) = 0;
%             newI(i+1, j+1) = 0;
%             newI(i+1, j-1) = 0;
%             newI(i-1, j+1) = 0;
%             newI(i-1, j-1) = 0;
%         end
%     end
% end
% 
% B = [1 1; 1 1];
% C = conv2(newI, B);
% D = zeros(size(C));
% for i = 3:a-2
%     for j = 3:b-2
%         if C(i,j) >= 3
%             D(i,j) = 1;
%         else
%             C(i,j) = 0;
%         end
%     end
% end
% 
% imshow(edge(D))

%Edge Detection
%imshow(newI)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3. Assign categories based on part 1

%4. Re-map images based on categories
