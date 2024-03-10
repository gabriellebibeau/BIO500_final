#Afficher le répertoire de travail
getwd()

#Lecture de la table complète
donnees <- read.csv('df.fus.csv')
donnees

#Installer le package dyplyr
install.packages("dplyr")
library(dplyr)

                                              #Fonction#

traitement_donnees_IDs <- function(df_propre) {
  
#Créer la colonne «ID date_site_heure_station»
df_propre$IDsite <- paste(df_propre$date, df_propre$site, df_propre$heure_obs, df_propre$ETIQSTATION, sep = ';')

#Créer la colonne «ID espèce_abondance_fraction»
df_propre$IDespèce <- paste(df_propre$nom_sci, df_propre$abondance, df_propre$fraction, sep = ';')

#Attribuer des nombres uniques à chacun des IDs des deux colonnes
df_propre$IDsite_unique <- match(df_propre$IDsite, unique(df_propre$IDsite))
df_propre$IDespèce_unique <- match(df_propre$IDespèce, unique(df_propre$IDespèce))

#Mise en forme du tableau final
df_propre$IDsite <- NULL
df_propre$IDespèce <- NULL
df_propre <- df_propre %>% rename('ID date_site_heure_station' = 'IDsite_unique')
df_propre <- df_propre %>% rename('ID espèce_abondance_fraction' = 'IDespèce_unique')
df_propre <- df_propre[, c(1, 2, 3, 4, 14, 5, 6, 15, 7, 8, 9, 10, 11, 12, 13]
#À ajuster selon le nombre de colonnes
}

#Appel de la fonction pour donner le tableau final
donnees_finales_IDs <- traitement_donnees_IDs(df_propre)
