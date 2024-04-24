################# FONCTION ORDINATION EFFET SITES ######################

ordination_sites <- function(tbl_abd){ #on rentre la table d'abondance
  
  #1. Boucle pour enlever NA
  
  for (j in 1:ncol(tbl_abd)) {
    for (i in 1:nrow(tbl_abd)) { #pour toutes les données...
      
      if(is.na(tbl_abd[i,j]) == TRUE){ #Si c'est un NA,
        tbl_abd <- tbl_abd[-i,] #L'enlever
      }
      
    }#fin boucle for i
  }#fin boucle for j
  
  
  #2. Boucle pour faire une nouvelle matrice d'abondance
  
  mat_abd <- matrix(0, nrow = length(unique(tbl_abd$id_site)), ncol = length(unique(tbl_abd$nom_sci)), 
                    dimnames = list(unique(tbl_abd$id_site), unique(tbl_abd$nom_sci))) #matrice vide
  
  for (j in 1:ncol(mat_abd)) {
    for (i in 1:nrow(mat_abd)) { #pour toutes les données...
      
      #mettre la bonne abondance pour le bon id de site et unités taxonomiques observées
      try(mat_abd[i,j] <- tbl_abd$abondance_ajust[tbl_abd$id_site == rownames(mat_abd)[i] & 
                                                    tbl_abd$nom_sci == colnames(mat_abd)[j]])
      
    }#fin boucle for i
    
  }#fin boucle for j
  
  #3. Matrice de distance Bray-Curtis
  dist_Bray <- vegdist(mat_abd, method="bray")
  
  #4. Ordination
  
  #4.1 Points ordination
    pcoa <- cmdscale(dist_Bray, k=2, eig = TRUE) #Faire la PCoA
    pts <- as.data.frame(pcoa$points) #Extraire les points
    colnames(pts) <- c('pcoa1', 'pcoa2') #changer les noms de colonnes des points
  
  #4.2 Pourcentage d'explication
    pourcentage <- 100*pcoa$eig / sum(pcoa$eig) #trouver les pourcentages explicatifs
    prct_axe1 <- round(pourcentage[1], digits = 1) #Extraire pour le 1er axe
    prct_axe2 <- round(pourcentage[2], digits = 1) #Extraire pour le 2e axe
  
  #4.3 Nom de sites dans le data frame des points
    site <- vector(length = nrow(pts)) #vecteur vide
  
    for (i in 1:nrow(pts)) { #boucle pour mettre le bon nom de site au bon id_site
    
      site[i] <- unique(tbl_abd$site[tbl_abd$id_site == rownames(pts)[i]])
    
    }#fin boucle for i
  
    pts_site <- cbind(pts, site)
  
  #4.4 Visualisation avec ggplot2 et enregistrement
    nom_axe <- c(glue('PCo 1 ({prct_axe1}%)'), glue('PCo 2 ({prct_axe2}%)')) #Noms des axes récurssifs
  
    ordination <- ggplot(data = pts_site, aes(x = pcoa1, y = pcoa2, color = site)) + #le graphique
      geom_point() +
      stat_ellipse() +
      labs(x = nom_axe[1], y = nom_axe[2]) +
      theme_minimal()
    
    # Définir le dossier dans lequel l'image sera enregistrée
    dossier_rapport <- "rapport"
    
    #Définir le chemin vers l'image créée
    image <- file.path(dossier_rapport, 'ordination_sites.pdf')
    
    ggsave(image, ordination)
    
    return(pcoa)
  
} #fin fonction

