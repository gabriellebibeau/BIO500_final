### Fonction permettant de produire nos tables de données dans la base de données relationnelle

creation_bd <- function(df_sites, df_especes){ #df.site/especes doivent être remplacer par les dataframes contenant les données à utiliser
  #Note: Le dataframe de données doit contenir les mêmes noms de colonnes que la base de données créée

  library(RSQLite)
  
  #Connection de notre fichier de donnees au serveur SQLite
  bd <- dbConnect(RSQLite::SQLite(), dbname = "bd_benthos.bd") #dbname correspond au chemin que l'ordinateur doit prendre pour retrouver le fichier que l'on veut cr?er. Donc, il s'agirait de setwd() en ajoutant ? la fin de se dernier le nom du fichier contenant les tables de donn?es et se terminant par .bd
  
  #Creer deux tables contenant dans l'ensemble toutes les donnees necessaires ? l'analyse, li?es entre elles par l'ID_site (cl? ?trang?re).
  #Table des sites
  creer_infos_sites <-
    "CREATE TABLE sites (
    
      id_site             INTEGER(15),
      site                VARCHAR(150),
      date                VARCHAR(100),
      heure_obs           VARCHAR(30),
      largeur_riviere     REAL,
      profondeur_riviere  REAL,
      vitesse_courant     REAL,
      temperature_eau_c   REAL,
      transparence_eau    VARCHAR(15),
      ETIQSTATION         VARCHAR(20),
      
      PRIMARY KEY (id_site)
      );"
  
  dbSendQuery(bd, creer_infos_sites)
  
   #Table des abondances d'espèces
    creer_especes_par_site <- 
    "CREATE TABLE especes (
     
      id_site   VARCHAR(100),
      nom_sci   VARCHAR(100),
      abondance INTEGER,
      fraction  REAL,
        
      PRIMARY KEY (id_site, nom_sci),
      FOREIGN KEY (id_site) REFERENCES infos_sites(id_site)
      );"
    dbSendQuery(bd, creer_especes_par_site)

    dbDisconnect(bd)
    bd <- dbConnect(RSQLite::SQLite(), dbname = "bd_benthos.bd")
    
    # Injection des enregistrements dans la base
    dbWriteTable(bd, append = TRUE, name = "especes", value = df_especes, row.names = FALSE)
    dbWriteTable(bd, append = TRUE, name = "sites", value = df_sites, row.names = FALSE)
    
    dbDisconnect(bd)
    
    return(print("Good job!"))
}

