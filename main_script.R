# 1. Importer les fichiers.csv du répertoire et les fusionner avec la fonction fusion_pls_fichiers

  #Définir les objects de la fonction
  repertoire <- ("C:/Users/cloet/Desktop/BIO500/BIO500_final/benthos")#Spécifier le chemin vers le répertoire contenant les fichiers
  type_fichier <- "\\.csv$" #Pour importer tous les fichiers .csv dans le répertoire
  
  #Importer et appliquer la fonction 
  source("fonct_fusion_pls_fichiers.r")
  df_complet <- fusion_pls_fichiers(repertoire, type_fichier)


#2. Changer les types de donnees

#3. Enlever les colonnes de NA
source("Retirer_colonnes_GB1.R")
Retirer_colonnes() 

#4. Changer les types de donnees des colonnes pertinentes
source("Classer_colonnes_GB2.R")
Classer_colonnes()

#5. Nettoyer donnees
source("Remplacer_NA_GB3.R")
Remplacer_NA()


#6. Ajouter IDs et code especes

#7. Extraire les colonnes pour former les dataframe conceptuels ###En faire une fonction separe comme dans le cours
df.abondance <- dataframe.fus[, c("nom_sci","abondance")] #ajouter ID espece
df.ref <- dataframe.fus[, c("site","date_obs","heure_obs","nom_sci")] #ajouter ID site et ID espece
df.site <- dataframe.fus[, c("largeur_riviere","profondeur_riviere","vitesse_courant","transparence_eau","temperature_eau_c")] #ajouter ID site   