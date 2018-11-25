function K2 = doubleToUINT(K)
K2 = uint8(floor(K*256/max(max(K))));
end