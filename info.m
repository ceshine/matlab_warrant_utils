while 1,
    warrant = input('\nWarrant Symbol:  ', 's');
    if strcmp(warrant, 'show') == 1,
        f = fields(warrants);
        fprintf('\n');
        for i = 1:numel(f),
            fprintf('%s  %s\n', f{i}, warrants.(f{i}).spot);
        end
    else
        warrant = strcat('w', warrant);
        [price, leverage] = getLeverage(warrant, 0);
        fprintf('\nSpot Price for %s: %.2f\n', warrants.(warrant).spot, stocks.(warrants.(warrant).spot));
        fprintf('Warrant Price: %.2f\nLeverage: %.2f\n\n', price, leverage);
        upper = input('\nUpper Volatility:(0 to skip drawing, enter to use default)  ');
        if isempty(upper)
            upper = 1.03;
        elseif upper == 0
            continue
        else
            upper = (100+upper)/100;
        end 
        
        
        lower = input('Lower Volatility:( enter to use default)  ');
        if isempty(lower)
            lower = 0.97;
        else
            lower = (100 - lower) / 100;
        end
        
        drawPriceChart(warrant, upper, lower, 1);
                
    end
end