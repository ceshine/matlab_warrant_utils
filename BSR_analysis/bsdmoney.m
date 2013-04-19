function [] = bsdmoney(symbol, broker)
    symbol = str2num(symbol);
    query_template = [ 'SELECT date, mbuy, msell, mnet ' ...
                       'FROM bsmoney WHERE broker_id = (SELECT id FROM brokers WHERE name = "%s") AND company_id = %d; ' ];


    query_template_2 = [ 'SELECT a.date, high, low, open, close FROM (SELECT date, high, low, open, close FROM prices WHERE symbol = %d) AS a '...
                          'JOIN (SELECT date FROM bsreport WHERE broker_id = (SELECT id FROM brokers WHERE name = "%s") AND company_id = %d GROUP BY date) AS b ON a.date = b.date;'];

    query_template_3 = [ 'SELECT SUM(tbuy), SUM(tsell), SUM(tnet) ' ...
                       'FROM bssummary WHERE broker_id = (SELECT id FROM brokers WHERE name = "%s") AND company_id = %d; ' ];
                   
    query = sprintf(query_template, broker, symbol);
    result = sql_query(query);

    query2 = sprintf(query_template_2, symbol, broker, symbol);
    prices = sql_query(query2);
    HLOC = [cell2mat(prices(:,2)), cell2mat(prices(:,3)), cell2mat(prices(:,4)), cell2mat(prices(:,5))];

    
    query3 = sprintf(query_template_3, broker, symbol);
    tposition = sql_query(query3);
    balance = sum(cell2mat(result(:,4)));

    position = tposition{3};
    price = prices{end,5};
    net = price*position-balance;
    avg = net/((tposition{1}+tposition{2})/2)*1000;
    disp(sprintf('Position: %.0f\tCash:%.0f\tPrice:%.2f\nNet:%.0f\t\tAverage Net:%.0f', position/1000, balance/1000, price, net, avg));
    
    %scrsz = get(0, 'ScreenSize');
    %figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.8]);        
    
    %hold on
    %title_s = sprintf('BSMoney(Million) Record of %s for %d', broker, symbol);
    %bsr_broker_bydate_chart([cell2mat(result(:,2))*0, cell2mat(result(:,3))*0, cell2mat(result(:,4))]/1000, result(:,1), HLOC, title_s);
    %hold off

    %set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 7]);
    %savepath = sprintf('C:\\Cloud Storage\\Dropbox\\analysis\\%d', symbol);
    %mkdir(savepath);
    %print(gcf, '-dpng', fullfile(savepath,sprintf('bsdmoney-%s.png',broker)), '-r100');

end

