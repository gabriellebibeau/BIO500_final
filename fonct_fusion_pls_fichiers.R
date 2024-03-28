### Fonction permettant d'importer et fusionner des fichiers d'un même type dans un répertoire spécifique ###


# Objets à spécifier pour utiliser la fonction
  #repertoire <- "./data/" # Spécifiez le chemin du répertoire contenant les fichiers
  #type_fichier <- "\\.csv$" # Motif de nom de fichier pour sélectionner tous les fichiers .csv

# Note: la fonction est paramétrée pour des fichiers ayant une ligne d'en-tête et dont les colonnes sont séparées par des vigules


#Création de la fonction
fusion_pls_fichiers <- function(repertoire, type_fichier) {
  
  # Créer une liste de tous les fichiers correspondant au motif de nom dans le répertoire
  fichiers <- list.files(pattern = type_fichier, path = repertoire, full.names = TRUE)

  # Utilise lapply pour lire tous les fichiers et fusionner les dataframes
  df.fus <- do.call(rbind, lapply(fichiers, function(fichier) {
    read.table(fichier, header = TRUE, sep = ",") # lire un fichier ayant une ligne d'en-tête et dont les colonnes sont séparés par des vigules
  }))
  # Retourner le dataframe fusionné
  return(df.fus)
}

