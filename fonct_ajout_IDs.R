
                                 #Fonction «traitement_donnees_IDs»#

ajout_IDs <- function(df) {
  
  library(dplyr)
  
  #Créer la colonne «ID date_site_heure_station»
  df$infos_ids <- paste(df$date, df$site, df$heure_obs, df$ETIQSTATION, sep = ';')
  
  #Attribuer des nombres uniques à chacun des IDs des deux colonnes
  df$id_site <- match(df$infos_ids, unique(df$infos_ids))
  
  #Retirer la colonne infos_ids
  df$infos_ids <- NULL

  return(df)
}
