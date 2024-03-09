Classer_colonnes <- function(donnees_fusionnees_pertinentes){ #La fonction ne peut prendre que des tables portant les titres de colonnes des données Benthos
  #On devrait mettre dans la fonction les données brutes fusionnées, puis dont les colonnes sans entrées ont été enlevées.
  
  vec_col <- colnames(donnees_fusionnees_pertinentes) #Création d'un vecteur comportant le nom des colonnes
    for (k in vec_col) { #Boucle passant par chacune des colonnes
      if(k == "heure_obs"){ #Si c'est la colonne du temps
        donnees_fusionnees_pertinentes[k] <- as.difftime(donnees_fusionnees_pertinentes[1:nrow(donnees_fusionnees_pertinentes), k], format = "%Hh%M.%S")
      } #mettre les valeurs de cette colonne en difftime (h)
      
        else if(k == "date" | k == "date_obs"){ #Si c'est une des deux colonnes de date
          donnees_fusionnees_pertinentes[k] <- as.Date(donnees_fusionnees_pertinentes[1:nrow(donnees_fusionnees_pertinentes), k])
        }#mettre les valeurs de cette colonne en format Date
      
        else if(k == "site" | k == "nom_sci" | k == "transparence_eau" | k == "ETIQSTATION"){ #Si colonne en mots
          donnees_fusionnees_pertinentes[k] <- as.character(donnees_fusionnees_pertinentes[1:nrow(donnees_fusionnees_pertinentes), k])
        } #mettre les valeurs de cette colonne en character
      
          else{ #pour les autres colonnes
          donnees_fusionnees_pertinentes[k] <- as.numeric(donnees_fusionnees_pertinentes[1:nrow(donnees_fusionnees_pertinentes), k])
          } #mettre en numeric
      
  } #fin de la boucle
  
  print(summary(donnees_fusionnees_pertinentes)) #aperçu des classes
  return(donnees_fusionnees_pertinentes) #Retour de la table initiale dont les valeurs sont maintenant bien classées
  
} #fin fonction
