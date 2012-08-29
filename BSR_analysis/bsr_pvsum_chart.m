function [ output_args ] = bsr_sum_chart( tbuy, tsell, volume, ddate, HLOC, title_s)
%BSR_SUM_CHART Summary of this function goes here
%   Detailed explanation goes here
    bsn = [ tbuy tsell*-1 tbuy+tsell (tbuy-tsell)/2 volume] / 1000;
    
    
    subplot('position',[0.05 0.6 0.9 0.35]);
    h = bar(bsn);
    set(h(1), 'facecolor', 'red')
    set(h(2), 'facecolor', 'green')
    set(h(3), 'facecolor', 'yellow')
    set(gca,'XTick',1:1:size(bsn,1))
    set(gca,'XTickLabel', datestr(datenum(ddate), 'mmdd'))
    xlim([0 size(bsn,1)+1]);
    
    title(title_s);
    
    subplot('position',[0.05 0.35 0.9 0.2]);
    
    candle(HLOC(:,1), HLOC(:,2), HLOC(:,3), HLOC(:,4), 'red');
    set(gca,'XTick',1:1:size(bsn,1))
    set(gca,'XTickLabel', datestr(datenum(ddate), 'mmdd'))
    xlim([0 size(bsn,1)+1]);
    
    subplot('position',[0.05 0.05 0.9 0.2]);
    tnet = (tbuy + tsell) / 1000;
    ctnet = cumsum(tnet);
    plot(ctnet);
    set(gca,'XTick',1:1:size(bsn,1))
    set(gca,'XTickLabel', datestr(datenum(ddate), 'mmdd'))
    xlim([0 size(bsn,1)+1]);

end

