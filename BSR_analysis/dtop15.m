symbol = input('\nSymbol:  ');
from_d = input('From Date: ', 's');
to_d = input('Until Date: ', 's');
query_template = [ 'SELECT id, name, sbuy, ssell, snet FROM (SELECT broker_id, SUM(tbuy) AS sbuy, SUM(tsell) AS ssell, SUM(tnet) AS snet FROM bstop15 '...
        'WHERE company_id = %d AND date >= "%s" AND date <= "%s" AND tnet %s 0 GROUP BY broker_id  ) AS a '...
        'JOIN (SELECT id, name FROM brokers) AS b ON a.broker_id = b.id ORDER BY snet %s LIMIT 15' ];
 
scrsz = get(0, 'ScreenSize');
figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.8]);        
hold on

query = sprintf(query_template, symbol, from_d, to_d, '>', 'DESC');
result = sql_query(query);
subplot(2,1,1);
title_s = sprintf('Buyers for %d from %s to %s', symbol, from_d, to_d);
bsr_bybroker_chart([cell2mat(result(:,3)), cell2mat(result(:,4))*-1, cell2mat(result(:,5))], result(:,2), title_s);

query = sprintf(query_template, symbol, from_d, to_d, '<', 'ASC');
result = sql_query(query);
title_s = sprintf('Sellers for %d from %s to %s', symbol, from_d, to_d);
subplot(2,1,2);
bsr_bybroker_chart([cell2mat(result(:,3)), cell2mat(result(:,4))*-1, cell2mat(result(:,5))], result(:,2), title_s);

hold off