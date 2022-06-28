    %% *BASIC STATISTICS*     
    % _CODING FOR GENERATING BASIC STATISTICS_     

clear,clc

% Load honeyproduction.csv file into MatLab and save as data
data = readtable("honeyproduction.csv");

% Use the disp function to display all 626 rows
disp(data)

% Displays variables names within df
data.Properties.VariableNames(:)

% Start the data cleaning process by ensuring the data has complete
% observations
cleaned_data = ismissing(data,{'' '.' 'NA' 'NaN' '-99'});
missing_data = data(any(cleaned_data,2),:);
disp(missing_data)

% Find the mean value of each column
meanval = [mean(data.numcol)' mean(data.yieldpercol)' mean(data.totalprod)' mean(data.stocks)' mean(data.priceperlb)' mean(data.prodvalue)'];

% Find the median value of each column
med = [median(data.numcol)' median(data.yieldpercol)' median(data.totalprod)' median(data.stocks)' median(data.priceperlb)' median(data.prodvalue)'];

% Find the minimum value of each column
minimum = [min(data.numcol)' min(data.yieldpercol)' min(data.totalprod)' min(data.stocks)' min(data.priceperlb)' min(data.prodvalue)'];

% Find the maximum value of each column
maximum = [max(data.numcol)' max(data.yieldpercol)' max(data.totalprod)' max(data.stocks)' max(data.priceperlb)' max(data.prodvalue)'];

% Find the standard deviation of each column
stnd = [std(data.numcol)' std(data.yieldpercol)' std(data.totalprod)' std(data.stocks)' std(data.priceperlb)' std(data.prodvalue)'];

% Find the skew of each variable
skew = [skewness(data.numcol)' skewness(data.yieldpercol)' skewness(data.totalprod)' skewness(data.stocks)' skewness(data.priceperlb)' skewness(data.prodvalue)'];

% Create an empty table using uitable syntax, input data for cells, change
% column and row headings and customise table visualisation
uifigure;
uit = uitable(uifigure,'ColumnWidth','fit');
stats = {60284.35,26000,2000,510000,91077.09,2.7556; 62.01,60,19,136,19.46,0.692; 4169086.26,1533000,84000,46410000,6883846.75,2.89; 1318859.42,439500,8000,13800000,2272963.67,3.22; 1.41,1.36,0.5,4.15,0.64,1.19; 4715741.21,1841500,162000,69615000,7976109.77,3.832};
uit.Data = stats;
uit.ColumnName = {'Mean value', 'Median', 'Minimum', 'Maximum', 'Standard deviation',' Skew '};
uit.RowName = {'numcol', 'yieldpercol', 'totalprod', 'stocks', 'priceperlb', 'prodvalue'};
s = uistyle('FontAngle','italic','FontColor',[],'BackgroundColor','w','FontWeight','normal','HorizontalAlignment','center');
addStyle(uit,s)

% Create boxplot for each variable against 'year'
% Create boxplot for numcol
figure
boxplot(data.numcol,data.year,'BoxStyle','filled','Colors',[0.53 0.73 0.45],'OutlierSize',5,'Symbol','x:b','PlotStyle','traditional','MedianStyle','line');
xlabel('Year')
ylabel('Total colonies that produce honey')
title('Annual number of US honey producing colonies')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'boxplot01.jpg')

% Create boxplot for yieldpercol
figure
boxplot(data.yieldpercol,data.year,'BoxStyle','filled','Colors',[0.53 0.73 0.45],'OutlierSize',5,'Symbol','x:r','PlotStyle','traditional','MedianStyle','line');
xlabel('Year')
ylabel('Yield of honey per colony (lbs)')
title('Annual yield of honey per colony')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'boxplot02.jpg')

