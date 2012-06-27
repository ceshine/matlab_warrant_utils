% Warrants data import
[~, ~, tmp] = xlsread('warrants.csv');
global warrants stocks;
warrants = struct();
[r, c] = size(tmp);
for i = 2:r,
    warrants.(tmp{i,1}) =  struct('spot', tmp{i,2}, 'name', tmp{i, 7},  'data', []);
    warrants.(tmp{i,1}).data = [tmp{i,3:5}, datenum(tmp{i,6})];
end
clearvars tmp c i r 