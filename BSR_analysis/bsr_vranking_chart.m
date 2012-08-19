function [ output_args ] = bsr_vranking_chart( tbuy, tsell, tnet, volume, lab, title_s )
%BSR_RANKING_CHART Summary of this function goes here
%   Detailed explanation goes here
    bsn = [ tbuy tsell*-1 tnet volume] / 1000;
    
    h = bar(bsn);
    set(h(1), 'facecolor', 'red')
    set(h(2), 'facecolor', 'green')
    set(h(3), 'facecolor', 'yellow')
    set(h(4), 'facecolor', 'magenta')
    set(gca,'XTick',1:1:size(bsn,1))
    set(gca,'XTickLabel', lab)
    xlim([0 size(bsn,1)+1]);
    
    title(title_s);
    

end

