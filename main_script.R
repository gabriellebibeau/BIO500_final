# 1. Importer les fichiers.csv du répertoire et les fusionner avec la fonction fusion_pls_fichiers

  #Définir les objects de la fonction
  repertoire <- ("C:/Users/cloet/Desktop/BIO500/BIO500_final/benthos") #Spécifier le chemin vers le dossier contenant les fichiers
  type_fichier <- "\\.csv$" #Pour importer tous les fichiers .csv dans le répertoire
  
  #Importer et appliquer la fonction 
  source("fonct_fusion_pls_fichiers.r")
  df_complet <- fusion_pls_fichiers(repertoire, type_fichier)


# 2. Enlever les colonnes de NA et les doublons
  source("Retirer_colonnes_GB1.R")
  df_propre <- Retirer_colonnes(df_complet) 

  
# 3. Changer les types de donnees des colonnes pertinentes ***À voir si encore pertinent
  source("Classer_colonnes_GB2.R")
  Classer_colonnes()


# 4. Créer des identifiants uniques pour chaque station par site pour une date et heure précises
  source('traitement_donnees_IDs')
  df_ID <- traitement_donnees_IDs(df_complet)

# 5. Séparer les données dans des tables conceptuelles 
  