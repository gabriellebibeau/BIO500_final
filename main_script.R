#Librairies 
library(vegan)
library(ggplot2)
library(glue)
library(RSQLite)
library(dplyr)
library(rmarkdown)

# 1. Importer les fichiers.csv du répertoire et les fusionner avec la fonction fusion_pls_fichiers

  #Définir les objects de la fonction
  repertoire <- ("benthos") #Spécifier le chemin vers le dossier contenant les fichiers
  
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
  source("fonct_ajout_IDs.R")
  df_IDs <- ajout_IDs(df_classe)
  
# 5. Créer les dataframes qui seront injectés dans SQLite
  df_especes <- df_IDs[, c("id_site","nom_sci","abondance", "fraction")]
  df_sites <- unique(df_IDs[, c("id_site","site", "date", "heure_obs","largeur_riviere","profondeur_riviere","vitesse_courant","temperature_eau_c","transparence_eau","ETIQSTATION")])
  
# 6. Créer les tables dans la base de données relationnelle dans SQLite
  source("fonct_creation_bd.R")
  fichier_SQL  <- creation_bd(df_sites, df_especes)
  
#7. Extraire les données des tables SQLite
  source("fonct_extract_rich.R")
  table_richesse <- extract_rich(fichier_SQL)
  
  source("fonct_extract_abond.R")
  table_abondance <- extract_abond(fichier_SQL)
  
#8. Régressions
  source("fonct_graph_rich.R")
  graphs_richesse <- graph_rich(table_richesse)
  
#9. Boxplot
  source("fonct_boxplot_rich.R")
  boxplot_trans <- boxplot_rich(table_richesse)
  
#10. Interactions
  source("fonct_tab_inter.R")
  interactions <- tab_inter(table_richesse)
  
#11. Ordination
  source("fonct_ordination_sites.R")
  ordination <- ordination_sites(table_abondance)
 
