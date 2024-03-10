install.packages('RSQLite')

#essai présentation du prof
library(RSQLite)

con <- dbConnect(SQLite(), dbname="./GitHub/BIO500_final/database_test.db")
dbSendQuery(con,"
 CREATE TABLE test (
   test      VARCHAR(5),
   a      VARCHAR(2),
   PRIMARY KEY (test)
 );
") #fin des intructions

dbSendQuery(con,"DROP TABLE test;")

test2 <- '
CREATE TABLE test2 (
   test2      VARCHAR(5),
   test       VARCHAR(3),
   b          VARCHAR(2),
   PRIMARY KEY (test2)
 );'

dbSendQuery(con,"DROP TABLE test2;")

dbSendQuery(con, test2)

dbDisconnect(con)

