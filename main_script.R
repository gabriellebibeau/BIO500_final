# 1. Importer les fichiers.csv du répertoire et les fusionner avec la fonction fusion_pls_fichiers

  #Définir les objects de la fonction
  repertoire <- ("C:/Users/cloet/Desktop/BIO500/BIO500_final/benthos") #Spécifier le chemin vers le dossier contenant les fichiers
  type_fichier <- "\\.csv$" #Pour importer tous les fichiers .csv dans le répertoire
  
  #Importer et appliquer la fonction 
  source("fonct_fusion_pls_fichiers.r")
  df_complet <- fusion_pls_fichiers(repertoire, type_fichier)


# 2. Enlever les colonnes de NA et autres non-pertinentes
  source("fonct_retirer_colonnes_GB1.R")
  df_propre <- Retirer_colonnes(df_complet) 

  
# 3. Remplacer les données problématiques par des NA
  source("fonct_remplacer_NA.R")
  df_propre <- Remplacer_NA(df_propre)
  
  
# 4. Changer les types de donnees des colonnes pertinentes ***À voir si encore pertinent
  source("fonct_classer_colonnes_GB2.R")
  df_propre <- Classer_colonnes(df_propre)


# 5. Créer des identifiants uniques pour chaque station par site pour une date et heure précises
  
  #Installer de package dplyr
  install.packages("dplyr")
  
  source("fonct_ids.R")
  df_ID <- traitement_donnees_IDs(df_propre)
  

# 6. Séparer les données dans des tables dans une base de données relationnelle dans SQLite
  
  #Installer de package RSQLite permettant de se connecter au serveur SQLite
  install.packages("RSQLite")  
  
  #Connection de notre fichier de donnees au serveur SQLite
  bd <- dbConnect(RSQLite::SQLite(), dbname) #dbname correspond au chemin que l'ordinateur doit prendre pour retrouver le fichier que l'on veut cr?er. Donc, il s'agirait de setwd() en ajoutant ? la fin de se dernier le nom du fichier contenant les tables de donn?es et se terminant par .bd
  
  source("fonct_creation_bd.R")
  tables_relation  <- creation_bd(df_propre, bd)
  
  dbDisconnect()