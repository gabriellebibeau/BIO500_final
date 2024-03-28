retirer_col <- function(table_fusionnee){ #La fonction a seulement besoin d'une matrice ou data frame quelconque pour fonctionner
  
  table_fusionnee <- table_fusionnee[-1] #On enl?ve date car il est doubl? par date_obs
  
  nv_data <- c(1:nrow(table_fusionnee)) #Cr?ation d'une nouvelle table pour les colonnes utilis?es
  
  for (j in colnames(table_fusionnee)) { #boucle lisant chacune des colonnnes
    if (sum(is.na(table_fusionnee[j])) < nrow(table_fusionnee)) { #Si les colonnes ont moins de NA de le nombre de lignes (donc contiennent minimalement une entr?e)
      nv_data <- cbind(nv_data, table_fusionnee[j]) #Ajouter la colonnes de la table fusionn?e dans la nouvelle table
    }
  }
  
  nv_data <- nv_data[-1] #Enlever la premi?re colonne cr?er au d?but
  return(nv_data) #la fonction retourne la nouvelle table r?duite
}

