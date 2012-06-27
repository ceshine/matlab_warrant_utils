if exist('conn') == 0 || isconnection(conn) ~= 1,
    trade_log_db
end

size_scale = 30;

symbol = input('Input warrant symbol: ', 's');
query = sprintf('SELECT time, name, volume, price FROM stock_trading WHERE symbol = "%s"', symbol);
result = fetch(conn, query);
log = cell2struct(result, {'time', 'name', 'volume', 'price'}, 2);

%colors = ones(length(log),1);
%colormap spring 
clf
hFig = figure(1);
set(hFig, 'Position', [400 100 1000 800])


idx = ([log.volume] > 0)';
buylog = log(idx);
%plot([cellfun(@(x)datenum(x), {buylog.time})]',[buylog.price]')
scatter(cellfun(@(x)datenum(x), {buylog.time})',[buylog.price]',[buylog.volume]'/size_scale, 'red', 'filled', 'MarkerEdgeColor', 'white');

tmp = cellfun(@(x)datenum(x), {log.time})';
xlim([min(tmp)-3, max(tmp)+3]);
set(gca, 'XTick', unique(tmp));

datetick('x', 'mmdd', 'keeplimits', 'keepticks');

hold on
grid on

idx = ([log.volume] < 0)';
selllog = log(idx);
scatter(cellfun(@(x)datenum(x), {selllog.time})',[selllog.price]',[selllog.volume]'/(-1*size_scale),'green', 'filled', 'MarkerEdgeColor', 'white');
