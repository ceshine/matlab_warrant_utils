symbol = input('\nSymbol:  ');
broker = input('Broker Name: ', 's');
query_template = [ 'SELECT date, SUM(buy), SUM(sell), SUM(buy)-SUM(sell) ' ...
                   'FROM bsreport WHERE broker_id = (SELECT id FROM brokers WHERE name = "%s") AND company_id = %d ' ... 
                   'GROUP BY date;' ];
 
scrsz = get(0, 'ScreenSize');
figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.8]);        
hold on

query = sprintf(query_template, broker, symbol);
result = sql_query(query);

title_s = sprintf('BS Record of %s for %d', broker, symbol);
bsr_broker_bydate_chart([cell2mat(result(:,2)), cell2mat(result(:,3))*-1, cell2mat(result(:,4))], result(:,1), title_s);


hold off