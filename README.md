# foodrec

Lots of people often ask themselves, ‘what should I eat for lunch or dinner?’  It is one of the common everyday questions, but people are struggling to come up with the new meal ideas. Since the information on the Internet is heavily overloaded, searching a new favorite dish from millions of recipes becomes a difficult task. The food recommendation system is one of the solutions to this problem. We developed the first step of the customized food recommendation system based on personal preferences by using unsupervised learning algorithm. 

The codes are developed in matlab (.m files) and can be perceived as 3 sections
(1) importing and cleaning data
countFreqSecondWords.m >>> extract a list of units
rankAllPhase.m >>> extract a list of ingredients 
rankCookingDirection.m >>> extract a list of cooking methods

(2) building a data matrix
extractUnits.m >>> determing the unit of each ingredients
extractIngredients.m >>> extract ingredients to be features in the data matrix
extractDirection.m >>> extract cooking methods to be features in the data matrix

(3) unsupervised learning
wraper.m >>> run KNN, PCA, and TF-IDF on the data matrix.
