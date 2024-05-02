**UnigeSocialSport**

Schema EER: [clicca qui](https://raw.githack.com/KintsuKayaba/Modello-EER-BD/main/Link-for-project.drawio.html)

**Gerarchie di generalizzazione**

In questo modello EER possiamo trovare due gerarchie, entrambe totali ed esclusive.
La prima consiste in Utente, che viene suddiviso in Utente Premium ed Utente Semplice, nonché i soli due possibili utilizzatori del nostro programma.
La seconda consiste invece in Torneo, il quale è stato scisso in Torneo ad Eliminazione Diretta, Torneo a Gironi e Torneo Misto.

**Squadre**

Gli attributi nome e colore_maglia dell’entità Squadra rappresentano la chiave primaria della relativa entità in quanto il programma vieterà la creazione di squadre uguali. Il nome è spesso il principale identificatore di una squadra e il colore della maglia è un altro elemento distintivo che aiuta a differenziare una squadra dalle altre.

**Ruolo**

Nelle relazioni 'SI_ISCRIVE' e 'SI_CANDIDA', l'attributo 'ruolo' assume una duplice funzione: da un lato, identifica il ruolo che un utente intende ricoprire all'interno delle dinamiche sportive, mentre dall'altro, individua anche il ruolo di arbitro.

**Torneo**

L’entità torneo è collegata tramite 2 relazioni, entrambe con cardinalità (0,n).
-	“Partecipa”
Quando si crea un torneo, all'inizio potremmo non sapere quante squadre parteciperanno. Quindi abbiamo deciso di consentire un numero variabile di squadre partecipanti, che potrebbe essere da zero a quante se ne presentano (0,n).
-	“Forma”
Poiché il numero di squadre che partecipano al torneo può variare da zero a un numero indefinito, diventa complicato stabilire con certezza quanti eventi sportivi si svolgeranno. Questa flessibilità può influenzare direttamente la pianificazione e l'organizzazione degli eventi nel corso del torneo.

**Dominio Attributi**

Stato = booleano | accettato / non accettato

Completa = booleano | completa / non completa

A_squadre = booleano | a squadre / singolo

Scadenza = date | limite in cui un utente può disiscriversi dalla squadra, dopo il limite deve indicare un sostituto

Affidabile = booleano | affidabile / non affidabile

**Candidatura**

Solo chi ha un account premium e ha registrato la squadra può decidere se accettare o rifiutare una candidatura. Lo stesso vale per l’iscrizione agli eventi sportivi.

