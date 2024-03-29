retirer_col <- function(table_fusionnee){ #La fonction a seulement besoin d'une matrice ou data frame quelconque pour fonctionner
  
  #1. Création d'une nouvelle table pour les colonnes utilisées
  nv_data <- c(1:nrow(table_fusionnee)) 
  
  #2. Enlever les colonnes ne contenant que des NAs
  for (k in colnames(table_fusionnee)) { #boucle lisant chacune des colonnnes
    if(k == colnames(table_fusionnee[1])){ #si c'est la première colonne (qui est toujours pertinente ;) )
      nv_data <- table_fusionnee[1] #mettre la première colonne dans la nouvelle première colonne
    }
    
    else{ #si ce n'est pas la première colonne de la table originale
      
      if(sum(is.na(table_fusionnee[k])) < nrow(table_fusionnee)) { #Si les colonnes ont moins de NA de le nombre de lignes (donc contiennent minimalement une entrée)
        nv_data <- cbind(nv_data, table_fusionnee[k]) #Ajouter la colonnes de la table fusionnée dans la nouvelle table pertinente
      }
      
    } #fin else
  } #fin boucle for
  
  return(nv_data) #la fonction retourne la nouvelle table réduite
} #fin fonction

#3. Enlever les colonnes doubles qui veulent dire la même choses 
for (h in 1:ncol(nv_table)) { 
  for (i in 1:ncol(nv_table)) {
    for (j in 1:nrow(table_fusionnee)) {
      
      if(nv_table[j,h] == nv_table[j,i]) {
        
      }
      
    } #fin for j
  } #fin for i
} #fin for h
