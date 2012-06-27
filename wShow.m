f = fields(warrants);
fprintf('\n');
for i = 1:numel(f),
    fprintf('%s  %s  %s %s\n', warrants.(f{i}).name, f{i}, warrants.(f{i}).spot, stocks.(warrants.(f{i}).spot).name);
end
fprintf('\n');