#fonction graphique richesse specifique en fonction de la profondeur de la riviere

graph_rich_prof <- function(richesse, profondeur) {
  bd <- dbConnect(RSQLite::SQLite(), dbname = fichier_SQL)
  
  plot(profondeur, richesse, xlim = c(0, max(profondeur, na.rm = TRUE)))
  reg_profondeur <- lm(richesse~profondeur)
  
  print(summary(reg_profondeur))
  
  return(abline(reg_profondeur))
}

dbDisconnect(bd)