% Create boxplot for totalprod
figure
boxplot(data.totalprod,data.year,'BoxStyle','filled','Colors',[0.53 0.73 0.45],'OutlierSize',5,'Symbol','x:b','PlotStyle','traditional','MedianStyle','line');
xlabel('Year')
ylabel('Total quantity of honey produced (lbs)')
title('Annual quantity of honey produced')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'boxplot03.jpg')

% Create boxplot for stocks
figure
boxplot(data.stocks,data.year,'BoxStyle','filled','Colors',[0.53 0.73 0.45],'OutlierSize',5,'Symbol','x:r','PlotStyle','traditional','MedianStyle','line');
xlabel('Year')
ylabel('Mass of stocks held by producers (lbs)')
title('Annual quantity of honey held by producers')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'boxplot04.jpg')

% Create boxplot for priceperlb
figure
boxplot(data.priceperlb,data.year,'BoxStyle','filled','Colors',[0.53 0.73 0.45],'OutlierSize',5,'Symbol','x:b','PlotStyle','traditional','MedianStyle','line');
xlabel('Year')
ylabel('Average price of honey(lbs)')
title('Annual change in the average price of honey')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'boxplot05.jpg')

% Create boxplot for prodvalue
figure
boxplot(data.prodvalue,data.year,'BoxStyle','filled','Colors',[0.53 0.73 0.45],'OutlierSize',5,'Symbol','x:r','PlotStyle','traditional','MedianStyle','line');
xlabel('Year')
ylabel('Total value of production (USD|$)')
title('Annual value of production')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'boxplot06.jpg')

% Read csv data file as a matrix 
r = readmatrix('honeyproduction.csv');

% Index matrix that only numeric variables are included
matrix = r(1:626,2:7);
p_correlation = corrcoef(matrix); % Calculate Pearson's correlation coefficient
figure
map = heatmap(p_correlation);% Plot matrix coefficients as heatmap - adding axis labels
map.YDisplayLabels = {'numcol','yieldpercol','totalprod','stocks','priceperlb','prodvalue'};
map.XDisplayLabels = {'numcol','yieldpercol','totalprod','stocks','priceperlb','prodvalue'};
map.Title = {'Pearson Correlation Matrix'};
colormap('parula');
colorbar;
saveas(gcf,'corrheatmap.jpg');

% Close all open figures
close all;

% Predictive modelling

% change the order in the order (indexing) of the variables
m = array2table((matrix),'VariableNames',{'numcol','yieldpercol','totalprod','stocks','priceperlb','prodvalue'});
M = m(:,{'yieldpercol','numcol','totalprod','stocks','priceperlb','prodvalue'});

% Normalize feature scaling
M.yieldpercol = (M.yieldpercol - min(M.yieldpercol))/(max(M.yieldpercol)-min(M.yieldpercol));
M.numcol = (M.numcol - min(M.numcol))/(max(M.numcol)-min(M.numcol));
M.totalprod = (M.totalprod - min(M.totalprod))/(max(M.totalprod)-min(M.totalprod));
M.stocks = (M.stocks - min(M.stocks))/(max(M.stocks)-min(M.stocks));
M.priceperlb = (M.priceperlb - min(M.priceperlb))/(max(M.priceperlb)-min(M.priceperlb));
M.prodvalue = (M.prodvalue - min(M.prodvalue))/(max(M.prodvalue)-min(M.prodvalue));

% Partition data for training and testing: 75% training, 25% testing.
cv = cvpartition(size(M,1),'Holdout',0.25);
datatrain = M(cv.training,:);
datatest = M(cv.test,:);

% turn 'M' into a matrix and then into a column vector to use histfit
% function
P = m{:,:}; 
Vect = P';
Q = reshape(Vect,[],1);

% Fit of distribution
figure 
histfit(Q)
histdistrubtion = fitdist(Q, 'Normal');
xlabel('Variables')
ylabel('Frequency')
title('Distribution of variables')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'hist01.jpg')

