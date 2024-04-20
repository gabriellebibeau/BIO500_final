graph_rich <- function(tbl_rich) {
  
  # Définir le dossier dans lequel l'image sera enregistrée
  dossier_rapport <- "rapport"
  
  #Définir le chemin vers l'image créée
  image <- file.path(dossier_rapport, "regression_richesse.png")
  
  # Ouvrir le fichier PNG
  png(image)
  par(mfrow = c(2, 2)) 
  
  #plot largeur
  plot(tbl_rich$largeur_riviere,tbl_rich$richesse, xlim = c(0,80), ylim = c(0,55))
  reg_largeur <-lm(tbl_rich$richesse~tbl_rich$largeur_riviere)
  summary(reg_largeur)
  abline(reg_largeur)
  
  #plot profondeur
  plot(tbl_rich$profondeur_riviere,tbl_rich$richesse, xlim = c(0,1), ylim = c(0,55))
  reg_profondeur <-lm(tbl_rich$richesse~tbl_rich$profondeur_riviere)
  summary(reg_profondeur)
  abline(reg_profondeur)
  
  #plot vitesse
  plot(tbl_rich$vitesse_courant,tbl_rich$richesse, xlim = c(0,9), ylim = c(0,55))
  reg_vitesse <- lm(tbl_rich$richesse~tbl_rich$vitesse_courant)
  summary(reg_vitesse)
  abline(reg_vitesse)
  
  #plot temperature
  plot(tbl_rich$temperature_eau_c,tbl_rich$richesse, xlim = c(0,22), ylim = c(0,55))
  reg_temperature <-lm(tbl_rich$richesse~tbl_rich$temperature_eau_c)
  summary(reg_temperature) #p<0,05! p=0,0295
  abline(reg_temperature)
  
  dev.off() #fermeture et enregistrement de l'image
  
  return('regression_richesse.png') #retourner l'image 
}
