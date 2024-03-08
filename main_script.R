setwd("C:/Users/cloet/Desktop/BIO500")

#1. Chemin vers les donnees  ###modifier la fonction
fichier <- "site_86_180_R01_2018-08-09.csv"
fichier1 <- "site_99_88_R01_2019-09-12.csv"

#2. Lecture des donnees  ###modifier la fonction
source("fonct_lect_donnees.r")
dataframe <- lect_donnees(fichier)
dataframe1 <- lect_donnees(fichier1)

#3. Fusionner les dataframe   ###en faire une fonction???
dataframe.fus <- rbind(dataframe, dataframe1)

#4. Enlever les colonnes de NA
source("Retirer_colonnes_GB1.R")
Retirer_colonnes() 

#5. Changer les types de donnees des colonnes pertinentes
source("Classer_colonnes_GB2.R")
Classer_colonnes()

#6. Nettoyer donnees
source("Remplacer_NA_GB3.R")
Remplacer_NA()

#7. Ajouter IDs et code especes

#8. Extraire les colonnes pour former les dataframe conceptuels ###En faire une fonction separe comme dans le cours
df.abondance <- dataframe.fus[, c("nom_sci","abondance")] #ajouter ID espece
df.ref <- dataframe.fus[, c("site","date_obs","heure_obs","nom_sci")] #ajouter ID site et ID espece
df.site <- dataframe.fus[, c("largeur_riviere","profondeur_riviere","vitesse_courant","transparence_eau","temperature_eau_c")] #ajouter ID site   