addpath('C:\Program Files\MATLAB\R2018a\toolbox\rivsid')
addpath('C:\Program Files\MATLAB\R2018a\toolbox\tdcont')
addpath('C:\Program Files\MATLAB\R2018a\toolbox\tvpmod')
%% Testing on own dataset
% CO data from https://www.kaggle.com/ucsandiego/carbon-dioxide/data
data = readtable('archive.csv');
co2=data.CarbonDioxide_ppm_; %trying it first on the whole data, as there is already some NaNs
%% plotting
clf; plot(co2)
title('Atmospheric CO2 in months since Jan. 1958')
%%
P=[0 12./(1:5)];
TVP=1;
nar=16;

nvr=dhropt(co2, P, TVP, nar)

[fit, fitse, trend, trendse, comp]=dhr(co2, P, TVP, nvr);
%% plotting trend
clf
plot([trend(:, 1) co2])
set(gca, 'xlim', [0 length(co2)])
title('Data and trend')

%% plotting seasonal0 seems to stay relatively constant
clf
plot(sum(comp'))
set(gca, 'xlim', [0 length(air)])
title('Total seasonal component')

%% plotting fit vs. actuals
clf
plot(fit, 'b')
hold on
plot(co2, 'r')
%% plotting residuals
clf
plot([fit-co2 zeros(length(co2), 1)], 'b')
%% plotting other things
clf
plot(fit, 'b')
hold on
plot(co2, 'ro')
plot([fit+2*fitse fit-2*fitse], ':b')
%% Trying out some interpoliation- seems pretty good
co2_int = fcast(co2, [84 94; 131 144; 550 590]);
P=[0 12./(1:5)];
TVP=1;
nar=16;

nvr=dhropt(co2_int, P, TVP, nar)

[fit, fitse, trend, trendse, comp]=dhr(co2_int, P, TVP, nvr);

clf
plot(fit, 'b')
hold on
plot(co2_int, 'r')