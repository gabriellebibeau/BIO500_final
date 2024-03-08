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

#4. Changer les types de donnees

#5. Nettoyer donnees

#6. Ajouter IDs et code especes

#7. Extraire les colonnes pour former les dataframe conceptuels ###En faire une fonction separe comme dans le cours
df.abondance <- dataframe.fus[, c("nom_sci","abondance")] #ajouter ID espece
df.ref <- dataframe.fus[, c("site","date_obs","heure_obs","nom_sci")] #ajouter ID site et ID espece
df.site <- dataframe.fus[, c("largeur_riviere","profondeur_riviere","vitesse_courant","transparence_eau","temperature_eau_c")] #ajouter ID site   