

#Établir la connection
bd <- dbConnect(RSQLite::SQLite(), dbname = "bd_benthos.bd")

donnnes_sites <- dbGetQuery(bd, 'SELECT * FROM sites LIMIT 4')
donnnes_sp <- dbGetQuery(bd, 'SELECT * FROM especes LIMIT 4')

#Fermer la connection
dbDisconnect(bd)