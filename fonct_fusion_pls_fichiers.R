### Fonction permettant d'importer et fusionner des fichiers à partir d'une liste du nom des fichiers ###

#Exemple de liste de noms de fichiers à créer
noms_fichiers <- c("fichier1.csv", "fichier2.csv", "fichier3.csv")

#Création de la fonction
fusion_pls_fichiers <- function(noms_fichiers) {
  # Initialisation d'une liste pour stocker les dataframes lus à partir des fichiers
  list_dataframes <- list()

  # Boucle for pour lire chaque fichier et stocker le dataframe dans la liste
  for (fichier in noms_fichiers) {
    df <- read.table(fichier, header = TRUE, sep = ",") # lire le fichier 
    list_dataframes[[fichier]] <- df # stocker le dataframe dans la liste avec le nom de fichier comme clé
  }
  # Utiliser la fonction do.call avec rbind pour fusionner tous les dataframes ensemble
  df.fus <- do.call(rbind, list_dataframes)
  
  # Retourner le dataframe fusionné
  return(df.fus)
}
