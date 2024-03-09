setwd("C:/Users/manue/OneDrive - USherbrooke/Documents/Documents/Notes Université/Session 6 - UdeS/Méthodes computationnelles/GitHub/BIO500/BIO500_final/benthos")

# Ressource : https://econumuds.github.io/BIO500/sql.html
#Pas necessaire de faire fonctions pour cette partie je pense?

#installer SQLite3 pour pouvoir creer les tableaux de donnees
install.packages('RSQLite')
install.packages("DBI")
library("DBI")

#Connection de notre fichier de donnees au serveur SQLite
bd <- dbConnect(RSQLite::SQLite(), dbname="C:/Users/manue/OneDrive - USherbrooke/Documents/Documents/Notes Université/Session 6 - UdeS/Méthodes computationnelles/GitHub/BIO500/BIO500_final/benthos")

#Creer trois tables contenant dans l'ensemble toutes les donnees necessaires au travail

#Creation table donnant un id_espece a chaque espece differente observee a chaque site a une heure donnee et date donnee
creer_especes_par_site <- 
  CREATE TABLE especes_par_site (
    
    id_site VACHAR(100)
    date_obs DATE
    heure_obs 
    site VACHAR(150)
    id_espece VACHAR(100)
    
    PRIMARY KEY (date_obs, heure_obs, site, AUTREEEEE)
    FOREIGN KEY (id_site) REFERENCES infos_sites(id_site)
    FOREIGN KEY (id_espece) REFERENCES infos_especes(id_espece)
  )

#Creation table des covariables des sites
creer_infos_sites <-
  CREATE TABLE infos_sites (
    id_site VACHAR(15)
    largeur_riviere INTEGER
    temperature_eau REAL
    transparence_eau VACHAR(15)
    ETIQSTATION VACHAR(20)
  
    PRIMARY KEY (id_site)
  )



#Creation table des informations sur les id_especes
creer_infos_especes <-
  CREATE TABLE infos_especes (
    id_espece VACHAR(100)
    nom_sci VACHAR(150)
    num_taxo VACHAR(20)
    abondance INTEGER
    fraction REAL
    
    PRIMARY KEY id_espece
  )

#VERSION 2 - OPTIMALE
creer_especes_par_site <- 
  CREATE TABLE especes_par_site (
    
    id_site VACHAR(100)
    id_espece VACHAR(100)
    abondance INTEGER
    fraction REAL
    
    PRIMARY KEY (id_site, id_espece)
    FOREIGN KEY (id_site) REFERENCES infos_sites(id_site)
    FOREIGN KEY (id_espece) REFERENCES infos_especes(id_espece)
  )

#Creation table des covariables des sites
creer_infos_sites <-
  CREATE TABLE infos_sites (
    id_site VACHAR(15)
    date_obs DATE
    heure_obs 
    site VACHAR(150)
    largeur_riviere INTEGER
    temperature_eau REAL
    transparence_eau VACHAR(15)
    ETIQSTATION VACHAR(20)
    
    PRIMARY KEY (id_site)
  )



#Creation table des informations sur les id_especes
creer_infos_especes <-
  CREATE TABLE infos_especes (
    id_espece VACHAR(100)
    nom_sci VACHAR(150)
    num_taxo VACHAR(20)
    
    PRIMARY KEY (id_espece)
  )


#Injection des donnees dans les tables SQLite
dbWriteTable()

