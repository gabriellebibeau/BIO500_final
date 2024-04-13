setwd("C:/Users/manue/OneDrive - USherbrooke/Documents/Documents/Notes Université/Session 6 - UdeS/Méthodes computationnelles/GitHub/BIO500/BIO500_final")
library("RSQLite")
# 1. Importer les fichiers.csv du répertoire et les fusionner avec la fonction fusion_pls_fichiers

#Définir les objects de la fonction
repertoire <- ("C:/Users/manue/OneDrive - USherbrooke/Documents/Documents/Notes Université/Session 6 - UdeS/Méthodes computationnelles/GitHub/BIO500/BIO500_final/benthos") #Spécifier le chemin vers le dossier contenant les fichiers
#Spécifier le chemin vers le dossier contenant les fichiers


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
fichier_SQL  <- creation_bd(df_sites, df_especes)

#7. Extraire les données des tables SQLite

source("fonct_extract_rich.R")
table_richesse <- extract_rich(fichier_SQL)

source("fonct_extract_abond.R")
table_abondance <- extract_abond(fichier_SQL)


#plots de la richesse specifique selon les 5 variables abiotique decrivant sites
bd <- dbConnect(RSQLite::SQLite(), dbname = fichier_SQL)

donnees_sites <- dbGetQuery(bd, 'SELECT * FROM sites') 

#plot largeur
plot(table_richesse$largeur_riviere,table_richesse$richesse, xlim = c(0,30))
reg_largeur <-lm(table_richesse$richesse~table_richesse$largeur_riviere)
summary(reg_largeur)
abline(reg_largeur)

#plot profondeur
plot(table_richesse$profondeur_riviere,table_richesse$richesse, xlim = c(0,1))
reg_profondeur <-lm(table_richesse$richesse~table_richesse$profondeur_riviere)
summary(reg_profondeur)
abline(reg_profondeur)

#plot vreg_profondeur#plot vitesse
plot_vitesse <- plot(table_richesse$vitesse_courant,table_richesse$richesse, xlim = c(0,9))
reg_vitesse <- lm(table_richesse$richesse~table_richesse$vitesse_courant)
summary(reg_vitesse)
abline(reg_vitesse)

#plot temperature
plot_temperature <- plot(table_richesse$temperature_eau_c,table_richesse$richesse, xlim = c(0,22))
reg_temperature <-lm(table_richesse$richesse~table_richesse$temperature_eau_c)
summary(reg_temperature) #p<0,05! p=0,0295
abline(reg_temperature)

#plot transparence
donnees_trans_sp <-data.frame(table_richesse$transparence_eau, table_richesse$richesse,)
colnames(donnees_trans_sp) <- c("transparence_eau", "richesse_specifique")
plot_transparence <- boxplot(richesse_specifique~transparence_eau, donnees_trans_sp)
#comment tester la significativite avec un box plot?


#Si jamais encore utile
table_richesse[table_richesse$transparence_eau == "élevée", c("transparence_eau","richesse")]
table_richesse[table_richesse$transparence_eau == "moyenne",c("transparence_eau","richesse")]
table_richesse[table_richesse$transparence_eau == "faible",c("transparence_eau","richesse")]


