# Fichier _targets.R

# Dépendances
library(targets)
tar_option_set(packages = c("RSQLite", "dplyr","rmarkdown",
                            "vegan","ggplot2","glue","knitr"))

# Scripts R
source("fonct_fus_fichiers.r")
source("fonct_nettoyage.R")
source("fonct_classer_col.R")
source("fonct_ajout_IDs.R")
source("fonct_creation_bd.R")
source("fonct_extract_rich.R")
source("fonct_extract_abond.R")

# Pipeline
list(
  #Spécifier l'emplacement des fichiers
  tar_target(
    name = repertoire,
    command = "benthos", 
  ),
  #Fusionner les fichiers
  tar_target(
    name = df_complet,
    command = fus_fichiers(repertoire)
  ),
  #Enlever les colonnes non-pertinentes et données problématiques
  tar_target(
    name = df_propre,
    command = nettoyage(df_complet)
  ),
  #Changer les classes des colonnes
  tar_target(
    name = df_classe,
    command = classer_col(df_propre)
  ),
  #Ajouter les identifiants uniques des sites
  tar_target(
    name = df_IDs,
    command = ajout_IDs(df_classe)
  ),
  #Création du dataframe sites à injecter dans SQLite
  tar_target(
    name = df_sites,
    command = unique(df_IDs[, c("id_site","site", "date", "heure_obs","largeur_riviere","profondeur_riviere","vitesse_courant","temperature_eau_c","transparence_eau","ETIQSTATION")])
  ),
  #Création du dataframe especes à injecter dans SQLite
  tar_target(
    name = df_especes,
    command = df_IDs[, c("id_site","nom_sci","abondance", "fraction")]
  ),
  #Création des tables SQLite et injection des données
  tar_target(
    name = fichier_SQL,
    command = creation_bd(df_sites, df_especes)
  ),
  #Extraction des données de richesse de SQLite
  tar_target(
    name = table_richesse,
    command = extract_rich(fichier_SQL)
  ),
  #Extraction des données d'abondance de SQLite
  tar_target(
    name = table_abondance,
    command = extract_abond(fichier_SQL)
  ),  
  #Création du rapport RMarkdown
  tar_target(
    name = rapport, 
    command = rmarkdown::render("rapport/rapport.Rmd")
  )
)
