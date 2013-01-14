function [ up1_y, flat_y, lo1_y ] = drawPriceToTimeChart( warrant, upper_limit, lower_limit, call)
%DRAWPRICECHART Summary of this function goes here
% Detailed explanation goes here
    global warrants stocks;
    obj = warrants.(warrant);
    data = obj.data;
    strike_ratio = data(1);
    strike_price = data(2);
    mature_date = data(4);
    implied_volatility = data(3);
    spot_price = stocks.(obj.spot).price;


    date_axis = datenum(date):1:mature_date;
    flat_y = zeros(1, length(date_axis));
    up1_y = flat_y;
    up2_y = flat_y;
    lo1_y = flat_y;
    lo2_y = flat_y;
    up1 = round(spot_price * upper_limit * 10) / 10;
    lo1 = round(spot_price * lower_limit * 10) / 10;
    up2 = round(spot_price * (upper_limit+1) / 2 * 10) / 10;
    lo2 = round(spot_price * (lower_limit+1) / 2 * 10) / 10;
    
    if call
         for i = date_axis,
            idx = i - datenum(date) + 1;
            [c, Put] = blsprice(spot_price*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            flat_y(idx) = c;
            [c, Put] = blsprice(up1*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            up1_y(idx) = c;
            [c, Put] = blsprice(lo1*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            lo1_y(idx) = c;
            [c, Put] = blsprice(up2*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            up2_y(idx) = c;
            [c, Put] = blsprice(lo2*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            lo2_y(idx) = c;
        end
    else
        for i = date_axis,
            idx = i - datenum(date) + 1;
            [c, Put] = blsprice(spot_price*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            flat_y(idx) = Put;
            [c, Put] = blsprice(up1*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            up1_y(idx) = Put;
            [c, Put] = blsprice(lo1*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            lo1_y(idx) = Put;
            [c, Put] = blsprice(up2*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            up2_y(idx) = Put;
            [c, Put] = blsprice(lo2*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
            lo2_y(idx) = Put;
        end
    end
    
    hFig = figure(3);
    set(hFig, 'Position', [400 100 1000 800])

    plot(date_axis, up1_y, date_axis, up2_y, date_axis, flat_y, date_axis, lo2_y, date_axis, lo1_y);
    datetick('x', 'mm-dd', 'keeplimits', 'keepticks');
    legend(sprintf('%.1f   %.2f%%', up1, (up1/spot_price-1)*100), sprintf('%.1f   %.2f%%', up2, (up2/spot_price-1)*100), num2str([spot_price]), sprintf('%.1f   %.2f%%', lo2, (lo2/spot_price-1)*100), sprintf('%.1f   %.2f%%', lo1, (lo1/spot_price-1)*100));
    
    t = sprintf('Warrant: %s Spot: %s\nMature: %s Ratio: %.2f Stike: %.2f', warrant, obj.spot, datestr(mature_date), strike_ratio, strike_price);
    title(t);
end