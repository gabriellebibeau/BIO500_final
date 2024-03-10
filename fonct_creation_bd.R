### Fonction permettant de produire nos tables de données dans la base de données relationnelle


# Objets à spécifier pour utiliser la fonction
  #bd <- dbConnect(RSQLite::SQLite(), dbname) #dbname est le chemin vers le nouveau fichier crée contenant la base de données relationnelle
  

#Creation de la fonction
creation_bd <- function(donnees, bd){ #donnees doit être remplacer par le dataframe contenant les données à utiliser
  #Note: Le dataframe de données doit contenir les mêmes noms de variables que notre fichier df.propre

  #Creer deux tables contenant dans l'ensemble toutes les donnees necessaires ? l'analyse, li?es entre elles par l'ID_site (cl? ?trang?re).
    #Table des abondances d'espèces
    creer_especes_par_site <- 
    "CREATE TABLE especes_par_site (
     
      id_site   VARCHAR(100)
      nom_sci   VARCHAR(100)
      abondance INTEGER
      fraction  REAL
        
      PRIMARY KEY (id_site, nom_sci)
      FOREIGN KEY (id_site) REFERENCES infos_sites(id_site)
      );"
    dbSendQuery(bd, creer_especes_par_site)
  
    #Table des sites
    creer_infos_sites <-
    "CREATE TABLE infos_sites (
    
      id_site             VARCHAR(15)
      site                VARCHAR(150)
      date_obs            VARCHAR(100)
      heure_obs           DATETIME
      largeur_riviere     INTEGER
      profondeur_riviere  INTEGER
      vitesse_courant     INTEGER
      temperature_eau_c   REAL
      transparence_eau    VARCHAR(15)
      ETIQSTATION         VARCHAR(20)
      
      PRIMARY KEY (id_site)
      );"
    dbSendQuery(bd, creer_infos_sites)
  
    # Injection des enregistrements dans la base
    dbWriteTable(bd, append = TRUE, name = "especes_par_site", value = donnees, row.names = FALSE)
    dbWriteTable(bd, append = TRUE, name = "infos_sites", value = donnees, row.names = FALSE)
    
    return(print("Good job!"))
}
