function [velocityProfile] = returnVelocities(crossSection, K)

[a,~] = size(crossSection);
velocityProfile = zeros(a, 1);
for i=1:a
    velocityProfile(i) = K(crossSection(i, 1), crossSection(i, 2));
end

end
