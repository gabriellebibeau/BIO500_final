#Installer le package dyplyr
install.packages("dplyr")
library(dplyr)

                                 #Fonction «traitement_donnees_IDs»#

traitement_donnees_IDs <- function(df.fus) {
  
#Créer la colonne «ID date_site_heure_station»
df.fus$ID_date_site_heure_station <- paste(df.fus$date, df.fus$site, df.fus$heure_obs, df.fus$ETIQSTATION, sep = ';')

#Créer la colonne «ID espèce_abondance_fraction»
df.fus$ID_espèce_abondance_fraction <- paste(df.fus$nom_sci, df.fus$abondance, df.fus$fraction, sep = ';')

#Attribuer des nombres uniques à chacun des IDs des deux colonnes
df.fus$ID_date_site_heure_station_unique <- match(df.fus$ID_date_site_heure_station, unique(df.fus$ID_date_site_heure_station))
df.fus$ID_espèce_abondance_fraction_unique <- match(df.fus$ID_espèce_abondance_fraction, unique(df.fus$ID_espèce_abondance_fraction))

#Mise en forme du tableau final
df.fus$ID_date_site_heure_station <- NULL
df.fus$ID_espèce_abondance_fraction <- NULL
df.fus <- df.fus %>% rename('ID date_site_heure_station' = 'ID_date_site_heure_station_unique')
df.fus <- df.fus %>% rename('ID espèce_abondance_fraction' = 'ID_espèce_abondance_fraction_unique')
df_propre <- df_propre[, c(1, 2, 3, 4, 14, 5, 6, 15, 7, 8, 9, 10, 11, 12, 13]
#À ajuster selon le nombre de colonnes
}

#Appel de la fonction pour donner le tableau final
donnees_finales_IDs <- traitement_donnees_IDs(df_propre)
