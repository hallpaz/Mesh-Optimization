function [zopt, time, relres, iter ] = opt(z, nj, ni, nz, w, h, fj, fi, cj, ci, lambda)

not_nans = ~isnan(z);
border = bwperim(not_nans);
[J, I] = meshgrid(1:w, 1:h);

%% Top Matrix (position conformity)
MI = sqrt(((J - cj)/fj).^2 + ((I - ci)/fi).^2 + 1);
z_trim = lambda*MI.*z;
z_trim = z_trim( not_nans(:) );

MI = MI( not_nans(:) );
top_matrix = spdiags( lambda*MI, 0, length(MI), length(MI) );

%% Middle Matrix (Tangent I conformity )
supdiag = nj.*((cj - J)/(2*fj)) + ni.*((ci - I)/(2*fi)) + nz/2;
supdiag = supdiag( not_nans(:) );

maindiag = (-1/fi)*ni;
maindiag = maindiag( not_nans(:) );

middle_matrix = sparse( ...
    [2:length(maindiag) 1:length(maindiag) 1:(length(maindiag)-1) ],...
    [1:(length(maindiag)-1) 1:(length(maindiag)) 2:length(maindiag)],...
    [-supdiag(2:end)' maindiag' supdiag(1:end-1)'],...
    length(maindiag), length(maindiag) );

middle_matrix( find( border(not_nans(:) ) ), : )  = [];
middle_matrix = (1-lambda)*middle_matrix;

%% Bottom Matrix (Tangent J conformity )
%for j direction, matrix form is a little bit more complicated.
% fortunatelly, we still have only 3 values per row and they are quite the
% sames. We'll use a trick, we will compute the indexes as if the matrix
% were dense, then we'll trimm the matrix to our real needs.

supdiag = nj.*((cj - J)/(2*fj)) + ni.*((ci - I)/(2*fi)) + nz/2;
supdiag = supdiag( not_nans(:) );
maindiag = (-1/fj)*nj;
maindiag = maindiag( not_nans(:) );

% Data Trimm
maindiag( find( border( not_nans(:) ) ) ) = [];
supdiag( find( border( not_nans(:) ) ) ) = [];
% Full index computation
index = reshape(1:w*h, h, w);
index = index( not_nans(:) );
index( find( border( not_nans(:) ) )  ) = [];

bottom_matrix = sparse( ...
    [index index index ],...
    [index-h index index+h],...
    [-supdiag' maindiag' supdiag'],...
    w*h, w*h );
% Matrix trimm
bottom_matrix( ~not_nans, :) = [];
bottom_matrix(:, ~not_nans) = [];
bottom_matrix( find( border( not_nans(:) ) ), : ) = [];

%% System Assemblage

victory = [top_matrix; middle_matrix; bottom_matrix ];
b = [ sparse(z_trim); ...
    sparse(size(middle_matrix, 1), 1 );...
    sparse(size(bottom_matrix, 1), 1 ) ];

%% System Solution using LSQR
tic
[optimized ,~, relres, iter] = lsqr(victory, b);
time = toc

%% Matrix Reconstitution
zopt = nan(h,w);
zopt(not_nans) = optimized;

end