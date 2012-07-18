function [ price, leverage ] = getLeverage( warrant, call)
%GETLEVERAGE Return the price and actual leverage for given warrant
%   Detailed explanation goes here
    global warrants stocks;

    obj  = warrants.(warrant);
    data = obj.data;
    ratio = data(1);
    strike_price = data(2);
    mature_date = data(4);
    implied_volatility = data(3);
    [CP, PP] = customBls( stocks.(obj.spot).price, mature_date - datenum(date) + 1, ratio, strike_price, implied_volatility);    
    if call == true,
        price = CP;
    else 
        price = PP;
    end
    [CD, PD] = customBlsDelta( stocks.(obj.spot).price,  mature_date - datenum(date) + 1, ratio, strike_price, implied_volatility);  
    if call == true,
       leverage = stocks.(obj.spot).price * data(1) * CD / price;
    else 
       leverage = stocks.(obj.spot).price * data(1) * PD / price;
    end    
end


function [ CD, PD ] = customBlsDelta( spot_price, day_to_mature, strike_ratio, strike_price, implied_volatility)
%CUSTOMBLS Summary of this function goes here
%   Detailed explanation goes here
    [CD, PD] = blsdelta(spot_price*strike_ratio, strike_price*strike_ratio , 0.0143, day_to_mature/365, implied_volatility);
end