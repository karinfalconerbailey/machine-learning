Rsquared = [0.2087;0.2273;0.;0.];
RMSE = [0.15;0.1482;0.;0.];
TrainError = [0.023;0.0206;0.;0.];
TrainAccuracy = [0.976;0.979;0.;0.];

Results = table(Model,Rsquared,RMSE,TrainError,TrainAccuracy);

fig = uifigure;
uit = uitable(uifigure,'ColumnWidth','fit');
info = {0.18,0.14835,0.0228,0.9773;0.22,0.14502,0.0220,0.9780;0.34(0.57),0.13377(0.10806),0.0183(0.0114),0.9817(0.9886);0.33(0.6),0.13441(0.10409),0.0174(0.0112),0.9826(0.9888)};
uit.Data = info;
uit.ColumnName = ["Linear model 01";"Linear model 02";"RF model 01: 10-Fold(Resubstitution)";"RF model 02: 10-Fold(Resubstitution)"];
uit.RowName = {'Rsquared', 'MSE', 'RMSE', 'TrainError', 'TrainAccuracy'};
s = uistyle('FontAngle','italic','FontColor',[],'BackgroundColor','#85ba72','FontWeight','normal','HorizontalAlignment','center')
addStyle(uit,s)