# 1. Importer les fichiers.csv du répertoire et les fusionner avec la fonction fusion_pls_fichiers

#Définir les objects de la fonction
repertoire <- ("C:/Users/cloet/Desktop/BIO500_final/benthos") #Spécifier le chemin vers le dossier contenant les fichiers

#Importer et appliquer la fonction 
source("fonct_fus_fichiers.R")
df_complet <- fus_fichiers(repertoire)


# 2. Enlever les colonnes de NA et autres non-pertinentes
source("fonct_retirer_col_2.0.R")
df_propre <- retirer_col(df_complet) 


# 3. Remplacer les données problématiques par des NA
source("fonct_remplacer_NA.R")
df_propre <- remplacer_NA(df_propre)


# 4. Changer les types de donnees des colonnes pertinentes ***À voir si encore pertinent
source("fonct_classer_col.R")
df_propre <- classer_col(df_propre)


# 5. Créer des identifiants uniques pour chaque station par site pour une date et heure précises

library(dplyr) ########rajouter dans la fonction?????

source("fonct_ajout_IDs.R")
df_ID <- ajout_IDs(df_propre)


#6. Créer les dataframes qui seront injectés dans SQLite
df_especes <- df_ID[, c("id_site","nom_sci","abondance", "fraction")]
df_sites<- df_ID[, c("id_site","site", "date_obs", "heure_obs","largeur_riviere","profondeur_riviere","vitesse_courant","temperature_eau_c","transparence_eau","ETIQSTATION")]


# 7. Créer les tables dans la base de données relationnelle dans SQLite

source("fonct_creation_bd.R")
tables_relation  <- creation_bd(df_sites, df_especes)

bd <- dbConnect(RSQLite::SQLite(), dbname = "bd_benthos.bd")
dbSendQuery(bd, "DROP TABLE sites")
dbSendQuery(bd, "DROP TABLE especes")

dbGetQuery(bd, 'SELECT * FROM sites LIMIT 4')
dbGetQuery(bd, 'SELECT * FROM especes LIMIT 4')
