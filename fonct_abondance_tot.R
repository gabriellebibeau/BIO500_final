abondance_tot <- function(fichier_SQL){

  #Établir la connection
  bd <- dbConnect(RSQLite::SQLite(), dbname = "fichier_SQL")

  # Requête SQL pour créer une nouvelle colonne dans la table
  req_add_col <- "ALTER TABLE especes ADD COLUMN abondance_tot INTEGER"

  # Exécuter la requête SQL pour créer la nouvelle colonne
  dbExecute(bd, req_add_col)

  # Requête SQL pour mettre à jour la nouvelle colonne avec les résultats de l'opération mathématique
  req_abondance <- "UPDATE especes SET abondance_tot = ROUND(abondance/ fraction)"

  # Exécuter la requête SQL pour mettre à jour la nouvelle colonne
  dbExecute(bd, req_abondance)

  #Fermer la connection
  dbDisconnect(bd)
}