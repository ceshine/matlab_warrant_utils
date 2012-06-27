warrant = input('\nWarrant Symbol:  ', 's');
ddate = input('Target Date(YYYY-MM-DD): ', 's');

tdate = datenum(ddate);

warrant = strcat('w', warrant);

obj  = warrants.(warrant);
data = obj.data;
strike_ratio = data(1);
strike_price = data(2);
mature_date = data(4);
implied_volatility = data(3);
spot_price = stocks.(obj.spot).price;

fprintf('\nSpot Price for %s: %.2f\n', warrants.(warrant).spot, stocks.(warrants.(warrant).spot).price);
price = input('Target Spot Price: ');
fprintf('Change of Spot Price: %.2f%%\n\n', (price-spot_price)/spot_price*100);


[tmp, tprice] = customBls(price, mature_date - tdate + 1, strike_ratio, strike_price, implied_volatility);
[tmp, cprice] = customBls(spot_price, mature_date - datenum(date) + 1, strike_ratio, strike_price, implied_volatility);


fprintf('Target Warrant Price: %.2f\n', tprice);
fprintf('Current Warrant Price: %.2f\n', cprice);
fprintf('Change of Warrant Price: %.2f%%\n', (tprice-cprice)/cprice*100);