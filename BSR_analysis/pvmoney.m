function [ ] = pvmoney( symbol,threshold, from_d )
    symbol = str2num(symbol);
    threshold = str2num(threshold);

    if nargin < 3
        from_d =  '2012-12-01';
    end
    
    query_template_1 = [ 'SELECT date, SUM(mnet) FROM twii.bsmoney WHERE date >= "%s" AND mnet >= %d AND company_id = %d GROUP BY date ORDER BY date ASC;'];
    query_template_2 = [ 'SELECT date, SUM(mnet) FROM twii.bsmoney WHERE date >= "%s" AND mnet <= %d AND company_id = %d GROUP BY date ORDER BY date ASC;'];
    query_template_3 = [ 'SELECT date, SUM(mnet) FROM twii.bsmoney WHERE date >= "%s" AND mnet > 0 AND company_id = %d GROUP BY date ORDER BY date ASC;'];
    
    query_template_4 = [ 'SELECT date, high, low, open, close FROM prices WHERE symbol = %d AND date > "%s";'];

    scrsz = get(0, 'ScreenSize');
    figure('Position', [50 100 scrsz(3)*0.9 scrsz(4)*0.6]);        


    hold on
    
    query = sprintf(query_template_1, from_d, (threshold * 10000), symbol);
    rbuy = sql_query(query);
    
    query2 = sprintf(query_template_2, from_d, (threshold * -10000), symbol);
    rsell = sql_query(query2);
    
    query3 = sprintf(query_template_3,  from_d, symbol);
    rvol = sql_query(query3);
    
    tmp = join(dataset([{rbuy} {'date', 'buy'}]), dataset([{rsell} {'date', 'sell'}]), 'Type', 'outer', 'MergeKeys',true);
    tmp = join(dataset([{rvol} {'date', 'vol'}]), tmp, 'Type', 'outer', 'MergeKeys',true);
    
    query4 = sprintf(query_template_4, symbol, from_d);
    prices = sql_query(query4);
    HLOC = [cell2mat(prices(:,2)), cell2mat(prices(:,3)), cell2mat(prices(:,4)), cell2mat(prices(:,5))];

    title_s = sprintf('交易量大於 %d 萬 for %d', threshold, symbol);
      
    em = cellfun(@isempty,tmp.buy);
    tmp.buy(em) = {0};
    em = cellfun(@isempty,tmp.sell);
    tmp.sell(em) = {0};
    
    bsr_pvsum_chart(cell2mat(tmp.buy), cell2mat(tmp.sell), cell2mat(tmp.vol), cell2mat(tmp.date), HLOC, title_s)


    hold off

    %editmenufcn(gcf,'EditCopyFigure');

    %set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 7]);
    %savepath = sprintf('C:\\Cloud Storage\\Dropbox\\analysis\\%d', symbol);
    %mkdir(savepath);
    %print(gcf, '-dpng', fullfile(savepath,sprintf('pvmoney.png')), '-r100');
end

