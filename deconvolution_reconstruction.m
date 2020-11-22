%% A deconvolution Reconstruction Scheme
% A 3D deconvolution scheme modified from SPIRAL-TAP by Z.H.Harmany et al.

%% Preprocess the uncensored data and Set some algorithm parameters

fprintf('* * * preprocessing the data and generating the forward model \n');

% translate the type of the data from cell to 3D matrix
totDetect = dataset{jj};                                         % read the data
[lr,lc] = size(totDetect);                                       % size of the picture
bin=1*10^(-9);                                                   % temporal resolution of the 3D matrix is 1ns, 
                                                                 % unit: s
MM = 4826000;
mm = 4806000;                                                    % the range of the data is from 4806000 ps--4826000 ps

y = preprocess_cell2matrix(MM, mm, lr, lc, bin, totDetect);      % turn the cell totDetect to a 3D matrix y 
                                                                 % with 1ns bin resolution

% ganerate the imaging forward model 
% according to the calibration of the imaging setup 
width=10^(-9);                                                   % the whole system jitter is 1ns
sigma=0.025/1400;                                                % the size of the light spot 
samplesize=0.015/1400/2;                                           % the size of the FoV
                                                                 % over 1400m range, 
                                                                 % the radii of the two above are 0.025m and 0.015m 
adjust_parameter = 0.5;                                          %  conmpensate for the practical experiment, we choose this value based on the result quality                                                              
                                                                 
blur=blurcal_3D(adjust_parameter*samplesize,bin,9,9,21,sigma,width);              % generate the 3D spatiotemporal kernel       
A = @(x) convn(x,blur,'same'); AT = @(x) convn(x,blur,'same');                    % construct the imaging forward model                              
        
% set parameters :
tautv = 0;
miniter = 1;
maxiter = 3;
stopcriterion = 3;
tolerance = 1e-8;
verbose = 10;        

    

%% Reconstruction with a convex solver modified from SPIRALTAP

fprintf('* * * reconstructing with a modified convex solver \n \n');

[recoveredSPIRALtv, iterationsSPIRALtv, objectiveSPIRALtv,...
reconerrorSPIRALtv, cputimeSPIRALtv] ...
         = SPIRALTAP3D_v1(y,A,tautv,...
            'noisetype','gaussian',...
            'penalty','TV',...
            'AT',AT,...    
            'maxiter',maxiter,...
            'Initialization',y,...
            'miniter',miniter,...
            'stopcriterion',stopcriterion,...
            'tolerance',tolerance,...
            'monotone',1,...
            'saveobjective',1,...
            'savereconerror',1,...
            'savecputime',1,...
            'savesolutionpath',0,...
            'truth',y,...
            'verbose',verbose);
        
reconstruction_result{ii,jj} = recoveredSPIRALtv;
y_raw{ii,jj} = y;
        

