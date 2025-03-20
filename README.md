# UniGeSocialSport

UniGeSocialSport è un'applicazione sviluppata per promuovere e gestire attività sportive sociali all'interno dell'Università di Genova. L'applicazione è progettata per facilitare l'organizzazione di eventi sportivi, la gestione degli utenti e la prenotazione delle strutture sportive.

## Schema EER

Schema EER: [clicca qui](https://app.diagrams.net/?viewer=1&url=https://raw.githubusercontent.com/KintsuKayaba/UniGeSocialSport/refs/heads/main/UniGeSocialSport.drawio)

### Gerarchie di generalizzazione

In questo modello EER possiamo trovare due gerarchie, entrambe totali ed esclusive:
- **Utente**: suddiviso in Utente Premium ed Utente Semplice.
- **Torneo**: suddiviso in Torneo ad Eliminazione Diretta, Torneo a Gironi e Torneo Misto.

## Funzionalità

### Utenti

- **Registrazione e Autenticazione**: Gli utenti possono registrarsi e autenticarsi utilizzando le loro credenziali.
- **Gestione Profilo**: Gli utenti possono aggiornare le informazioni del proprio profilo, inclusi i dettagli personali e le preferenze sportive.
- **Tipi di Utenti**: Esistono due tipi di utenti, Premium e Semplice, con diverse funzionalità disponibili.

### Eventi Sportivi

- **Creazione Eventi**: Gli utenti possono creare eventi sportivi specificando data, categoria, impianto e organizzatore.
- **Gestione Eventi**: Gli eventi possono essere aperti o chiusi e possono avere esiti specificati.
- **Partecipazione agli Eventi**: Gli utenti possono iscriversi agli eventi sportivi e specificare il ruolo che intendono ricoprire.
- **Valutazione Eventi**: Gli eventi possono essere valutati, e le valutazioni possono essere riferite a specifici eventi sportivi.

### Tornei

- **Creazione Tornei**: Gli utenti possono creare tornei specificando descrizioni, sponsor, premi, restrizioni e modalità.
- **Tipi di Tornei**: I tornei possono essere ad eliminazione diretta, misti o a gironi.
- **Partecipazione ai Tornei**: Le squadre possono partecipare ai tornei, e gli utenti possono registrarsi come membri delle squadre.

### Squadre

- **Creazione Squadre**: Gli utenti possono creare squadre specificando nome, colore maglia, numero di partecipanti e descrizione.
- **Gestione Squadre**: Gli utenti possono gestire le iscrizioni alle squadre e accettare o rifiutare candidature.

### Impianti Sportivi

- **Registrazione Impianti**: Gli utenti possono registrare impianti sportivi specificando nome, indirizzo, telefono, email, latitudine e longitudine.
- **Gestione Impianti**: Gli impianti possono essere assegnati agli eventi sportivi e possono essere verificati per disponibilità tramite trigger.

### Valutazioni e Esiti

- **Valutazioni**: Gli utenti possono effettuare valutazioni e ricevere valutazioni in base alla loro partecipazione agli eventi.
- **Esiti**: Gli esiti degli eventi e dei tornei possono essere registrati e utilizzati per generare report.

### Funzioni e Trigger

- **Funzioni**: Diverse funzioni PL/pgSQL sono utilizzate per calcolare valori specifici come il livello degli utenti e per gestire le iscrizioni alle squadre.
- **Trigger**: Trigger PL/pgSQL sono utilizzati per garantire la consistenza dei dati, come la verifica della disponibilità degli impianti e il mantenimento dello stato degli eventi.

## Installazione

1. Clona il repository:
    ```bash
    git clone https://github.com/KintsuKayaba/UniGeSocialSport.git
    ```
2. Naviga nella directory del progetto:
    ```bash
    cd UniGeSocialSport
    ```
