Enlever_lignes <- function(donnees) {
  
  for (m in 1:nrow(donnees)) {
    for (n in 4:ncol(donnees)) {

      if(is.na(donnees[m,n]) == FALSE) {
        if(donnees[m,n] == '-99'){
          donnees[m,n] <- NA
        }
      }
      
    }#fin boucle n
  }#fin boucle m
  
  return(donnees)
}#fin fonction


