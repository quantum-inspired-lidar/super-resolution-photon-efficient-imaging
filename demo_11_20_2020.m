%% demo recognized on Nov 20,2020

% Implements the framework presented in
% "Super-resolution single-photon imaging at 8.2 kilometers" Optics Express 28, 3, 2020
% By Zheng-Ping Li et al

% The super-resolution photon-efficient reconstruction algorithm 
% is a 3D deconvolution scheme modified from SPIRAL-TAP by Z.H.Harmany et al.

% For illustration purpose, we only show the experimental data within 20 ns (4806000 ps --- 4826000 ps), 
% where the target scene (mannequin) is located.

% Following is a simple demo for two datasets discussed in the manuscript:
% "data_night.mat", containing five mannequin postures captured at night;
% "data_daylight.mat", containing two mannequin postures captured in daylight.

% This demo loops for seven times to process two datasets mentioned above and plots the final results. 
% In each loop, "deconvolution_reconstruction.m" is peformed on the data.

clc; clear; close all;

%% Loop: loading and processing the data

filename{1} = 'data_night';
filename{2} = 'data_daylight';
addpath('./fcns');

for ii =1:2
    
    %load dataset
    load(['./data/' filename{ii}]);
    fprintf('* Loading the dataset %s \n \n', filename{ii});
    
    for jj = 1:length(dataset)
        
        fprintf('* * processing the %s posture %d with our proposed method \n', filename{ii}, jj);
        
        % reconstruction
        deconvolution_reconstruction; % our proposed reconstruction method
            
    end
    
    fprintf('* Finished processing the data %s with our proposed method \n \n \n', filename{ii});
    
end

    
    
%% Obtain a fine depth map from the recovered 3D matrix and plot the final results

gate_and_threshold;

figure('Name','Night datasets');
h1 = subplot(5,3,1); imagesc(depth_raw{1,1}(1:8:end,1:8:end), [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h2 = subplot(5,3,2); imagesc(depth_raw{1,1}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h3 = subplot(5,3,3); imagesc(depth_recovered{1,1}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;

h4 = subplot(5,3,4); imagesc(depth_raw{1,2}(1:8:end,1:8:end), [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h5 = subplot(5,3,5); imagesc(depth_raw{1,2}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h6 = subplot(5,3,6); imagesc(depth_recovered{1,2}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;

h7 = subplot(5,3,7); imagesc(depth_raw{1,3}(1:8:end,1:8:end), [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h8 = subplot(5,3,8); imagesc(depth_raw{1,3}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h9 = subplot(5,3,9); imagesc(depth_recovered{1,3}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;

h10 = subplot(5,3,10); imagesc(depth_raw{1,4}(1:8:end,1:8:end), [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h11 = subplot(5,3,11); imagesc(depth_raw{1,4}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h12 = subplot(5,3,12); imagesc(depth_recovered{1,4}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;

h13 = subplot(5,3,13); imagesc(depth_raw{1,5}(1:8:end,1:8:end), [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h14 = subplot(5,3,14); imagesc(depth_raw{1,5}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h15 = subplot(5,3,15); imagesc(depth_recovered{1,5}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;

title(h1, {'\fontsize{10}wo sub-pixel scan'});
title(h2, {'\fontsize{12}Night';'\fontsize{10}sub-pixel scan'});
title(h3, {'\fontsize{10}proposed method'});

figure('Name','Daylight datasets');
h1 = subplot(2,3,1); imagesc(depth_raw{2,1}(1:8:end,1:8:end), [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h2 = subplot(2,3,2); imagesc(depth_raw{2,1}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h3 = subplot(2,3,3); imagesc(depth_recovered{2,1}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;

h4 = subplot(2,3,4); imagesc(depth_raw{2,2}(1:8:end,1:8:end), [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h5 = subplot(2,3,5); imagesc(depth_raw{2,2}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;
h6 = subplot(2,3,6); imagesc(depth_recovered{2,2}, [0, 0.6]);axis image;axis off;colorbar;colormap jet;

title(h1, {'\fontsize{10}wo sub-pixel scan'});
title(h2, {'\fontsize{12}Daylight';'\fontsize{10}sub-pixel scan'});
title(h3, {'\fontsize{10}proposed method'});







