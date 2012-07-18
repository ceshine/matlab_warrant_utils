if (exist('conn', 'var') == 0 || isconnection(conn) ~= 1),
    trade_log_db
else
    try
        ping(conn)
    catch err
        trade_log_db
    end
end

size_scale = 30;

symbol = input('Input warrant symbol: ', 's');
query = sprintf('SELECT time, name, volume, price FROM stock_trading WHERE symbol = "%s"', symbol);
while 1,
    try
        result = fetch(conn, query);
        break
    catch err
        trade_log_db
    end
end
tlog = cell2struct(result, {'time', 'name', 'volume', 'price'}, 2);

%colors = ones(length(log),1);
%colormap spring 
clf
hFig = figure(1);
set(hFig, 'Position', [400 100 1000 800])


idx = ([tlog.volume] > 0)';
buylog = tlog(idx);
%plot([cellfun(@(x)datenum(x), {buylog.time})]',[buylog.price]')
scatter(cellfun(@(x)datenum(x), {buylog.time})',[buylog.price]',[buylog.volume]'/size_scale, 'red', 'filled', 'MarkerEdgeColor', 'white');

tmp = cellfun(@(x)datenum(x), {tlog.time})';
xlim([min(tmp)-3, max(tmp)+3]);
set(gca, 'XTick', unique(tmp));

datetick('x', 'mmdd', 'keeplimits', 'keepticks');

hold on
grid on

idx = ([tlog.volume] < 0)';
selllog = tlog(idx);
scatter(cellfun(@(x)datenum(x), {selllog.time})',[selllog.price]',[selllog.volume]'/(-1*size_scale),'green', 'filled', 'MarkerEdgeColor', 'white');

inventory = sum([tlog.volume]);
net_worth = sum([tlog.price] .* [tlog.volume]);

t = sprintf('Warrant: %s \nInventory: %d    Net Worth: %.0f', symbol, inventory, net_worth);
title(t); 

