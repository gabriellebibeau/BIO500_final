boxplot_rich <- function(tbl_rich) {
  png('boxplot_richesse.png') #ouverture du png
  
  donnees_trans_sp <-data.frame(tbl_rich$transparence_eau, tbl_rich$richesse)
  colnames(donnees_trans_sp) <- c("transparence_eau", "richesse_specifique")
  plot_transparence <- boxplot(richesse_specifique~transparence_eau, donnees_trans_sp)
 
  dev.off() #fermeture et enregistrement de la figure
  
  ### Changer l'ordre des categories
  
  return(plot_transparence)
}