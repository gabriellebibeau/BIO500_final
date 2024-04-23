#Fonction qui extrait du fichier SQLite les données de richesse nécessaires aux graphiques

extract_rich <- function(nom_fichier_SQL){
  
  #Connexion au fichier SQLite
  bd <- dbConnect(RSQLite::SQLite(), dbname = nom_fichier_SQL)
  
  #Extraction d'une table contenant des données de site ainsi que la richesse en groupe pour chacun
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
  
  #Déconnection du fichier SQLite
  dbDisconnect(bd)
  
  return(table)
}