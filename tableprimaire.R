setwd("C:/Users/manue/OneDrive - USherbrooke/Documents/Documents/Notes Université/Session 6 - UdeS/Méthodes computationnelles/GitHub/BIO500/BIO500_final")

#Creation de la fonction qui permettra de produire nos tables de donnees pour la base de donnees relationnelles
creation_bd <- function(donnees, dbname){
  #Le fichier données dit contenir les mêmes noms de variables que notre fichier df.propre
  #dbname correspond au chemin que l'ordinateur doit prendre pour retrouver le fichier que l'on veut créer. Donc, il s'agirait de setwd() en ajoutant à la fin de se dernier le nom du fichier contenant les tables de données et se terminant par .bd
  install.packages("RSQLite") #Le package RSQLite permet de se connecter au serveur SQLite et de l'utiliser a partir de R afin de pouvoir creer une base de donnees relationnelles
  
  #Connection de notre fichier de donnees au serveur SQLite
  bd <- dbConnect(RSQLite::SQLite(), dbname) 
  
  #Creer deux tables contenant dans l'ensemble toutes les donnees necessaires à l'analyse, liées entre elles par l'ID_site (clé étrangère).
  
  #table des abondances d'espece
  creer_especes_par_site <- 
    "CREATE TABLE especes_par_site (
      
      id_site VACHAR(100)
      nom_sci VACHAR(100)
      abondance INTEGER
      fraction REAL
      
      PRIMARY KEY (id_site, nom_sci)
      FOREIGN KEY (id_site) REFERENCES infos_sites(id_site)
    );"
  dbSendQuery(bd, creer_especes_par_site)
  
  #Creation table des sites
  creer_infos_sites <-
    
    "CREATE TABLE infos_sites (
      id_site             VARCHAR(15)
      date_obs            VARCHAR(100)
      heure_obs           DATETIME
      site                VARCHAR(150)
      largeur_riviere     INTEGER
      profondeur_riviere  INTEGER
      vitesse_courant     INTEGER
      temperature_eau_c   REAL
      transparence_eau    VARCHAR(15)
      ETIQSTATION         VARCHAR(20)
      
      PRIMARY KEY (id_site)
    );"
  dbSendQuery(bd, creer_infos_sites)
  
  #Injection des donnees dans les tables SQLite
  dbWriteTable()
  
  dbDisconnect()
}













#installer SQLite3 pour pouvoir creer les tableaux de donnees
install.packages('RSQLite')
install.packages("DBI")
library(RSQLite)

#Connection de notre fichier de donnees au serveur SQLite
bd <- dbConnect(RSQLite::SQLite(), dbname="./tables_donnees.db")

#Creer deux tables contenant dans l'ensemble toutes les donnees necessaires à l'analyse, liées entre elles par l'ID_site (clé étrangère)

#table des abondances d'espece
creer_especes_par_site <- 
  CREATE TABLE especes_par_site (
    
    id_site VACHAR(100)
    nom_sci VACHAR(100)
    abondance INTEGER
    fraction REAL
    
    PRIMARY KEY (id_site, id_espece)
    FOREIGN KEY (id_site) REFERENCES infos_sites(id_site)
  )

#Creation table des sites
creer_infos_sites <-
  CREATE TABLE infos_sites (
    id_site VACHAR(15)
    date_obs DATE
    heure_obs DATETIME
    site VACHAR(150)
    largeur_riviere INTEGER
    profondeur_riviere INTEGER
    vitesse_courant INTEGER
    temperature_eau_c REAL
    transparence_eau VACHAR(15)
    ETIQSTATION VACHAR(20)
    
    PRIMARY KEY (id_site)
  )


#Injection des donnees dans les tables SQLite
dbWriteTable()

