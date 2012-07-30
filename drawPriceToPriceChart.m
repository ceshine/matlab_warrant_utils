function [ x_axis, y_axis ] = drawPriceToPriceChart( warrant, call)
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

    today = datenum(date);

    x_axis = round(spot_price)*0.7:0.25:round(spot_price)*1.3;
    y_axis = zeros(1, length(x_axis));

    [call, put]  = blsprice(spot_price*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-today+1)/365, implied_volatility); 
    warrant_c_price = put;
    
    % only do put for now
    for i = 1:length(x_axis),
        [call, put] = blsprice(x_axis(i)*strike_ratio, strike_price*strike_ratio , 0.0143, (mature_date-today+1)/365, implied_volatility);
        y_axis(i) = put/warrant_c_price;
    end
    
    clf
    hFig = figure(1);
    set(hFig, 'Position', [400 100 1000 800])

    plot(x_axis, y_axis);
    hold on;
    plot(spot_price, 1, 'r*');
    
    hFig = figure(2);
    set(hFig, 'Position', [400 100 1000 800])

    plot(x_axis, log(y_axis));
    hold on;
    plot(spot_price, 0, 'r*');
    
    t = sprintf('Warrant: %s Spot: %s Spot Price: %.2f\nMature: %s Ratio: %.2f Stike: %.2f', warrant, obj.spot, spot_price, datestr(mature_date), strike_ratio, strike_price);
    title(t);
end