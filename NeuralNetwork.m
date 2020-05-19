Location = 'TP_Regression_SUNY.xlsx';
[num, ~, ~] = xlsread(Location);

datalength = length(num);
CI = num(1:datalength, 1);
ghcnew = num(1:datalength, 2);
I_gh = num(1:datalength, 4);

%% Machine Learning
TestData=[CI, ghcnew];
inputs = TestData';
targets = I_gh';

% Create a Fitting Network
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);
% View the Network
view(net);

outputs=outputs';

%RMSE_Machine Learning
x_gh_ML = sum((outputs-I_gh).^2);
RMSE_gh_ML = sqrt(x_gh_ML/datalength);