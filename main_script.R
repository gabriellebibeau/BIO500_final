# 1. Importer les fichiers et les fusionner avec la fonction fusion_pls_fichiers

  # Création d'un vecteur contenant les noms de fichiers à lire
  noms_fichiers <- c("site_86_180_R01_2018-08-09.csv", "site_99_88_R01_2019-09-12.csv", "site_100_92_R01_2021-10-01.csv")
  
  #Importer et effectuer la fonction 
  source("fonct_fusion_pls_fichiers.r")
  df_fusionne <- fusion_pls_fichiers(noms_fichiers)


#2. Changer les types de donnees

#3. Nettoyer donnees

#4. Ajouter IDs et code especes

#5. Extraire les colonnes pour former les dataframe conceptuels ###En faire une fonction separe comme dans le cours
df.abondance <- dataframe.fus[, c("nom_sci","abondance")] #ajouter ID espece
df.ref <- dataframe.fus[, c("site","date_obs","heure_obs","nom_sci")] #ajouter ID site et ID espece
df.site <- dataframe.fus[, c("largeur_riviere","profondeur_riviere","vitesse_courant","transparence_eau","temperature_eau_c")] #ajouter ID site   