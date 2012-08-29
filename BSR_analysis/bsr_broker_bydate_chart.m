function [ output_args ] = bsr_broker_bydate_chart( bsn, ddate, HLOC, title_s )
%BSR_BROKER_BYDATE_CHART Summary of this function goes here
%   Detailed explanation goes here
    bsn = bsn / 1000;
    
    subplot('position',[0.05 0.6 0.9 0.35]);    
    bar(bsn)  
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
    ctnet = cumsum(bsn(:,3));
    plot(ctnet);
    set(gca,'XTick',1:1:size(bsn,1))
    set(gca,'XTickLabel', datestr(datenum(ddate), 'mmdd'))
    xlim([0 size(bsn,1)+1]);


end

