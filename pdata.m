% Warrants data import
[~, ~, tmp] = xlsread('warrants.csv');
global warrants stocks;
warrants = struct();
[r, c] = size(tmp);
for i = 2:r,
    warrants.(tmp{i,1}) =  struct('spot', tmp{i,2}, 'data', []);
    warrants.(tmp{i,1}).data = [tmp{i,3:5}, datenum(tmp{i,6})];
end

% Stock data import
[~, ~, tmp] = xlsread('stocks.csv');
stocks = struct();
[r, c] = size(tmp);
for i = 1:r, % no header
    stocks.(tmp{i,1}) = tmp{i,2};
    %stocks = setfield(stocks, tmp{r,1}, tmp{r,2});
end
clearvars tmp c i r 