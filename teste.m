% setting the parameters
w = 1024;
h = 768;
fj = 1911;
fi = 1911;
cj = 913.867729;
ci = 387.910422;
lambda = 0.1;
% loading the measured normals and positions
[z nj ni nz] = loadmesh('panel', 1024, 768);
% finding the j and i corresponding to each measured positions
[j i] = meshxy(z, w, h, fj, fi, cj, ci);
% displaying the surface
figure(1)
showmesh(j, i, z)
% with normals
figure(2)
showmesh(j, i, z, nj, ni, nz)
% your function "opt" should return the optimal positions "zopt"
zopt = opt(z, nj, ni, nz, w, h, fj, fi, cj, ci, 0.1);
% finding the NEW j and i corresponding to each measured positions
[jopt iopt] = meshxy(zopt, w, h, fj, fi, cj, ci);
% displaying the surface
figure(3)
showmesh(jopt, iopt, zopt)
% with normals
figure(4)
showmesh(jopt, iopt, zopt, nj, ni, nz)