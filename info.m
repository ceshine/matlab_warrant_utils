warrant = input('\nWarrant Symbol:  ', 's');
if strcmp(warrant, 'show') == 1,
    f = fields(warrants);
    fprintf('\n');
    for i = 1:numel(f),
        fprintf('%s  %s  %s %s\n', warrants.(f{i}).name, f{i}, warrants.(f{i}).spot, stocks.(warrants.(f{i}).spot).name);
    end
else
    warrant = strcat('w', warrant);

    if warrant(7) == 'P'
        [price, leverage] = getLeverage(warrant, 0);
        drawPriceToPriceChart(warrant, 0);
    else
        [price, leverage] = getLeverage(warrant, 1);
        drawPriceToPriceChart(warrant, 1);
    end
    
    fprintf('\nSpot Price for %s: %.2f\n', warrants.(warrant).spot, stocks.(warrants.(warrant).spot).price);
    fprintf('Warrant Price: %.2f\nLeverage: %.2f\n\n', price, leverage);
    
    upper = input('\nUpper Volatility:(0 to skip drawing, enter to use default)  ');
    if isempty(upper)
        upper = 1.03;
    elseif upper == 0
        return
    else
        upper = (100+upper)/100;
    end 


    lower = input('Lower Volatility:( enter to use default)  ');
    if isempty(lower)
        lower = 0.97;
    else
        lower = (100 - lower) / 100;
    end
    
    if warrant(7) == 'P'
        [upper_y, flat_y, lower_y] = drawPriceToTimeChart(warrant, upper, lower, 0);
    else
        [upper_y, flat_y, lower_y] = drawPriceToTimeChart(warrant, upper, lower, 1);
    end

    fprintf('7-day spot-up return: %.2f%%\n', upper_y(8)*100/flat_y(1) - 100);
    fprintf('7-day spot-down return: %.2f%%\n', lower_y(8)*100/flat_y(1) - 100);

end
