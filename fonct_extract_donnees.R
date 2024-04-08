

#Établir la connection
bd <- dbConnect(RSQLite::SQLite(), dbname = "bd_benthos.bd")

donnnes_sites <- dbGetQuery(bd, 'SELECT id_site, largeur_riviere, profondeur_riviere, vitesse_courant, temperature_eau_c, transparence_eau FROM sites')
donnnes_sp <- dbGetQuery(bd, 'SELECT * FROM especes')

#Fermer la connection
dbDisconnect(bd)