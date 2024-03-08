d_test <- read.csv('benthos/site_145_141_R01_2018-09-18.csv')
summary(d_test)
#j'obtiens la table fusionnée brute (résultat de l'étape 2)
#Je veux
  #1: Classer les données (étape 3) ----
    #1.1 DATE
      a <- as.Date(d_test$date)

    #1.2 TIME
      as.difftime(d_test[1:21,"heure_obs"], format = "%Hh%M.%S")
      as.difftime(d_test$heure_obs, units = "auto", format = "%Hh%M.%S", "%H:%M:%S")
      c <- strptime(x = d_test$heure_obs, format = "%Hh%M.%S")
      d <- chron(times. = c)

    #1.3 CHAR
      as.character(d_test[1:21, "site"])
      
    #1.4 REAL
      as.numeric(d_test[1:21, "fraction"])
      
    #1.5 Création d'une fonction
      d_test[1:nrow(d_test), vec_col[1]]
      
      Classement <- function(donnees_fusionnees){
        vec_col <- colnames(donnees_fusionnees) #Création d'un vecteur comportant le nom des colonnes
        for (k in vec_col) {
          if(k == "time_obs"){
            donnees_fusionnees[k] <- as.difftime(donnees_fusionnees[1:nrow(donnees_fusionnees), k], format = "%Hh%M.%S")
          }
          else if(k == "date" | k == "date_obs"){
            donnees_fusionnees[k] <- as.Date(donnees_fusionnees[1:nrow(donnees_fusionnees), k])
          }
          else if(k == "site" | k == "nom_sci" | k == "transparence" | k == "ETIQSTATION"){
            donnees_fusionnees[k] <- as.character(donnees_fusionnees[1:nrow(donnees_fusionnees), k])
          }
          else{
            donnees_fusionnees[k] <- as.numeric(donnees_fusionnees[1:nrow(donnees_fusionnees), k])
          }
        }
        
    
      } #fin fonction

  #2: Nettoyer les données (étape 4) ----
    #2.1 Enlever les colonnes ne comportant que des NA
      nv_data <- c(1:nrow(d_test))
      for (j in colnames(d_test)) {
        if (sum(is.na(d_test[j])) < nrow(d_test)) {
          nv_data <- cbind(nv_data, d_test[j])
        }
      }
      #testée et fonctionnelle
      
    #2.2 Remplacer les NAs des nombres par 9999
      for (i in 1:nrow(d_test)) {
        for (j in 1:ncol(d_test)) {
          if (class(d_test[i,j]) == "numeric")
          if (is.na(d_test[i,j]) == TRUE) {
          d_test[i,j] <- 9999
          }
        }
      } #testée et fonctionnelle
      
    #2.3 Création d'une fonction