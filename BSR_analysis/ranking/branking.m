function [ output_args ] = branking( broker, ddate )


    query_template = ['SELECT C . * , name '...
                      '     FROM ( SELECT A.company_id, A.tbuy, A.tsell, A.tnet, B.close, ( A.tnet * B.close ) / 10000 AS tvalue '...
                      '            FROM (SELECT company_id, tbuy, tsell, tnet FROM bssummary WHERE broker_id = ( SELECT id FROM brokers WHERE name = "%s" ) AND date = "%s" ) AS A '...
                      '            JOIN (SELECT symbol, close FROM prices WHERE date = "%s") AS B ON A.company_id = B.symbol '...
                      '            ORDER BY tvalue %s LIMIT 10 ) AS C '...
                      '     JOIN companies ON C.company_id = companies.id '];

    query = sprintf(query_template, broker, ddate, ddate, 'DESC');
    result = sql_query(query);

    output = result(:, [1 6 7])';
    disp(sprintf('\n%d\t%8.2f\t%s', output{:}));


    query = sprintf(query_template, broker, ddate, ddate, 'ASC');
    result = sql_query(query);

    output = result(:, [1 6 7])';
    disp(sprintf('\n%d\t%8.2f\t%s', output{:}));
end
