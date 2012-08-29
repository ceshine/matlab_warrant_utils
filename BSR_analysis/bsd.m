symbol = input('\nSymbol:  ');
broker = input('Broker Name: ', 's');
query_template = [ 'SELECT date, SUM(buy), SUM(sell), SUM(buy)-SUM(sell) ' ...
                   'FROM bsreport WHERE broker_id = (SELECT id FROM brokers WHERE name = "%s") AND company_id = %d ' ... 
                   'GROUP BY date;' ];

               
query_template_2 = [ 'SELECT date, high, low, open, close FROM twse_stock_prices WHERE company_id = %d;'];


scrsz = get(0, 'ScreenSize');
figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.8]);        
hold on

query = sprintf(query_template, broker, symbol);
result = sql_query(query);

query2 = sprintf(query_template_2, symbol);
prices = sql_query(query2);
HLOC = [cell2mat(prices(:,2)), cell2mat(prices(:,3)), cell2mat(prices(:,4)), cell2mat(prices(:,5))];

title_s = sprintf('BS Record of %s for %d', broker, symbol);
bsr_broker_bydate_chart([cell2mat(result(:,2)), cell2mat(result(:,3))*-1, cell2mat(result(:,4))], result(:,1), HLOC, title_s);


hold off