function [] = stop15(symbol, ddate)
    symbol = str2num(symbol);
    query_template = [ 'SELECT broker_id, name, tbuy, tsell, net ' ...
          'FROM (SELECT broker_id , SUM( buy)  AS tbuy, SUM( sell ) AS tsell , SUM( buy ) - SUM(sell ) AS net ' ...
                'FROM  bsreport ' ...
                'WHERE  company_id = %d AND date = "%s" ' ...
                'GROUP BY  broker_id ' ...
                'ORDER BY net %s ' ...
                'LIMIT 15) AS a '  ...
            'JOIN brokers ON a.broker_id = brokers.id' ];

    scrsz = get(0, 'ScreenSize');
    figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.8]);        
    hold on

    query = sprintf(query_template, symbol, ddate, 'DESC');
    result = sql_query(query);
    subplot(2,1,1);
    title_s = sprintf('Buyers for %d on %s ', symbol, ddate);
    bsr_bybroker_chart([cell2mat(result(:,3)), cell2mat(result(:,4))*-1, cell2mat(result(:,5))], result(:,2), title_s);

    query = sprintf(query_template, symbol, ddate, 'ASC');
    result = sql_query(query);
    title_s = sprintf('Sellers for %d on %s', symbol, ddate);
    subplot(2,1,2);
    bsr_bybroker_chart([cell2mat(result(:,3)), cell2mat(result(:,4))*-1, cell2mat(result(:,5))], result(:,2), title_s);

    hold off

    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 7]);
    savepath = sprintf('C:\\Cloud Storage\\Dropbox\\analysis\\%d', symbol);
    mkdir(savepath);
    print(gcf, '-dpng', fullfile(savepath,sprintf('stop15@%s.png',ddate)), '-r100');
end