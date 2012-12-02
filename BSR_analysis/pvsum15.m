symbol = input('Symbol:  ');

%from_d = input('\nFrom Date: ', 's');
%to_d = input('\nUntil Date: ', 's');
query_template = [ 'SELECT ddate, tbuy, tsell, volume '...
                    'FROM (SELECT date as ddate,tbuy, tsell FROM '...
                    '(SELECT * FROM (SELECT SUM(tnet) as tbuy,date FROM bstop15 WHERE tnet > 0 AND company_id = %d AND date > "2012-10-01" GROUP BY date) as bbuy '...
                    'JOIN (SELECT SUM(tnet) as tsell,date as ddate FROM bstop15 WHERE tnet < 0 AND company_id = %d AND date > "2012-10-01" GROUP BY date) as bsell ON bbuy.date = bsell.ddate) AS a) AS b '...
                    'JOIN bsvolume '...
                    'ON bsvolume.company_id = %d AND bsvolume.date = b.ddate' ];
 
query_template_2 = [ 'SELECT date, high, low, open, close FROM twse_stock_prices WHERE company_id = %d AND date > "2012-10-01";'];

scrsz = get(0, 'ScreenSize');
figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.6]);        


hold on

query = sprintf(query_template, symbol, symbol, symbol);
result = sql_query(query);

query2 = sprintf(query_template_2, symbol);
prices = sql_query(query2);
HLOC = [cell2mat(prices(:,2)), cell2mat(prices(:,3)), cell2mat(prices(:,4)), cell2mat(prices(:,5))];

title_s = sprintf('Daily Top 15/15 ¥D¤O for %d', symbol);
bsr_pvsum_chart(cell2mat(result(:,2)), cell2mat(result(:,3)), cell2mat(result(:,4)), cell2mat(result(:,1)), HLOC, title_s)


hold off

%editmenufcn(gcf,'EditCopyFigure');

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 7]);
savepath = sprintf('C:\\Cloud Storage\\Dropbox\\analysis\\%d', symbol);
mkdir(savepath);
print(gcf, '-dpng', fullfile(savepath,sprintf('pvsum15@%s.png',date)), '-r100');