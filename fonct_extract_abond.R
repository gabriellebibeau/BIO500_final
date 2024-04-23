#Fonction qui extrait du fichier SQLite les données d'abondance nécessaires à l'ordination

extract_abond <- function(nom_fichier_SQL){
  
  #Connextion au fichier SQLite
  bd <- dbConnect(RSQLite::SQLite(), dbname = nom_fichier_SQL)
  
  #Extration d'une table contenant seulement les données des sites ayant plus de échantillonnages
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
  
  #Déconnection du fichier SQLite
  dbDisconnect(bd)
  
  return(table)
}