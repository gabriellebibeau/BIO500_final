# READ.ME
Bonjour et bienvenue dans notre dépôt Git permettant la création automatisée sur R d'un rapport sur la diversité du benthos au Québec et les variables l'affectant. 

## Description du projet
Nous avons créé un script dans R qui automatise la création d'un rapport. Dans notre cas ce rapport porte sur la diversité (alpha et beta) des communautés de benthos dans les rivières du Québec. Les données utilisées proviennent de Biodiversité Québec.
Nous avons mené ce projet à terme parce que la biodiversité au Québec est en manque critique d'analyse de données et que ces analyses, lorsque faites, sont souvent difficilement reproductibles. En créant un processus automatisé, 
n'importe qui peut obtenir exactement les mêmes résultats que nous à partir de ces scripts. Le script principal a été réalisé à l'aide de la librairie "targets" (qui permet d'automatiser des opérations). 
Ce script lit un après l'autre les fonctions rédigées dans d'autres scripts présents dans le dépôt Git. 

## Comment l'installer et rouler les scripts
Pour le bon fonctionnement du projet, il faut télécharger l'intégralité du dépôt Git. Vous devez ensuite sélectionner le dossier du projet comme working directory et écrire dans la console R "tar_make()".
Cela devrait alors exécuter toutes les fonctions permettant le nettoyage des données, la création d'une base de données, les analyses statistiques et la production d'un rapport en Markdown. 

Il est possible que vous rencontriez des difficultés dues à l'utilisation de plusieurs librairies. Nous recommandons donc de télécharger les librairies suivantes avant d'utiliser le projet :
1. rmarkdown
2. rticles
3. RSQLite
4. tarchetypes
5. dplyr
6. vegan
7. ggplot2
8. glue

## Auteurs
Gabrielle Bibeau

Laura Glaude

Emmanuelle Langlois

Cloé Tanguay
