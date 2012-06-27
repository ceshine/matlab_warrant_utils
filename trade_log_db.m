% slCharacterEncoding('UTF-8');
% feature('DefaultCharacterSet', 'UTF8');
load('db_account.mat'); 
conn = database('', db_user, db_password, 'com.mysql.jdbc.Driver', db_url)
