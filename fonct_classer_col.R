#Fonction modifiant les classes des colonnes

classer_col <- function(donnees_fus_pert){ #La fonction ne peut prendre que des tables portant les titres de colonnes des données Benthos
  #On devrait mettre dans la fonction les donn?es brutes fusionnées, puis dont les colonnes sans entr?es ont ?t? enlev?es.
  
  donnees_fusionnees_pertinentes <- donnees_fus_pert #copie des données
  
  vec_col <- colnames(donnees_fusionnees_pertinentes) #Création d'un vecteur comportant le nom des colonnes
    for (k in vec_col) { #Boucle passant par chacune des colonnes
      if(k == "heure_obs"){ #Si c'est la colonne du temps
        donnees_fusionnees_pertinentes[k] <- as.difftime(donnees_fusionnees_pertinentes[1:nrow(donnees_fusionnees_pertinentes), k], format = "%Hh%M.%S")
      
        #Pour modifier les données ayant le 2e type de format
        for (l in 1:nrow(donnees_fusionnees_pertinentes)) {
          if(is.na(donnees_fusionnees_pertinentes[l,k]) == TRUE){
            donnees_fusionnees_pertinentes[l,k] <- as.difftime(donnees_fus_pert[l,k])
          } #fin de la boucle l
          
        } #fin de la boucle k
        
        } #mettre les valeurs de cette colonne en difftime (h)
      
        else if(k == "site" | k == "date" | k == "nom_sci" | k == "transparence_eau" | k == "ETIQSTATION"){ #Si colonne en mots
          donnees_fusionnees_pertinentes[k] <- as.character(donnees_fusionnees_pertinentes[1:nrow(donnees_fusionnees_pertinentes), k])
        } #mettre les valeurs de cette colonne en character
      
          else{ #pour les autres colonnes
          donnees_fusionnees_pertinentes[k] <- as.numeric(donnees_fusionnees_pertinentes[1:nrow(donnees_fusionnees_pertinentes), k])
          } #mettre en numeric
      
  } #fin de la boucle k
  
  return(donnees_fusionnees_pertinentes) #Retour de la table initiale dont les valeurs sont maintenant bien class?es
  
} #fin fonction

