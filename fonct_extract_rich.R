extract_rich <- function(nom_fichier_SQL){
  
  bd <- dbConnect(RSQLite::SQLite(), dbname = nom_fichier_SQL)
  
  table <- dbGetQuery(bd, "SELECT 
                              sites.id_site, 
                              sites.largeur_riviere, 
                              sites.profondeur_riviere, 
                              sites.vitesse_courant, 
                              sites.temperature_eau_c, 
                              sites.transparence_eau, 
                              COUNT(especes.nom_sci) AS richesse 
                           FROM sites
                           LEFT JOIN especes ON sites.id_site = especes.id_site
                           GROUP BY sites.id_site")
  dbDisconnect(bd)
  return(table)
}