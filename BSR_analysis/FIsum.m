function [] = FIsum(symbol)
    symbol = str2num(symbol);
    
    query_template = ['SELECT * FROM bssummary WHERE company_id = %d AND date > "2012-10-01";'];
    query_template_2 = [ 'SELECT date, high, low, open, close FROM prices WHERE symbol = %d AND date > "2012-10-01";'];
    query_template_3 = [ 'SELECT volume FROM bsvolume WHERE company_id = %d AND date > "2012-10-01";'];

    query = sprintf(query_template, symbol);
    result = sql_query(query);

    query2 = sprintf(query_template_2, symbol);
    prices = sql_query(query2);
    HLOC = [cell2mat(prices(:,2)), cell2mat(prices(:,3)), cell2mat(prices(:,4)), cell2mat(prices(:,5))];

    query3 = sprintf(query_template_3, symbol);
    volume = sql_query(query3);

    scrsz = get(0, 'ScreenSize');
    figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.6]);      

    hold on

    disp('Filtering');
    load('FIBrokers.mat');

    result = result(cellfun(@(x) ismember(x, FIBrokers(:,1)), result(:,3)), :);

    disp('Summing');
    result = sortrows(result, 7);

    n = size(result, 1);
    idx(1:n) = 1;
    idx(2:n) = ~strcmp(result(1:n-1,7),result(2:n,7));

    idx = cumsum(idx);
    buy = accumarray(idx', [result{:,4}]');
    sell = accumarray(idx', [result{:,5}]');
    net = buy - sell;

    disp('Drawing');
    title_s = sprintf('¥~¸ê¶R½æ for %d', symbol);
    bsr_pvsum_chart(buy, sell*-1, [volume{:}]', unique(result(:,7)), HLOC, title_s)

    hold off

    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 7]);
    savepath = sprintf('C:\\Cloud Storage\\Dropbox\\analysis\\%d', symbol);
    mkdir(savepath);
    print(gcf, '-dpng', fullfile(savepath,sprintf('FIsum.png')), '-r100');
end