boxplot_rich <- function(tbl_rich) {
  
  # Définir le dossier dans lequel l'image sera enregistrée
  dossier_rapport <- "rapport"
  
  #Définir le chemin vers l'image créée
  image <- file.path(dossier_rapport, 'boxplot_richesse.png')
  
  # Ouvrir le fichier PNG
  png(image)
  
  donnees_trans_sp <-data.frame(table_richesse$transparence_eau, table_richesse$richesse)
  colnames(donnees_trans_sp) <- c("transparence_eau", "richesse_specifique")
  plot_transparence <- boxplot(richesse_specifique~transparence_eau, donnees_trans_sp, col = "lightblue", xlab = "Transparence de l'eau", ylab = "Richesse spécifique", main = "La richesse spécifique de la rivière en fonction de la transparence de l'eau")
 
  dev.off() #fermeture et enregistrement de la figure
  
  ### Changer l'ordre des categories
  
  return(plot_transparence)
}