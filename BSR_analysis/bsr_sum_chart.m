function [ output_args ] = bsr_sum_chart( tbuy, tsell, ddate, title_s)
%BSR_SUM_CHART Summary of this function goes here
%   Detailed explanation goes here
    bsn = [ tbuy tsell*-1 tbuy+tsell] / 1000;
    
    h = bar(bsn);
    set(h(1), 'facecolor', 'red')
    set(h(2), 'facecolor', 'green')
    set(h(3), 'facecolor', 'blue')
    set(gca,'XTick',1:1:size(bsn,1))
    set(gca,'XTickLabel', datestr(datenum(ddate), 'mmdd'))
    xlim([0 size(bsn,1)+1]);
    
    title(title_s);

end

