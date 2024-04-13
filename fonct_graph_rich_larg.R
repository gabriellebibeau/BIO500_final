#fonction graphique richesse specifique en fonction de la largeur de la riviere

graph_rich_larg <- function(richesse, largeur) {
  bd <- dbConnect(RSQLite::SQLite(), dbname = fichier_SQL)
  
  plot(largeur, richesse, xlim = c(0, max(largeur, na.rm = TRUE)))
  reg_largeur <- lm(richesse~largeur)
  
  print(summary(reg_largeur))
  
  return(abline(reg_largeur))
}

dbDisconnect(bd)
