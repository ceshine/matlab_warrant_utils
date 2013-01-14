function [] = branking(broker, ddate)
    query_template = [
                      '     SELECT A.symbol, SUM(A.value) / 10000 AS tvalue '...
                      '            FROM (SELECT symbol, (price*buy)-(price*sell) AS value, broker_id FROM warrant_bsreport WHERE broker_id = ( SELECT id FROM brokers WHERE name = "%s" ) AND date = "%s" ) AS A '...
                      '            GROUP BY A.broker_id '...
                      '            ORDER BY tvalue %s LIMIT 5'];

    query = sprintf(query_template, broker, ddate, 'DESC');
    result = sql_query(query);

    output = result(:, [1 2])';
    disp(sprintf('\n%s\t%8.2f\t', output{:}));


    query = sprintf(query_template, broker, ddate, 'ASC');
    result = sql_query(query);

    output = result(:, [1 2])';
    disp(sprintf('\n%s\t%8.2f\t', output{:}));
end 
