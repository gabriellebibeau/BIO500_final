##########  Début fonction  ###########
tab_inter <- function(tbl_rich){
  
  #1. # Créer toutes les combinaisons d'interactions possibles
    interactions <- c("largeur_riviere", "profondeur_riviere", "vitesse_courant", "temperature_eau_c", "transparence_eau")

    
  #2. Initialiser une liste pour stocker les modèles
    liste_modeles <- list()

    
  #3. Transformer la transparence en factor
    tbl_rich[,'transparence_eau'] <- factor(tbl_rich[,'transparence_eau'])
    
    
  #4. Boucle pour passer à travers toutes les combinaisons d'interactions
  for (i in 1:(length(interactions)-1)) {
    for (j in (i+1):length(interactions)) {
    
      # Sélection des variables pour le modèle actuel
      variables <- c(interactions[i], interactions[j])
    
      # Spécifier le modèle avec l'interaction actuelle
      formule <- as.formula(paste('richesse', '~', interactions[i], '*', interactions[j]))
      modele <- lm(formule, data = tbl_rich, na.action = 'na.omit')
    
      # Ajouter le modèle à la liste
      liste_modeles[[paste(interactions[i], interactions[j], sep = "_x_")]] <- modele
      
    } #fin boucle j
  } #fin boucle i

    
  #5. Dataframe pour stocker les résultats
  resultats <- data.frame(Interaction = character(),
                        p_value = numeric(),
                        stringsAsFactors = FALSE)

  
  #6. Boucler à travers les modèles pour extraire les p-valeurs
  for (nom_modele in names(liste_modeles)) {
    p_val <- summary(liste_modeles[[nom_modele]])$coefficients[2,4]
    resultats <- rbind(resultats, data.frame(Interaction = nom_modele, p_value = p_val))
  }


  #7.Mettre le tableau en image
  # Définir le dossier dans lequel l'image sera enregistrée
  dossier_rapport <- "rapport"
  
  #Définir le chemin vers l'image créée
  image <- file.path(dossier_rapport, 'tableau_interaction.png')
  
  # Ouvrir le fichier PNG
  png(image)
  gridExtra::grid.table(resultats)
  dev.off()
  
  return(resultats)

} #fin fonction
