UnigeSocialSport


Schema EER: [clicca qui](https://raw.githack.com/KintsuKayaba/Modello-EER-BD/main/Link-for-project.drawio.html)


Gerarchie di generalizzazione

In questo modello EER possiamo trovare due gerarchie, entrambe totali ed esclusive.
La prima consiste in Utente, che viene suddiviso in Utente Premium ed Utente Semplice, nonché i soli due possibili utilizzatori del nostro programma.
La seconda consiste invece in Torneo, il quale è stato scisso in Torneo ad Eliminazione Diretta, Torneo a Gironi e Torneo Misto.

Non ovvietà

Per il rifiuto/accettazione di una candidatura/iscrizione di un utente ad una rispettiva squadra/evento è stata creata una relazione che permette al solo utente premium di prendere la decisione, rendendo così più chiaro il concetto e semplice la gestione in SQL.
Gli attributi: sport, livello e affidabilità sono stati allegati all’entità Utente per semplicità, evitando di appesantire il diagramma con ulteriori entità o relazioni. Nel caso di un nuovo utente saranno nulle.
