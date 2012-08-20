symbol = input('\nSymbol:  ');

%from_d = input('\nFrom Date: ', 's');
%to_d = input('\nUntil Date: ', 's');
query_template = [ 'SELECT ddate, tbuy, tsell, volume '...
                    'FROM (SELECT date as ddate,tbuy, tsell FROM '...
                    '(SELECT * FROM (SELECT SUM(tnet) as tbuy,date FROM bstop15 WHERE tnet > 0 AND company_id = %d GROUP BY date) as bbuy '...
                    'JOIN (SELECT SUM(tnet) as tsell,date as ddate FROM bstop15 WHERE tnet < 0 AND company_id = %d GROUP BY date) as bsell ON bbuy.date = bsell.ddate) AS a) AS b '...
                    'JOIN bsvolume '...
                    'ON bsvolume.company_id = %d AND bsvolume.date = b.ddate' ];
 
scrsz = get(0, 'ScreenSize');
figure('Position', [50 100 scrsz(3)*0.5 scrsz(4)*0.5]);        

hold on

query = sprintf(query_template, symbol, symbol, symbol);
result = sql_query(query);
title_s = sprintf('Daily Top 15/15 ¥D¤O for %d', symbol);
bsr_vsum_chart(cell2mat(result(:,2)), cell2mat(result(:,3)), cell2mat(result(:,4)), cell2mat(result(:,1)), title_s)

hold off