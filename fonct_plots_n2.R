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



#plot largeur
plot(table_richesse$largeur_riviere,table_richesse$richesse, xlim = c(0,80), xlab = "Largeur de la rivière (m)", ylab = "Richesse spécifique", main = "La richesse spécifique de la rivière en fonction de sa largeur")
reg_largeur <-lm(table_richesse$richesse~table_richesse$largeur_riviere)
summary(reg_largeur)
abline(reg_largeur, col = "violet", lwd = 3)
text(x = 70, y = 50, labels = "p-value=0.895")

?text
#plot profondeur
plot(table_richesse$profondeur_riviere,table_richesse$richesse, xlim = c(0,1), xlab = "Profondeur de la rivière (m)", ylab = "Richesse spécifique", main = "La richesse spécifique de la rivière en fonction de sa profondeur")
reg_profondeur <-lm(table_richesse$richesse~table_richesse$profondeur_riviere)
summary(reg_profondeur)
abline(reg_profondeur, col = "limegreen", lwd = 3)
text(x = 0.9, y = 50, labels = "p-value=0.293")

#plot vitesse
plot_vitesse <- plot(table_richesse$vitesse_courant,table_richesse$richesse, xlim = c(0,9), xlab = "Vitesse de la rivière (m/s)", ylab = "Richesse spécifique", main = "La richesse spécifique de la rivière en fonction de la vitesse de son courant")
reg_vitesse <- lm(table_richesse$richesse~table_richesse$vitesse_courant)
summary(reg_vitesse)
abline(reg_vitesse, col = "salmon", lwd = 3)
text(x = 8, y = 50, labels = "p-value=0.532")

#plot temperature
plot_temperature <- plot(table_richesse$temperature_eau_c,table_richesse$richesse, xlim = c(0,22), xlab = "Température de la rivière (˚C)", ylab = "Richesse spécifique", main = "La richesse spécifique de la rivière en fonction de la température de l'eau")
reg_temperature <-lm(table_richesse$richesse~table_richesse$temperature_eau_c)
summary(reg_temperature) #p<0,05! p=0,0295
abline(reg_temperature, col =  "turquoise3", lwd = 3)
text(x = 19, y = 50, labels = "p-value=0,0295")

#plot transparence
donnees_trans_sp <-data.frame(table_richesse$transparence_eau, table_richesse$richesse)
colnames(donnees_trans_sp) <- c("transparence_eau", "richesse_specifique")
plot_transparence <- boxplot(richesse_specifique~transparence_eau, donnees_trans_sp, xlab = "Niveau de transparence de l'eau", ylab = "Richesse spécifique", main = "La richesse spécifique de la rivière en fonction de la transparence de son eau")
#comment tester la significativite avec un box plot?


#fonction 1
#plot transparence
donnees_trans_sp <-data.frame(table_richesse$transparence_eau, table_richesse$richesse)
colnames(donnees_trans_sp) <- c("transparence_eau", "richesse_specifique")
plot_transparence <- boxplot(richesse_specifique~transparence_eau, donnees_trans_sp, col = "lightblue", xlab = "Transparence de l'eau", ylab = "Richesse spécifique", main = "La richesse spécifique de la rivière en fonction de la transparence de l'eau")
#comment tester la significativite avec un box plot?
?boxplot

#fonction 2
par(mfrow = c(2,2))
#plot largeur
plot(table_richesse$largeur_riviere,table_richesse$richesse, xlim = c(0,80))
reg_largeur <-lm(table_richesse$richesse~table_richesse$largeur_riviere)
abline(reg_largeur)

#plot profondeur
plot(table_richesse$profondeur_riviere,table_richesse$richesse, xlim = c(0,1))
reg_profondeur <-lm(table_richesse$richesse~table_richesse$profondeur_riviere)
abline(reg_profondeur)

#plot vitesse
plot_vitesse <- plot(table_richesse$vitesse_courant,table_richesse$richesse, xlim = c(0,9))
reg_vitesse <- lm(table_richesse$richesse~table_richesse$vitesse_courant)
abline(reg_vitesse)

#plot temperature
plot_temperature <- plot(table_richesse$temperature_eau_c,table_richesse$richesse, xlim = c(0,22))
reg_temperature <-lm(table_richesse$richesse~table_richesse$temperature_eau_c)
 #p<0,05! p=0,0295
abline(reg_temperature)




#Si jamais encore utile
table_richesse[table_richesse$transparence_eau == "élevée", c("transparence_eau","richesse")]
table_richesse[table_richesse$transparence_eau == "moyenne",c("transparence_eau","richesse")]
table_richesse[table_richesse$transparence_eau == "faible",c("transparence_eau","richesse")]


