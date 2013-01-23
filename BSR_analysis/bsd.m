function [] = bsd(symbol, broker)
    symbol = str2num(symbol);
    query_template = [ 'SELECT date, SUM(buy), SUM(sell), SUM(buy)-SUM(sell) ' ...
                       'FROM bsreport WHERE broker_id = (SELECT id FROM brokers WHERE name = "%s") AND company_id = %d ' ... 
                       'GROUP BY date;' ];


    query_template_2 = [ 'SELECT a.date, high, low, open, close FROM (SELECT date, high, low, open, close FROM prices WHERE symbol = %d) AS a '...
                          'JOIN (SELECT date FROM bsreport WHERE broker_id = (SELECT id FROM brokers WHERE name = "%s") AND company_id = %d GROUP BY date) AS b ON a.date = b.date;'];


    scrsz = get(0, 'ScreenSize');
    figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.8]);        
    hold on

    query = sprintf(query_template, broker, symbol);
    result = sql_query(query);

    query2 = sprintf(query_template_2, symbol, broker, symbol);
    prices = sql_query(query2);
    HLOC = [cell2mat(prices(:,2)), cell2mat(prices(:,3)), cell2mat(prices(:,4)), cell2mat(prices(:,5))];

    title_s = sprintf('BS Record of %s for %d', broker, symbol);
    bsr_broker_bydate_chart([cell2mat(result(:,2)), cell2mat(result(:,3))*-1, cell2mat(result(:,4))], result(:,1), HLOC, title_s);


    hold off

    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 7]);
    savepath = sprintf('C:\\Cloud Storage\\Dropbox\\analysis\\%d', symbol);
    mkdir(savepath);
    print(gcf, '-dpng', fullfile(savepath,sprintf('bsd-%s.png',broker)), '-r100');
end