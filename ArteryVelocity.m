%Artery
clc;    
close all;  
clear;  

%Get the frames
myPath= 'C:\Users\sjgandhi1998\Desktop\Images\102117-8'; %change myPath to correct path
cd(myPath)
fileNames = dir(fullfile(myPath, '*.bmp'));
C = cell(length(fileNames), 1);

for k = 25:74%length(fileNames) 
    filename = fileNames(k).name;
    C{k} = imread(filename);
    D(k-24,:,:) = cell2mat(C(k,:));
end

F = permute(D, [2 3 1]);

f = zeros(201,409,10);
f2 = zeros(201,409,50);

%Find K-Speckle Map within specific area across frames
for k = 1:50
    f(:,:,k) = im2double(F(450:650,880:1288,k));
    t = @(x) ((std(x(:))/(mean(x(:)))));
    f2(:,:,k) = nlfilter(f(:,:,k),[7 7],t);
    K2(:,:,k) = 1./transpose((mean(transpose(f2(61:141,270:369,k))))); %This is the velocity profile at point 2
    K(:,:,k) = 1./transpose((mean(transpose(f2(61:141,41:140,k))))); %This is the velocity profile at point 1
end

G = permute(K, [1 3 2]);
G2 = permute(K2, [1 3 2]);

%Find the flow waveforms at points 1 and 2 over the frames
for k = 1:50
    V2(k) = sum(G2(:,k))/81;
    V(k) = sum(G(:,k))/81;
end
z = 1:50;
T = 10;

%Convert K values to decorrelation time values (more accurate)
for k = 1:50
    syms x
    eqn = (exp(-2*T/x)-1+2*sqrt(T/x))/(2*(T/x)^2) == V(k);
    eqn2 = (exp(-2*T/x)-1+2*sqrt(T/x))/(2*(T/x)^2) == V2(k);        
    V(k) = solve(eqn,x);
    V2(k) = solve(eqn2,x);
end

%Use whitening to make the flow waveforms at points 1 and 2 comparable
W = (V-mean(V))/std(V);
W2 = (V2-mean(V2))/std(V2);

%Find the phase difference between the two waveforms
PhDiff = -1*phdiffmeasure(W,W2);

%Find the velocity. This is: (# pixels between points 1 and 2)*(pixel
%resolution)/((phase difference)*(1/(frames per second)))
Vel = (115*4)/(PhDiff*(1/30)*10^4);

%Display Velocity and plot flow waveforms over time
display(Vel)
plot(z,W,'k',z,W2,'r')
