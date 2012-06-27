function [ upper_y, flat_y, lower_y ] = drawPriceChart( warrant, upper_limit, lower_limit, call)
%DRAWPRICECHART Summary of this function goes here
%   Detailed explanation goes here
    global warrants stocks;
    obj  = warrants.(warrant);
    data = obj.data;
    strike_ratio = data(1);
    strike_price = data(2);
    mature_date = data(4);
    implied_volatility = data(3);
    spot_price = stocks.(obj.spot).price;


    date_axis = datenum(date):1:mature_date;
    flat_y = zeros(1, length(date_axis));
    upper_y = flat_y;
    lower_y = flat_y;
    upper = spot_price * upper_limit;
    lower = spot_price * lower_limit;
    
    % only do put for now
    for i = date_axis,
        idx = i - datenum(date) + 1;
        [c, Put] = blsprice(spot_price*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
        flat_y(idx) = Put;
        [c, Put] = blsprice(upper*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility); 
        upper_y(idx) = Put;
        [c, Put] = blsprice(lower*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-i+1)/365, implied_volatility);
        lower_y(idx) = Put;
    end
    
    
    hFig = figure(1);
    set(hFig, 'Position', [400 100 1000 800])

    plot(date_axis, upper_y, date_axis, flat_y, date_axis, lower_y);
    datetick('x', 'mm-dd', 'keeplimits', 'keepticks');
    legend(num2str([upper]), num2str([spot_price]), num2str([lower]));
    
    t = sprintf('Warrant: %s    Spot: %s\nMature: %s  Ratio: %.2f   Stike: %.2f', warrant, obj.spot, datestr(mature_date), strike_ratio, strike_price);
    title(t); 
end

