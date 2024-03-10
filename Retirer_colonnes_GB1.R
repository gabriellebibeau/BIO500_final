Retirer_colonnes <- function(table_fusionnee){ #La fonction a seulement besoin d'une matrice ou data frame quelconque pour fonctionner
  
  table_fusionnee <- table_fusionnee[-1] #On enlève date car il est doublé par date_obs
  
  nv_data <- c(1:nrow(table_fusionnee)) #Création d'une nouvelle table pour les colonnes utilisées
  
  for (j in colnames(table_fusionnee)) { #boucle lisant chacune des colonnnes
    if (sum(is.na(table_fusionnee[j])) < nrow(table_fusionnee)) { #Si les colonnes ont moins de NA de le nombre de lignes (donc contiennent minimalement une entrée)
      nv_data <- cbind(nv_data, table_fusionnee[j]) #Ajouter la colonnes de la table fusionnée dans la nouvelle table
    }
  }
  
  nv_data <- nv_data[-1] #Enlever la première colonne créer au début
  return(nv_data) #la fonction retourne la nouvelle table réduite
}

