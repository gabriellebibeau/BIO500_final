#Installer le package dyplyr
install.packages("dplyr")
library(dplyr)

                                 #Fonction «traitement_donnees_IDs»#

traitement_donnees_IDs <- function(df.fus) {
  
#Créer la colonne «ID date_site_heure_station»
df_complet$ID_date_site_heure_station <- paste(df_complet$date, df_complet$site, df_complet$heure_obs, df_complet$ETIQSTATION, sep = ';')

#Attribuer des nombres uniques à chacun des IDs des deux colonnes
df_complet$ID_date_site_heure_station_unique <- match(df_complet$ID_date_site_heure_station, unique(df_complet$ID_date_site_heure_station))

#Mise en forme du tableau avec les IDs
df_complet$ID_date_site_heure_station <- NULL
df_complet <- df_complet %>% rename('ID date_site_heure_station' = 'ID_date_site_heure_station_unique')
}