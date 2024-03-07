d_test <- read.csv('benthos/site_86_180_R01_2018-08-09.csv')
summary(d_test)
#j'obtiens la table fusionnée brute (résultat de l'étape 2)
#Je veux
  #1: Classer les données (étape 3) ----
    #1.1 DATE
    #1.2 TIME
    #1.3 CHAR
    #1.4 REAL
    #1.5 Création d'une fonction

  #2: Nettoyer les données (étape 4) ----
    #2.1 Enlever les colonnes ne comportant que des NA
    #2.2 Remplacer les NAs des nombres par 9999
    #2.3 Création d'une fonction