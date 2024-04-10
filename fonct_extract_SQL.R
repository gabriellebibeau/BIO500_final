#Table 1: id_site, site, nom_sci, abd_ajuste
#table 2: id_site, richesse, largeur, profondeur, vitesse, temp, transp

bd <- dbConnect(RSQLite::SQLite(), dbname = fichier_SQL)
# Requête SQL pour créer une nouvelle colonne dans la table
req_add_col <- "ALTER TABLE sites ADD COLUMN abondance_ INTEGER"

# Exécuter la requête SQL pour créer la nouvelle colonne
dbExecute(bd, req_add_col)


donnnes_sites <- dbGetQuery(bd, 'SELECT id_site, largeur_riviere, profondeur_riviere, vitesse_courant, temperature_eau_c, transparence_eau FROM sites')
donnnes_sp <- dbGetQuery(bd, 'SELECT id_site, FROM especes')

test_1 <- dbGetQuery(bd, 'SELECT COUNT(nom_sci) FROM especes GROUP BY id_site')

SELECT nom 
FROM (
  SELECT client.id, nom, magasin_id, code_postal
  FROM  client
  INNER JOIN magasin ON client.magasin_id = magasin.id
) GROUP BY client.id