function [ call, put ] = customBls( spot_price, day_to_mature, strike_ratio, strike_price, implied_volatility)
%CUSTOMBLS Summary of this function goes here
%   Detailed explanation goes here
    [call, put] = blsprice(spot_price*strike_ratio, strike_price*strike_ratio , 0.0143, day_to_mature/365, implied_volatility);
end
