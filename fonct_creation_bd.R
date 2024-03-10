

#Creation de la fonction qui permettra de produire nos tables de donnees pour la base de donnees relationnelles
creation_bd <- function(donnees, bd){
  #Le fichier donn?es dit contenir les m?mes noms de variables que notre fichier df.propre

  #Creer deux tables contenant dans l'ensemble toutes les donnees necessaires ? l'analyse, li?es entre elles par l'ID_site (cl? ?trang?re).
  
  #table des abondances d'espece
  creer_especes_par_site <- 
    "CREATE TABLE especes_par_site (
      
      id_site VARCHAR(100)
      nom_sci VARCHAR(100)
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
  
}













#installer SQLite3 pour pouvoir creer les tableaux de donnees
install.packages('RSQLite')
install.packages("DBI")
library(RSQLite)

#Connection de notre fichier de donnees au serveur SQLite
bd <- dbConnect(RSQLite::SQLite(), dbname="./tables_donnees.db")

#Creer deux tables contenant dans l'ensemble toutes les donnees necessaires ? l'analyse, li?es entre elles par l'ID_site (cl? ?trang?re)

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

