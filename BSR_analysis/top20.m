symbol = input('\nSymbol:  ');
from_d = input('\nFrom Date: ', 's');
to_d = input('\nUntil Date: ', 's');
query_template = [ 'SELECT broker_id, name, tbuy, tsell, net ' ...
          'FROM (SELECT broker_id , SUM( buy)  AS tbuy, SUM( sell ) AS tsell , SUM( buy ) - SUM(sell ) AS net ' ...
                'FROM  bsreport ' ...
                'WHERE  company_id = %d AND date >= "%s" AND date <= "%s" ' ...
                'GROUP BY  broker_id ' ...
                'ORDER BY net %s ' ...
                'LIMIT 20) AS a '  ...
            'JOIN brokers ON a.broker_id = brokers.id' ];
 
scrsz = get(0, 'ScreenSize');
figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.8]);        
hold on

query = sprintf(query_template, symbol, from_d, to_d, 'DESC');
result = sql_query(query);
subplot(2,1,1);
title_s = sprintf('Buyers for %d from %s to %s', symbol, from_d, to_d);
bsr_bybroker_chart([cell2mat(result(:,3)), cell2mat(result(:,4))*-1, cell2mat(result(:,5))], result(:,2), title_s);

query = sprintf(query_template, symbol, from_d, to_d, 'ASC');
result = sql_query(query);
title_s = sprintf('Sellers for %d from %s to %s', symbol, from_d, to_d);
subplot(2,1,2);
bsr_bybroker_chart([cell2mat(result(:,3)), cell2mat(result(:,4))*-1, cell2mat(result(:,5))], result(:,2), title_s);

hold off