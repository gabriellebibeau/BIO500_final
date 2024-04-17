#1.Définir le répertoire
repertoire <- ('C:/Users/Laura/Documents/BIO500_final/benthos')

#2.Début fonction
tableau <- function(df_sites){
  
   #3. # Créer toutes les combinaisons d'interactions possibles
interactions <- c("largeur_riviere", "profondeur_riviere", "vitesse_courant", "temperature_eau_c", "transparence_eau")

   #4. Initialiser une liste pour stocker les modèles
liste_modeles <- list()

   #5. Convertir la variable transparence_eau en type factor
df_classe$transparence_eau <- factor(df_classe$transparence_eau)

   #6. Boucle pour passer à travers toutes les combinaisons d'interactions
for (i in 1:(length(interactions)-1)) {
  for (j in (i+1):length(interactions)) {
    
    # Sélection des variables pour le modèle actuel
    variables <- c(interactions[i], interactions[j])
    
    # Supprimer les lignes avec des NA pour les variables utilisées dans le modèle actuel
    df_sites_no_na <- na.omit(df_sites[variables])
    
    # Spécifier le modèle avec l'interaction actuelle
    formule <- as.formula(paste("~", interactions[i], "*", interactions[j]))
    modele <- lm(formule, data = df_sites_no_na)
    
    # Ajouter le modèle à la liste
    liste_modeles[[paste(interactions[i], interactions[j], sep = "_x_")]] <- modele
  }
}  

   #7. Dataframe pour stocker les résultats
resultats <- data.frame(Interaction = character(),
                        p_value = numeric(),
                        stringsAsFactors = FALSE)

   #8. Boucler à travers les modèles pour extraire les p-valeurs
for (nom_modele in names(liste_modeles)) {
  p_val <- summary(liste_modeles[[nom_modele]])$coefficients[2,4]
  resultats <- rbind(resultats, data.frame(Interaction = nom_modele, p_value = p_val))
}

   #9. Affichez les résultats
print(resultats)

   #10.Mettre le tableau en image
library(grid)
tableau_image <- tableGrob(
  resultats,
  rows = NULL,
  theme = ttheme_default(core=list(bg_params = list(fill = 'grey99')))
  )

grid.draw(tableau_image)

} #fin fonction