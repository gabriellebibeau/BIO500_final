# 1. Importer les fichiers.csv du répertoire et les fusionner avec la fonction fusion_pls_fichiers

  #Définir les objects de la fonction
  repertoire <- ("~/GitHub/BIO500_final/benthos") #Spécifier le chemin vers le dossier contenant les fichiers
  
  #Importer et appliquer la fonction 
  source("fonct_fus_fichiers.r")
  df_complet <- fus_fichiers(repertoire)

# 2. Nettoyer les données
  source("fonct_nettoyage.R")
  df_propre <- nettoyage(df_complet) 
  
# 3. Changer les types de donnees des colonnes
  source("fonct_classer_col.R")
  df_classe <- classer_col(df_propre)

# 4. Créer des identifiants uniques pour chaque station par site pour une date et heure précises
  
  #Installer de package dplyr si besoin
  source("fonct_ajout_IDs.R")
  df_IDs <- ajout_IDs(df_classe)
  
# 5. Créer les dataframes qui seront injectés dans SQLite
  df_especes <- df_IDs[, c("id_site","nom_sci","abondance", "fraction")]
  df_sites <- unique(df_IDs[, c("id_site","site", "date", "heure_obs","largeur_riviere","profondeur_riviere","vitesse_courant","temperature_eau_c","transparence_eau","ETIQSTATION")])
  
# 6. Créer les tables dans la base de données relationnelle dans SQLite
  
  #Installer de package RSQLite permettant de se connecter au serveur SQLite si besoin
  source("fonct_creation_bd.R")
  tables_SQL  <- creation_bd(df_especes, df_sites)
  