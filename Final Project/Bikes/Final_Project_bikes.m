addpath('C:\Program Files\MATLAB\R2018a\toolbox\rivsid')
addpath('C:\Program Files\MATLAB\R2018a\toolbox\tdcont')
addpath('C:\Program Files\MATLAB\R2018a\toolbox\tvpmod')

%% load data
bikes_hour = readtable('Bikes\hour.csv');
bikes_day = readtable('Bikes\day.csv');
%% plot hour for week
clf; 
plot(bikes_hour.cnt)
title('Bike rentals by hour since midnight Jan.01,2011')
%% plot hour for month
clf;
plot([bikes_hour.cnt(1+720:720+720)])
%% plot day
clf; plot([bikes_day.cnt])
%% testing DHR on hours
% y=fcast(air, [84 94; 131 144]);
y = fcast(bikes_hour.cnt(1:720),[721 864]);
% y = bikes_hour.cnt(1:720);

P=[0 24./(1:8)];
TVP=1;
nar=36;

nvr=dhropt(y, P, TVP, nar)

[fit, fitse, trend, trendse, comp]=dhr(y, P, TVP, nvr);
%% plotting trend
clf
plot([trend(:, 1) y] )
% set(gca, 'xlim', [0 length(y)])
% title('Data and trend')
%% plotting seasonal0 seems to stay relatively constant
clf
plot(sum(comp'))
set(gca, 'xlim', [0 length(y)])
title('Total seasonal component')
%% plotting fit vs. actuals
clf
plot(fit, 'b')
hold on
plot(y, 'r')
title('Fit (blue) vs. Actuals (red)')