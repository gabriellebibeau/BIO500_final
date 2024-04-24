boxplot_rich <- function(tbl_rich) {
  
# Ouvrir le fichier PNG
  png('boxplot_richesse.png')
  
  # Créer l'ordre de préférence
  tbl_rich$transparence_eau <- factor(tbl_rich$transparence_eau , levels=c("faible", "moyenne", "élevée"))
  
  #Création du boxplot
  donnees_trans_sp <-data.frame(tbl_rich$transparence_eau, tbl_rich$richesse)
  colnames(donnees_trans_sp) <- c("transparence_eau", "richesse_specifique") #bon nom de colonnes
  plot_transparence <- boxplot(richesse_specifique~transparence_eau, donnees_trans_sp, col = "lightblue", xlab = "Transparence de l'eau", ylab = "Richesse spécifique")
  
  dev.off() #fermeture et enregistrement de la figure
  
  return(plot_transparence)
}
