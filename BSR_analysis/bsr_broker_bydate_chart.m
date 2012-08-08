function [ output_args ] = bsr_broker_bydate_chart( bsn, ddate, title_s )
%BSR_BROKER_BYDATE_CHART Summary of this function goes here
%   Detailed explanation goes here
    bsn = bsn / 1000;
    
    bar(bsn)  
    set(gca,'XTick',1:1:size(bsn,1))
    set(gca,'XTickLabel', datestr(datenum(ddate), 'mmdd'))
    xlim([0 size(bsn,1)+1]);
    
    title(title_s);

end

