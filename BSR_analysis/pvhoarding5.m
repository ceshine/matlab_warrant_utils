from_d = input('From Date: ', 's');
to_d = input('Until Date: ', 's');

query_template=    ['SELECT company_id, name, bbuy, bsell, bnet, bvolume/2/volume, volume, ratio '...
                    'FROM (SELECT company_id, bbuy, bsell, bbuy+bsell AS bnet, bbuy-bsell AS bvolume, volume, (bbuy+bsell)/volume  AS ratio '...
                    	'FROM (SELECT * FROM (SELECT company_id, SUM(tnet) AS bbuy '...
                    						'FROM bstop5 '...
                     						'WHERE tnet > 0 AND date>="%s" AND date <="%s" '...
                     						'GROUP BY company_id) AS a '...
                    				  'JOIN    (SELECT company_id as iid, SUM(tnet) AS bsell '...
                    						   'FROM bstop5 '...
                    						   'WHERE tnet < 0 AND date >= "%s" AND date <="%s"  '...
                    						   'GROUP BY company_id) AS b '...
                    				  'ON  a.company_id = b.iid '...
                    			'WHERE bbuy != bsell * -1 AND bbuy-bsell > 10000000) as c '...
                    	'JOIN (SELECT company_id as iid, SUM(volume) as volume FROM bsvolume WHERE date >= "%s" AND date <= "%s" GROUP BY iid ) AS d '...
                    	'ON	c.company_id = d.iid '...
                    	'ORDER BY ratio DESC  '...
                    	'LIMIT 0, 15) AS e '...
                    'JOIN companies '...
                    'ON e.company_id = companies.id'];
                
scrsz = get(0, 'ScreenSize');
figure('Position', [50 20 1200 700]);        

hold on
subplot(2,1,1)
query = sprintf(query_template, from_d, to_d, from_d, to_d, from_d, to_d);
result = sql_query(query);
title_s = sprintf('%s to %s Top5主力量能買超排行',from_d,to_d);
bsr_vranking_chart(cell2mat(result(:,3)), cell2mat(result(:,4)), cell2mat(result(:,5)), cell2mat(result(:,7)), result(:,1), title_s)

t = uitable('data', [result(:,1) result(:,2) result(:,8) result(:,6)],'RowName',[],'ColumnName',{'代碼','公司名稱','買超強度','鎖定率'},'Position', [380 10 435 360], 'ColumnWidth', {70, 200, 80,80}, 'FontSize', 10);
hold off