% Create variables to fit regression models
X1 = [datatrain.prodvalue, datatrain.stocks, datatrain.priceperlb];
X2 = [datatrain.totalprod, datatrain.stocks, datatrain.priceperlb];
Y = datatrain.yieldpercol;

% Close all open figures
close all;

%% Linear model 01

% Build linear regression model number 01
model01 = fitlm(X1,Y,'linear','RobustOpts','off');

% plot MLR model 01
figure
plot(model01)
xlabel('Adjusted model 01')
ylabel('Adjusted YIELDPERCOL')
title('Added variable plot for model 01')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'mdl01kfold.jpg')

% Cross validating model 01 
cvmodel01 = fitrlinear(X1,Y,'Crossval','on'); % by default uses 10-fold
trainerror01 = kfoldLoss(cvmodel01);
trainaccuracy01 = 1-trainerror01;
MLR01 = kfoldPredict(cvmodel01);

figure;
plot(MLR01)

% plot residuals of MLR model 01
figure
plotResiduals(model01)
title('Histogram of residuals for model 01')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'mdl01res.jpg')

% Compute the model's summary
model01.Rsquared % r-squared
model01.MSE % mean square error
model01.RMSE % root mean square error

% Close all open figures
close all;
%% MLR 10-fold cross validation

% Build linear regression model number 02
model02 = fitlm(X2,Y,'linear','RobustOpts','off');

% plot MLR model 02
figure
plot(model02)
xlabel('Adjusted model 02')
ylabel('Adjusted YIELDPERCOL')
title('Added variable plot for model 02')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'mdl02kfold.jpg')

% Cross validating model 02
cvmodel02 = fitrlinear(X2,Y,'Crossval','on'); % by default uses 10-fold
trainerror02 = kfoldLoss(cvmodel02);
trainaccuracy02 = 1-trainerror02;
MLR02 = kfoldPredict(cvmodel02);

figure;
plot(MLR02)
xlabel('Totalprod, Stocks and Priceperlb')
ylabel('Yieldpercol')
title('Predicting model 02')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'mdl02predict.jpg')

% plot residuals of MLR model 02
figure
plotResiduals(model02)
title('Histogram of residuals for model 02')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'mdl02res.jpg')

% Compute the model's summary
model02.Rsquared % r-squared
model02.MSE % mean square error
model02.RMSE % root mean square error

% Close all open figures
close all;
%% Random forest (X1,Y)

% Build random forest model
RFtrainerror = templateTree('MinLeafSize', 8);
model03 = fitrensemble(X1,Y,'Method','Bag','NumLearningCycles',30,'Kfold',10,'Learners',RFtrainerror); %RF model with 10-fold cross validation
model03b = fitrensemble(X1,Y,'Method','Bag','NumLearningCycles',30,'Learners',RFtrainerror); 

% Cross validating model 03
trainerrorK03 = kfoldLoss(model03);
trainaccuracyK03 = 1-trainerrorK03;
RF01 = kfoldPredict(model03);

% Resubstitution
trainerrorR03 = resubLoss(model03b);
trainaccuracyR03 = 1-trainerrorR03;
Yfit03 = resubPredict(model03b);
L = loss(model03b,X1,Y);
validationRMSE1 = sqrt(resubLoss(model03b, 'LossFun', 'mse'));

figure
plot(RF01);

% Close all open figures
close all;
%% Random forest (X2,Y)

% Build random forest model
Tt = templateTree('MinLeafSize', 8);
model04 = fitrensemble(X2,Y,'Method','Bag','NumLearningCycles',30,'Kfold',10,'Learners',Tt); % includes 10-fold ross validation
model04b = fitrensemble(X2,Y,'Method','Bag','NumLearningCycles',30,'Learners',Tt); % model for resubstitution cross validation

% Cross validating model 04
trainerrorK04 = kfoldLoss(model04);
trainaccuracyK04 = 1-trainerrorK04;
RF02 = kfoldPredict(model04);

