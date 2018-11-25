function D1 = firstDerivative(W)

[a, ~] = size(W);
D1 = zeros(a,1);
for i = 1:a-1
    D1(i) = W(i+1) - W(i);
%     if (D1(i) > 0)
%         D1(i) = 1;
%     else
%         D1(i) = 0;
%     end
end
D1(a) = W(a);

end