extract_abond <- function(nom_fichier_SQL){
  
  bd <- dbConnect(RSQLite::SQLite(), dbname = nom_fichier_SQL)
  
  table <- dbGetQuery(bd, "SELECT 
                              sites.id_site, 
                              sites.site,
                              especes.nom_sci,
                              especes.abondance_ajust
                           FROM sites
                           INNER JOIN especes ON sites.id_site = especes.id_site
                           INNER JOIN (
                              SELECT site
                              FROM sites
                              GROUP BY site
                              HAVING COUNT(site) > 1) 
                           AS sites_multiples ON sites.site = sites_multiples.site;")
  
  dbDisconnect(bd)
  
  return(table)
}