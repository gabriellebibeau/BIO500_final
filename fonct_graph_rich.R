graph_rich <- function(tbl_rich) {
  # Fonction établissant les corrélations entre la richesse spécifique des différents sites selon quatre variables abiotiques étudiées (la largeur de la rivière, la profondeur, la vitesse du courant et la température de l'eau).
  # La fonction crée quatre graphiques affichant les régressions représentant chacun individuellement une de ces quatre corrélations ainsi que le p-value de chaque régression.
  # Ces graphiques permettront aux lecteurs de visualiser nos résultats.
  # Les quatre graphiques sont insérés dans la même figure, car ils suivent la même analyse et le même type de régression. Cela permet de les comparer entre eux.
  
  # Définir le dossier dans lequel l'image sera enregistrée
  dossier_rapport <- "rapport"
  
  # Définir le chemin vers l'image créée
  image <- file.path(dossier_rapport, "regression_richesse.pdf")
  
  # Ouvrir le fichier PNG
  pdf(image)
  # Les quatres graphiques sont inclues dans la même image
  par(mfrow = c(2, 2)) 
  
  # Les mêmes étapes de création des graphiques et des régressions linéaires décrites pour le premier graphique ci-dessous sont ensuite répétées pour chacun des trois autres graphiques
  # Les couleurs des graphiques ont été choisies aléatoirement.
  # Graphique de la richesse spécifique en fonction de la largeur de la rivière
  plot(tbl_rich$largeur_riviere,tbl_rich$richesse, xlim = c(0,80), xlab = "Largeur de la rivière (m)", ylab = "Richesse spécifique")
  # Établir quelle est la relation entre ces deux variables et si elle est significative
  reg_largeur <-lm(tbl_rich$richesse~tbl_rich$largeur_riviere)
  summary(reg_largeur)
  # Afficher la régression sur le graphique (quelle soit significative ou non)
  abline(reg_largeur, col = "violet", lwd = 3)
  # Afficher la valeur de p de la régression sur le graphique
  text(x = 65, y = 50, labels = "p-value=0.895")
 
  # Graphique de la richesse spécifique en fonction de la profondeur de la rivière
  plot(tbl_rich$profondeur_riviere,tbl_rich$richesse, xlim = c(0,1), xlab = "Profondeur de la rivière (m)", ylab = "Richesse spécifique")
  reg_profondeur <-lm(tbl_rich$richesse~tbl_rich$profondeur_riviere)
  summary(reg_profondeur)
  abline(reg_profondeur, col = "limegreen", lwd = 3)
  text(x = 0.8, y = 50, labels = "p-value=0.293")
   
  # Graphique de la richesse spécifique en fonction de la  vitesse du courant de la rivière
  plot_vitesse <- plot(tbl_rich$vitesse_courant,tbl_rich$richesse, xlim = c(0,9), xlab = "Vitesse de la rivière (m/s)", ylab = "Richesse spécifique")
  reg_vitesse <- lm(tbl_rich$richesse~tbl_rich$vitesse_courant)
  summary(reg_vitesse)
  abline(reg_vitesse, col = "salmon", lwd = 3)
  text(x = 7.2, y = 50, labels = "p-value=0.532")
  
  #Graphique de la richesse spécifique en fonction de la température de l'eau de la rivière
  plot_temperature <- plot(tbl_rich$temperature_eau_c,tbl_rich$richesse, xlim = c(0,22), xlab = "Température de la rivière (˚C)", ylab = "Richesse spécifique")
  reg_temperature <-lm(tbl_rich$richesse~tbl_rich$temperature_eau_c)
  summary(reg_temperature) #p<0,05! p=0,0295
  abline(reg_temperature, col =  "turquoise3", lwd = 3)
  text(x = 18, y = 50, labels = "p-value=0,030")
  
  dev.off() #fermeture et enregistrement de l'image
  
  return('regression_richesse.png') #retourner l'image 
}
