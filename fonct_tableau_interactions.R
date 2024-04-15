#1.Définir le répertoire
repertoire <- ('C:/Users/Laura/Documents/BIO500_final/benthos')

#2. Fonct_fus_fichier pour avoir le dataframe complet, fonct_nettoyage pour nettoyer les données et fonct_classer_col pour changer les types de données des colonnes
source("fonct_fus_fichiers.r")
df_complet <- fus_fichiers(repertoire)

source("fonct_nettoyage.R")
df_propre <- nettoyage(df_complet) 

source("fonct_classer_col.R")
df_classe <- classer_col(df_propre)

#3. # Créer toutes les combinaisons d'interactions possibles
interactions <- c("largeur_riviere", "profondeur_riviere", "vitesse_courant", "temperature_eau_c", "transparence_eau")

#4 Initialiser une liste pour stocker les modèles
liste_modeles <- list()

#5 Convertir la variable transparence_eau en type factor
df_classe$transparence_eau <- factor(df_classe$transparence_eau)

#6 Boucle pour passer à travers toutes les combinaisons d'interactions
for (i in 1:length(interactions)) {
  for (j in (i+1):length(interactions)) {
    # Spécifier le modèle avec l'interaction actuelle
    formule <- as.formula(paste("~", interactions[i], "*", interactions[j]))
    modele <- lm(formule, data = df_classe, na.action = na.exclude)
    
    # Ajouter le modèle à la liste
    liste_modeles[[paste(interactions[i], interactions[j], sep = "_x_")]] <- modele
  }
}

#7 Dataframe pour stocker les résultats
resultats <- data.frame(Interaction = character(),
                        p_value = numeric(),
                        stringsAsFactors = FALSE)

#8 Boucler à travers les modèles pour extraire les p-valeurs
for (nom_modele in names(liste_modeles)) {
  p_val <- summary(liste_modeles[[nom_modele]])$coefficients[2,4]
  resultats <- rbind(resultats, data.frame(Interaction = nom_modele, p_value = p_val))
}

#9 Affichez les résultats
print(resultats)
