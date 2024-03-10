#Afficher le répertoire de travail
getwd()

#Lecture du fichier CSV/table complète
donnees <- read.csv("site_86_180_R01_2018-08-09.csv")
donnees

#Installer le package dyplyr
install.packages("dplyr")
library(dplyr)

#Sortir tous les genres/espèces différentes **le refaire sur table complète, car il n'y a pas tous les genres/espèces listées ici
especesougenres_uniques <- unique(donnees$nom_sci)
print(especesougenres_uniques)

#Fonction (mettre la table complète en argument)#
traitement_donnees_codes_espèces <- function(donnees) {

#Insérer une colonne vide pour les numéros taxonomiques
donnees1 <- mutate(donnees, 'numero_taxonomique' = NA)

#Faire un dataframe «correspondance» qui associe les numéros taxonomiques à leur espèce/genre correspondant et merger celui-ci avec le jeu de données «donnees» **rajouter les autres, voir site pour numéros taxonomiques: https://www.itis.gov/
correspondance <- data.frame(
  'Espèce ou genre' = c('Acentrella', 'Baetis', 'Heterocloeon', 'Ephemerella', 'Siphlonurus', 'Stactobiella', 'Psychoglypha', 'Rhyacophila', 'Leuctra', 'Tanytarsini', 'Diamesinae', 'Orthocladiinae', 'Tanypodinae', 'Pentaneurini', 'Simuliidae', 'Prosimulium', 'Simulium', 'Tipula', 'Acari', 'Oligochaeta', 'Nematoda'),
  'numero_taxonomique' = c('100801', '100800', '100794', '101233', '100953', '115817', '115974', '115097', '102844', '129872', '128341', '128457', '127994', '128078', '126640', '126703', '126774', '119037', '733321', '68422', '59490')
)
donnees2 <- merge(donnees1, correspondance, by.x = 'nom_sci', by.y = 'Espèce.ou.genre', all.x = TRUE)

#Réorganiser les colonnes du tableau final et renommer la colonne «numero_taxonomique»'
donnees3 <- donnees2[, c(2, 3, 4, 5, 6, 1, 32, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30)]
donnees4 <- donnees3 %>% rename(numero_taxonomique = numero_taxonomique.y)
}

#Appel de la fonction
donneesfinales <- traitement_donnees_codes_espèces(donnees4)
