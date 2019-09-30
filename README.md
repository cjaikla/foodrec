# foodrec

Lots of people often ask themselves, ‘what should I eat for lunch or dinner?’  It is one of the common everyday questions, but people are struggling to come up with the new meal ideas. Since the information on the Internet is heavily overloaded, searching a new favorite dish from millions of recipes becomes a difficult task. The food recommendation system is one of the solutions to this problem. We developed the first step of the customized food recommendation system based on personal preferences by using unsupervised learning algorithm. <br/>
<br/>
The recipes are scraped from https://www.allrecipes.com <br/>
<br/>
The codes are developed in matlab (.m files) and can be perceived as 3 sections <br/>
(1) importing and cleaning data <br/>
countFreqSecondWords.m >>> extract a list of units <br/>
rankAllPhase.m >>> extract a list of ingredients <br/>
rankCookingDirection.m >>> extract a list of cooking methods <br/>
<br/>
(2) building a data matrix<br/>
extractUnits.m >>> determing the unit of each ingredients<br/>
extractIngredients.m >>> extract ingredients to be features in the data matrix<br/>
extractDirection.m >>> extract cooking methods to be features in the data matrix<br/>
<br/>
(3) unsupervised learning<br/>
wraper.m >>> run KNN, PCA, and TF-IDF on the data matrix.<br/>
<br/>
This work is a collaboration with Krongrath Suwannasri (@Krongrath)
