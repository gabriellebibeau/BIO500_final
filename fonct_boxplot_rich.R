boxplot_rich <- function(tbl_rich) {
  
  # Définir le dossier dans lequel l'image sera enregistrée
  dossier_rapport <- "rapport"
  
  #Définir le chemin vers l'image créée
  image <- file.path(dossier_rapport, 'boxplot_richesse.png')
  
  # Ouvrir le fichier PNG
  png(image)
  
  # Créer l'ordre de préférence
  tbl_rich$transparence_eau <- factor(tbl_rich$transparence_eau , levels=c("faible", "moyenne", "élevée"))
  
  donnees_trans_sp <-data.frame(tbl_rich$transparence_eau, tbl_rich$richesse)
  colnames(donnees_trans_sp) <- c("transparence_eau", "richesse_specifique")
  plot_transparence <- boxplot(richesse_specifique~transparence_eau, donnees_trans_sp, col = "lightblue", xlab = "Transparence de l'eau", ylab = "Richesse spécifique")
  
  dev.off() #fermeture et enregistrement de la figure
  
  ### Changer l'ordre des categories
  
  return(plot_transparence)
}
