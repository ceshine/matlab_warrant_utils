function [ output_args ] = bsr_bybroker_chart( bsn, names, title_s )
%BSR_BYBROKER_CHART Summary of this function goes here
%   Detailed explanation goes here
    %clf
    %hFig = figure(1);
    %set(hFig, 'Position', [100 100 1400 600])
%    axes('position', [0.05 0.1 0.9 0.8])

    bsn = bsn / 1000;
    
    bar(bsn)  
    set(gca,'XTick',1:1:size(bsn,1))
    set(gca,'XTickLabel', names)
    xlim([0 size(bsn,1)+1]);
    
    title(title_s);
end

