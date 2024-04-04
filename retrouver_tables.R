
bd <- dbConnect(RSQLite::SQLite(), dbname = "bd_benthos.bd")
dbSendQuery(bd, "DROP TABLE sites")
dbSendQuery(bd, "DROP TABLE especes")
dbDisconnect(bd)

bd <- dbConnect(RSQLite::SQLite(), dbname = "bd_benthos.bd")
dbGetQuery(bd, 'SELECT * FROM sites LIMIT 4')
dbGetQuery(bd, 'SELECT * FROM especes LIMIT 4')
dbDisconnect(bd)