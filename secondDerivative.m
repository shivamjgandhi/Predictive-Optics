function D2 = secondDerivative(W)

[a, ~] = size(W);
D2 = W;
for i = 2:a-1
    D2(i) = W(i+1) - 2*W(i) + W(i-1);
%     if D2(i) > 0
%         D2(i) = 1;
%     else
%         D2(i) = 0;
%     end
end

end