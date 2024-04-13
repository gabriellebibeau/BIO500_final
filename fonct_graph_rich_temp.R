#fonction graphique richesse specifique en fonction de la temperature de la riviere

graph_rich_temp <- function(richesse, temperature) {
  bd <- dbConnect(RSQLite::SQLite(), dbname = fichier_SQL)
  
  plot(temperature, richesse, xlim = c(0, max(temperature, na.rm = TRUE)))
  reg_temperature <- lm(richesse~temperature)
  
  print(summary(reg_temperature))
  
  return(abline(reg_temperature))
}

dbDisconnect(bd)