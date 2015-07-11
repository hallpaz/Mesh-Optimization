function [time, relres, iter] = object_lsqr(name, lambda)
prefix = strcat(pwd, '/images/lsqr_');
prefix = strcat(prefix, name);
w = 1024;
h = 768;
fj = 1911;
fi = 1911;
cj = 913.867729;
ci = 387.910422;

% loading the measured normals and positions
filename = fullfile('../data/', name);
[z nj ni nz] = loadmesh(char(filename), w, h);
% your function "opt" should return the optimal positions "zopt"
[zopt, time, relres, iter] = opt(z, nj, ni, nz, w, h, fj, fi, cj, ci, lambda);
% finding the NEW j and i corresponding to each measured positions
[jopt, iopt] = meshxy(zopt, w, h, fj, fi, cj, ci);
% displaying the surface
figure(3)
showmesh(jopt, iopt, zopt)
im = getframe(gcf);
im = imresize(im.cdata, [600 800]);
imwrite (im, strcat(prefix, num2str(lambda) ), 'png');
end
% with normals
%figure(4)
%showmesh(jopt, iopt, zopt, nj, ni, nz)