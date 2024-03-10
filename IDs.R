#Afficher le répertoire de travail
getwd()

#Lecture du fichier CSV/table complète
donnees <- read.csv("site_86_180_R01_2018-08-09.csv")
donnees

#Installer le package dyplyr
install.packages("dplyr")
library(dplyr)

#Fonction (mettre la table complète en argument)#
traitement_donnees_IDs <- function(donnees) {
  
#Créer la colonne «ID date_site_heure»
donnees$IDsite <- paste(donnees$date, donnees$site, donnees$heure_obs, sep = ";")

#Créer la colonne «ID espèce_abondance_fraction»
donnees$IDespèce <- paste(donnees$nom_sci, donnees$abondance, donnees$fraction, sep = ";")

#Attribuer des nombres uniques à chacun des IDs des deux colonnes
donnees$IDsite_unique <- match(donnees$IDsite, unique(donnees$IDsite))
donnees$IDespèce_unique <- match(donnees$IDespèce, unique(donnees$IDespèce))

#Mise en forme du tableau final
donnees$IDsite <- NULL
donnees$IDespèce <- NULL
donnees <- donnees %>% rename('ID date_site_heure' = 'IDsite_unique')
donnees <- donnees %>% rename('ID espèce_abondance_fraction' = 'IDespèce_unique')
donnees <- donnees[, c(1, 2, 3, 4, 31, 5, 6, 7, 32, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30)]
#À ajuster selon le nombre de colonnes
}

#Appel de la fonction pour donner le tableau final
donnees_finales_IDs <- traitement_donnees_IDs(donnees)
