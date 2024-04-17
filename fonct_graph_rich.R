graph_rich <- function(tbl_rich) {

  #plot largeur
  plot(tbl_rich$largeur_riviere,tbl_rich$richesse, xlim = c(0,80))
  reg_largeur <-lm(tbl_rich$richesse~tbl_rich$largeur_riviere)
  summary(reg_largeur)
  abline(reg_largeur)
  
  #plot profondeur
  plot(tbl_rich$profondeur_riviere,tbl_rich$richesse, xlim = c(0,1))
  reg_profondeur <-lm(tbl_rich$richesse~tbl_rich$profondeur_riviere)
  summary(reg_profondeur)
  abline(reg_profondeur)
  
  #plot vitesse
  plot_vitesse <- plot(tbl_rich$vitesse_courant,tbl_rich$richesse, xlim = c(0,9))
  reg_vitesse <- lm(tbl_rich$richesse~tbl_rich$vitesse_courant)
  summary(reg_vitesse)
  abline(reg_vitesse)
  
  #plot temperature
  plot_temperature <- plot(tbl_rich$temperature_eau_c,tbl_rich$richesse, xlim = c(0,22))
  reg_temperature <-lm(tbl_rich$richesse~tbl_rich$temperature_eau_c)
  summary(reg_temperature) #p<0,05! p=0,0295
  abline(reg_temperature)
  
  return()
}
