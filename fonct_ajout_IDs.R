
                                 #Fonction «traitement_donnees_IDs»#

ajout_IDs <- function(df_pp) {
  
#Créer la colonne «ID date_site_heure_station»
df_pp$ID_date_site_heure_station <- paste(df_pp$date, df_pp$site, df_pp$heure_obs, df_pp$ETIQSTATION, sep = ';')

#Attribuer des nombres uniques à chacun des IDs des deux colonnes
df_pp$ID_date_site_heure_station_unique <- match(df_pp$ID_date_site_heure_station, unique(df_pp$ID_date_site_heure_station))

#Mise en forme du tableau avec les IDs
df_pp$ID_date_site_heure_station <- NULL
df_pp <- df_pp %>% rename('id_site' = 'ID_date_site_heure_station_unique')

  return(df_pp)
}
