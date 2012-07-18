% Stock data import
[~, ~, tmp] = xlsread('stocks.csv');
global stocks
stocks = struct();
[r, c] = size(tmp);
for i = 1:r, % no header
    stocks.(tmp{i,1}).name = tmp{i,2};
    stocks.(tmp{i,1}).price = tmp{i,3};
    %stocks = setfield(stocks, tmp{r,1}, tmp{r,2});
end
clearvars tmp c i r 