function [ out ] = bsr_sanhu_chart( nbrokers, ddate, HLOC, title_s )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here   
    
    subplot('position',[0.05 0.6 0.9 0.35]);
    
    candle(HLOC(:,1), HLOC(:,2), HLOC(:,3), HLOC(:,4), 'red');
    set(gca,'XTick',1:1:size(nbrokers,1))
    set(gca,'XTickLabel', datestr(datenum(ddate), 'mmdd'))
    xlim([0 size(nbrokers,1)+1]);   
    
    title(title_s);
    
    subplot('position',[0.05 0.35 0.9 0.2]);

    h = bar(nbrokers);

    set(gca,'XTick',1:1:size(nbrokers,1))
    set(gca,'XTickLabel', datestr(datenum(ddate), 'mmdd'))
    xlim([0 size(nbrokers,1)+1]);
    ylim([min(nbrokers)*0.9 max(nbrokers)*1.1]);
    ma = tsmovavg(nbrokers', 's', 5);
    l = line(1:size(nbrokers,1),ma);
    set(l, 'Color', 'red')

end

