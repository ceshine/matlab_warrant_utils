for i = 1:length(symbols),
    formatOut = 'yyyy-mm-dd';
    ddate = datestr(now,formatOut);
    %ddate = '2013-01-02';
    symbol = num2str(symbols(i));
    pvsum15(symbol)
    stop15(symbol,ddate)
    FIsum(symbol)
    %close
    %LIsum15(symbol)
    %close
end

    