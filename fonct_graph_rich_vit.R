#graph richesse specifique en fonction de la vitesse du courant de la riviere

graph_rich_vit <- function(richesse, vitesse) {
  bd <- dbConnect(RSQLite::SQLite(), dbname = fichier_SQL)
  
  plot(vitesse, richesse, xlim = c(0, max(vitesse, na.rm = TRUE)))
  reg_vitesse <- lm(richesse~vitesse)
  
  print(summary(reg_vitesse))
  
  return(abline(reg_vitesse))
}

dbDisconnect(bd)