% Resubstitution
trainerrorR04 = resubLoss(model04b);
trainaccuracyR04 = 1-trainerrorR04;
Yfit04 = resubPredict(model04b);
L1 = loss(model04b,X2,Y);
validationRMSE2 = sqrt(resubLoss(model04b, 'LossFun', 'mse'));

figure
plot(MLR02)
hold on
plot(RF02);
xlabel('Totalprod, Stocks and Priceperlb')
ylabel('Yieldpercol')
title('Predicting model 02')
legend('MLR model','Random Forest model')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'mdlpredictions.jpg')

% Close all open figures
close all;
%% Results table

fig = uifigure;
uit = uitable(uifigure,'ColumnWidth','fit');
final = {0.18,0.22,0.34,0.57,0.33,0.6; 0.14835,0.14502,0.13377,0.10806,0.13441,0.10409; 0.0228,0.0220,0.0183,0.0114,0.0174,0.0112; 0.9773,0.9780,0.9817,0.9886,0.9826,0.98880};
uit.Data = final;
uit.ColumnName = ["Linear model 01";"Linear model 02";"RF model 01: 10-Fold";"RF model 01: Resubstitution";"RF model 02: 10-Fold";"RF model 02: Resubstitution"];
uit.RowName = {'Rsquared','RMSE', 'TrainError', 'TrainAccuracy'};
s = uistyle('FontAngle','italic','FontColor',[],'BackgroundColor','w','FontWeight','normal','HorizontalAlignment','center');
addStyle(uit,s)
%% Final test

datatestX = [datatest.totalprod, datatest.stocks, datatest.priceperlb];
datatestY = [datatest.yieldpercol];

% Build final linear regression model
MLRfinal = fitlm(datatestX,datatestY,'linear','RobustOpts','off');

% Plot final MLR model
figure
plot(MLRfinal)
xlabel('Adjusted final MLR model')
ylabel('Adjusted yieldpercol')
title('Added variable plot for MLR final model')
set(gca,'Fontsize',9)
set(0,'DefaultAxesTitleFontWeight','normal')
saveas(gcf,'MLRfinal.jpg')

% Kfold cross validation
cvfinalmdlm = fitrlinear(datatestX,datatestY,'CrossVal','on');
MLRtesterror = kfoldLoss(cvfinalmdlm);
testaccuracy = 1-MLRtesterror;
MLRfinalpredict = kfoldPredict(cvfinalmdlm);

MLRfinal.Rsquared
MLRfinal.RMSE

% Build random forest model
Tt = templateTree('MinLeafSize', 5);
RFfinalmodel = fitrensemble(datatestX,datatestY,'Method','Bag','NumLearningCycles',25,'Learners',Tt); % model for resubstitution cross validation

% Resubstitution
RFtesterror = resubLoss(RFfinalmodel);
testaccuracyRF = 1-RFtesterror;
Yfit = resubPredict(RFfinalmodel);
RFvalidation = sqrt(resubLoss(RFfinalmodel, 'LossFun', 'mse'));

figure
plot(MLRfinalpredict)
hold on
plot(Yfit);
xlabel('Totalprod, Stocks and Priceperlb')
ylabel('Yieldpercol')
title('Final model')
legend('MLR model','Random Forest model')
set(gca,'FontSize',9)
set(0,'DefaultAxesTitleFontWeight','normal');
saveas(gcf,'mdlfinal.jpg')
%%

fig = uifigure;
uit = uitable(uifigure,'ColumnWidth','fit');
final = {0.2616,0.32;0.13308,0.14015;0.0191,0.0104;0.9809,0.9896};
uit.Data = final;
uit.ColumnName = ["Linear final model","RF final model"];
uit.RowName = {'Rsquared','RMSE', 'TestError', 'TestAccuracy'};
s = uistyle('FontAngle','italic','FontColor',[],'BackgroundColor','w','FontWeight','normal','HorizontalAlignment','center');
addStyle(uit,s)