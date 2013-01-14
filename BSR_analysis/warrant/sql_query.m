function [ result ] = sql_query( query )
%SQL_QUERY Summary of this function goes here
%   Detailed explanation goes here
    if (exist('conn', 'var') == 0 || isconnection(conn) ~= 1),
        bsr_db
    else
        try
            ping(conn);
        catch err
            bsr_db
        end
    end
    
    for i = 1:2,
        try
            result = fetch(conn, query);
            return
        catch err
            err.message
            bsr_db
        end
    end
    
end

