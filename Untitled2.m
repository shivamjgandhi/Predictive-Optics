tic

K = fastK(im);
toc 

K = K.^-1;

tic
pcolor(K)
shading interp
colorbar

toc
