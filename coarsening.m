function C = coarsening(K)

[a,b] = size(K);
ip = floor(a/2);
jp = floor(b/2);
C = zeros(ip, jp);
K = double(K);
% for i = 2:ip-1
%     for j = 2:jp-1
%         C(i,j) = floor(1/5*(K(2*i,2*j) + K(2*i+1,2*j) + K(2*i-1,2*j)...
%             + K(2*i,2*j+1) + K(2*i,2*j-1)));
%     end
% end

for i = 2:ip-1
    for j = 2:jp-1
        C(i,j) = max([K(2*i,2*j), K(2*i+1, 2*j), K(2*i-1, 2*j),...
            K(2*i, 2*j+1), K(2*i, 2*j-1)]);
    end
end

C = uint8(C);

end