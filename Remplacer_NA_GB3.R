Remplacer_NA <- function(donnees_classees){ #la fonction peut prendre n'importe quel data frame/matrix mais dans notre contexte 
  #elle prend les données qui viennent d'être classées
  
  for (i in 1:nrow(donnees_classees)) {
    for (j in 1:ncol(donnees_classees)) { #double boucle pour regarder individuellement chaque entrée
      
      if (class(donnees_classees[i,j]) == "numeric") { #Si la valveur est numeric
        if (is.na(donnees_classees[i,j]) == TRUE) { #Si elle est un NA
          donnees_classees[i,j] <- 9999 #Remplacer le NA par 9999
        } 
      }
      
    } #fin boucle j
  } #fin boucle i
  
  return(donnees_classees)
  
} #fin fonction
