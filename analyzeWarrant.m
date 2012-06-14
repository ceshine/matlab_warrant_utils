function [ output_args ] = analyzeWarrant( warrant, upper_vol, lower_vol)
    global warrants stocks
%   ANALYZEWARRANT Summary of this function goes here
%   Detailed explanation goes here
    obj  = warrants.(warrant);
    data = obj.data;
    upper_limit = 1 + upper_vol/100;
    lower_limit = 1 - lower_vol/100;
    drawPriceChart( stocks.(obj.spot), data(3), data(4), data(1), data(2), upper_limit, lower_limit);
    t = sprintf('Warrant: %s    Spot: %s\nMature: %s  Ratio: %f   Stike: %f', warrant, obj.spot, datestr(data(4)), data(1), data(2));
    title(t); 
end
