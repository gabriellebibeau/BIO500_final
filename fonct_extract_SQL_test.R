#Table 1: id_site, site, nom_sci, abd_ajuste
#table 2: id_site, richesse, largeur, profondeur, vitesse, temp, transp

bd <- dbConnect(RSQLite::SQLite(), dbname = "bd_benthos.bd") 

donnees_sites <- dbGetQuery(bd, 'SELECT * FROM sites')
donnees_sp <- dbGetQuery(bd, 'SELECT * FROM especes')

