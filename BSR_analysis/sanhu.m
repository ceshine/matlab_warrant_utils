symbol = input('Symbol:  ');

%from_d = input('\nFrom Date: ', 's');
%to_d = input('\nUntil Date: ', 's');
query_template = [ 'SELECT date, COUNT(broker_id) '...
                   'FROM bssummary '...
                   'WHERE company_id = %d '...
                   'GROUP BY date' ];
 
query_template_2 = [ 'SELECT date, high, low, open, close FROM twse_stock_prices WHERE company_id = %d;'];

scrsz = get(0, 'ScreenSize');
figure('Position', [50 100 scrsz(3)*0.7 scrsz(4)*0.6]);        

hold on

query = sprintf(query_template, symbol);
result = sql_query(query);

query2 = sprintf(query_template_2, symbol);
prices = sql_query(query2);
HLOC = [cell2mat(prices(:,2)), cell2mat(prices(:,3)), cell2mat(prices(:,4)), cell2mat(prices(:,5))];

title_s = sprintf('Daily Top 15/15 ¥D¤O for %d', symbol);
bsr_sanhu_chart(cell2mat(result(:,2)), cell2mat(result(:,1)), HLOC, title_s)


hold off

 editmenufcn(gcf,'EditCopyFigure');