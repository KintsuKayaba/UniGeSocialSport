/*************************************************************************************************************************************************************************/
--1a. Schema
/*************************************************************************************************************************************************************************/ 

-- Tabella UTENTE
CREATE TABLE UTENTE (
    username VARCHAR(50) PRIMARY KEY,
    psw VARCHAR(50) NOT NULL,
    nome VARCHAR(50),
    cognome VARCHAR(50),
    anno_nascita INT CHECK (anno_nascita >= 1900 AND anno_nascita <= DATE_PART('year', CURRENT_DATE)),
    luogo_nascita VARCHAR(50),
    foto VARCHAR(50), --percorso immagine
    tel VARCHAR(15) UNIQUE,
    matricola VARCHAR(20) UNIQUE,
    corso VARCHAR(100),
    u_premium VARCHAR(10) CHECK (u_premium IN ('premium', 'semplice')) NOT NULL
);

-- Tabella CATEGORIA
CREATE TABLE CATEGORIA (
    id VARCHAR(15) PRIMARY KEY,
    regolamento TEXT NOT NULL,
    n_giocatori INT CHECK (n_giocatori > 0) NOT NULL,
    foto VARCHAR(255)
);

-- Tabella IMPIANTO
CREATE TABLE IMPIANTO (
    nome VARCHAR(50) PRIMARY KEY,
    via VARCHAR(100),
    tel VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    latitudine DECIMAL(9,6) NOT NULL,
    longitudine DECIMAL(9,6) NOT NULL
);

-- Tabella EVENTO_SPO
CREATE TABLE EVENTO_SPO (
    id VARCHAR(15) PRIMARY KEY,
    data DATE,
    aperto VARCHAR(10) CHECK (aperto IN ('APERTO', 'CHIUSO')) NOT NULL,
    categoria_id VARCHAR(15) REFERENCES CATEGORIA(id),
    impianto_nome VARCHAR(50) REFERENCES IMPIANTO(nome),
    organizzatore_username VARCHAR(50) REFERENCES UTENTE(username),
    esito TEXT
);

-- Tabella TORNEO
CREATE TABLE TORNEO (
    id VARCHAR(15) PRIMARY KEY,
    descrizione TEXT,
    sponsor TEXT,
    premi TEXT,
    restrizioni TEXT,
    modalita VARCHAR(50),
    organizzatore_username VARCHAR(50) REFERENCES UTENTE(username),
    el_diretta BOOLEAN,
    mista BOOLEAN,
    gironi BOOLEAN,
    a_squadre VARCHAR(10) CHECK (a_squadre IN ('a_squadre', 'singolo')) NOT NULL
);

-- Tabella SQUADRA
CREATE TABLE SQUADRA (
    id_squadra VARCHAR(15) PRIMARY KEY,
    nome VARCHAR(50),
    colore_maglia VARCHAR(50),
    numero_partecipanti_minimo INT CHECK (numero_partecipanti_minimo > 0) NOT NULL,
    numero_partecipanti_massimo INT CHECK (numero_partecipanti_massimo >= numero_partecipanti_minimo) NOT NULL,
    descrizione TEXT,
    note TEXT,
    scadenza DATE CHECK (scadenza > CURRENT_DATE),
    organizzatore_username VARCHAR(50) REFERENCES UTENTE(username)
);

-- Tabella VALUTAZIONE
CREATE TABLE VALUTAZIONE (
    id_valutazione VARCHAR(15) PRIMARY KEY,
    data DATE,
    punteggio INT CHECK (punteggio >= 0 AND punteggio <= 10) NOT NULL,
    commento TEXT
);

-- Tabella ESITO
CREATE TABLE ESITO (
    id_esito VARCHAR(15) PRIMARY KEY
);

-- Tabella ESITO_E
CREATE TABLE ESITO_E (
    id_esito_e VARCHAR(15) PRIMARY KEY,
    data DATE,
    punteggio INT CHECK (punteggio >= 0 AND punteggio <= 10) NOT NULL,
    commento TEXT
);

-- Tabella EFFETTUA
CREATE TABLE EFFETTUA (
    utente_username VARCHAR(50) REFERENCES UTENTE(username),
    valutazione_effettuata VARCHAR(15) REFERENCES VALUTAZIONE(id_valutazione),
    PRIMARY KEY (utente_username, valutazione_effettuata)
);

-- Tabella RICEVE
CREATE TABLE RICEVE (
    utente_username VARCHAR(50) REFERENCES UTENTE(username),
    valutazione_ricevuta VARCHAR(15) REFERENCES VALUTAZIONE(id_valutazione),
    PRIMARY KEY (utente_username, valutazione_ricevuta)
);

-- Tabella RELATIVA_A
CREATE TABLE RELATIVA_A (
    evento_sportivo_id  VARCHAR(15) REFERENCES EVENTO_SPO(id),
    valutazione_id VARCHAR(15) REFERENCES VALUTAZIONE(id_valutazione),
    PRIMARY KEY (evento_sportivo_id, valutazione_id)
);

-- Tabella RIFERITO_A
CREATE TABLE RIFERITO_A (
    evento_sportivo_id  VARCHAR(15) REFERENCES EVENTO_SPO(id),
    esito_e_id VARCHAR(15) REFERENCES ESITO_E(id_esito_e),
    PRIMARY KEY (evento_sportivo_id, esito_e_id)
);

-- Tabella REPORT_P_E
CREATE TABLE REPORT_P_E (
    utente_username VARCHAR(50) REFERENCES UTENTE(username),
    esito_e_id VARCHAR(15) REFERENCES ESITO_E(id_esito_e),
    pts INT,
    PRIMARY KEY (utente_username, esito_e_id)
);

-- Tabella DISISCRIVE
CREATE TABLE DISISCRIVE (
    utente_username_disiscritto VARCHAR(50) REFERENCES UTENTE(username),
    utente_username_sostituto VARCHAR(50) REFERENCES UTENTE(username),
    evento_sportivo_id  VARCHAR(15) REFERENCES EVENTO_SPO(id),
    PRIMARY KEY (utente_username_disiscritto, utente_username_sostituto, evento_sportivo_id)
);

-- Tabella SI_CANDIDA
CREATE TABLE SI_CANDIDA (
    utente_username VARCHAR(50) REFERENCES UTENTE(username),
	squadra VARCHAR(15) REFERENCES SQUADRA(id_squadra),
    ruolo VARCHAR(50) NOT NULL,
    accettato_cand VARCHAR(10) CHECK (accettato_cand IN ('ACCETTATO', 'RIFIUTATO')) NOT NULL,
    PRIMARY KEY (utente_username,squadra)
);

-- Tabella SI_ISCRIVE
CREATE TABLE SI_ISCRIVE (
    utente_username VARCHAR(50) REFERENCES UTENTE(username),
    evento_sportivo_id VARCHAR(15) REFERENCES EVENTO_SPO(id),
    data DATE,
    ruolo VARCHAR(10) NOT NULL,
    accettato_iscr VARCHAR(10) CHECK (accettato_iscr IN ('CONFERMATO', 'RIFIUTATO')) NOT NULL,
    PRIMARY KEY (utente_username, evento_sportivo_id)
);

-- Tabella SI_DILETTA
CREATE TABLE SI_DILETTA (
    utente_username VARCHAR(50) REFERENCES UTENTE(username),
    sport VARCHAR(15) REFERENCES CATEGORIA(id),
    livello INT CHECK (livello >= 0 AND livello <= 100) DEFAULT 60 NOT NULL,
    PRIMARY KEY (utente_username, sport)
);

-- Tabella PARTECIPA
CREATE TABLE PARTECIPA (
    squadra VARCHAR(15),
    torneo_id VARCHAR(15),
    PRIMARY KEY (squadra, torneo_id),
    FOREIGN KEY (squadra) REFERENCES SQUADRA(id_squadra),
    FOREIGN KEY (torneo_id) REFERENCES TORNEO(id)
);

-- Tabella REGISTRARE
CREATE TABLE REGISTRARE (
    squadra VARCHAR(50) REFERENCES SQUADRA(id_squadra),
    utente_username VARCHAR(50) REFERENCES UTENTE(username),
    PRIMARY KEY (squadra, utente_username)
);

-- Tabella REPORT_S
CREATE TABLE REPORT_S (
    squadra VARCHAR(50) REFERENCES SQUADRA(id_squadra),
    id_esito VARCHAR(15) REFERENCES ESITO(id_esito),
    goal INT,
    pts INT,
    PRIMARY KEY (squadra, id_esito)
);

-- Tabella REPORT_P
CREATE TABLE REPORT_P (
    utente_username VARCHAR(50) REFERENCES UTENTE(username),
    id_esito VARCHAR(15) REFERENCES ESITO(id_esito),
    goal INT,
    pts INT,
    PRIMARY KEY (utente_username, id_esito)
);

/*************************************************************************************************************************************************************************/ 
--1b. Popolamento 
/*************************************************************************************************************************************************************************/ 


-- Tabella UTENTE
INSERT INTO UTENTE (username, psw, nome, cognome, anno_nascita, luogo_nascita, foto, tel, matricola, corso, u_premium)
VALUES 
('user1', 'password1', 'Mario', 'Rossi', 1990, 'Roma', 'path/to/image1.jpg', '1234567890', 'MAT123', 'Informatica', 'premium');
('user2', 'password2', 'Luigi', 'Verdi', 1985, 'Milano', 'path/to/image2.jpg', '0987654321', 'MAT456', 'Ingegneria', 'semplice');

-- Tabella CATEGORIA
INSERT INTO CATEGORIA (id, regolamento, n_giocatori, foto)
VALUES 
('C001', 'Regolamento per calcio', 11, 'path/to/calcio.jpg');
('C002', 'Regolamento per basket', 5, 'path/to/basket.jpg');
('C003', 'Regolamento per tennis', 2, 'path/to/tennis.jpg');

-- Tabella IMPIANTO
INSERT INTO IMPIANTO (nome, via, tel, email, latitudine, longitudine)
VALUES 
('Stadio Olimpico', 'Via dei Gladiatori 3', '0661234567', 'info@stadio.it', 41.933, 12.454);
('Palazzetto dello Sport', 'Via dello Sport 15', '0667654321', 'info@palazzetto.it', 41.906, 12.480);

-- Tabella EVENTO_SPO
INSERT INTO EVENTO_SPO (id, data, aperto, categoria_id, impianto_nome, organizzatore_username, esito)
VALUES 
('E001', '2024-09-10', 'APERTO', 'C001', 'Stadio Olimpico', 'user1', 'Vittoria per 2-1');
('E002', '2024-09-20', 'CHIUSO', 'C002', 'Palazzetto dello Sport', 'user1', 'Pareggio 1-1');
('E003', '2024-09-30', 'APERTO', 'C003', 'Stadio Olimpico', 'user1', 'Vittoria 3-0');
('E004', '2024-10-05', 'APERTO', 'C001', 'Stadio Olimpico', 'user1', 'Vittoria 4-2');
('E005', '2024-10-10', 'APERTO', 'C002', 'Palazzetto dello Sport', 'user1', 'Sconfitta 1-2');

-- Tabella TORNEO
INSERT INTO TORNEO (id, descrizione, sponsor, premi, restrizioni, modalita, organizzatore_username, el_diretta, mista, gironi, a_squadre)
VALUES 
('T001', 'Torneo di calcio', 'Sponsor1', 'Coppadoro', 'Nessuna', 'Eliminazione diretta', 'user1', true, false, true, 'a_squadre');
('T002', 'Torneo di basket', 'Sponsor2', 'Trofeo', 'Over 18', 'Gironi', 'user1', false, true, false, 'singolo');

-- Tabella SQUADRA
INSERT INTO SQUADRA (id_squadra, nome, colore_maglia, numero_partecipanti_minimo, numero_partecipanti_massimo, descrizione, note, scadenza, organizzatore_username)
VALUES 
('S001', 'Squadra A', 'Rosso', 5, 11, 'Squadra di calcio', 'Nessuna nota', '2024-12-31', 'user1');
('S002', 'Squadra B', 'Blu', 3, 5, 'Squadra di basket', 'Note aggiuntive', '2024-12-15', 'user1');

-- Tabella VALUTAZIONE
INSERT INTO VALUTAZIONE (id_valutazione, data, punteggio, commento)
VALUES 
('V001', '2024-09-12', 8, 'Buona prestazione');
('V002', '2024-09-22', 6, 'Migliorabile');
('V003', '2024-10-05', 7, 'Buon impegno');
('V004', '2024-10-10', 9, 'Eccellente difesa');

-- Tabella ESITO
INSERT INTO ESITO (id_esito)
VALUES 
('ES001');
('ES002');
('ES003');
('ES004');

-- Tabella ESITO_E
INSERT INTO ESITO_E (id_esito_e, data, punteggio, commento)
VALUES 
('EE001', '2024-09-10', 9, 'Prestazione eccellente');
('EE002', '2024-09-20', 7, 'Buona performance');
('EE003', '2024-10-05', 8, 'Partita combattuta ma ottima performance'),
('EE004', '2024-10-10', 9, 'Eccellente gestione difensiva');

-- Tabella EFFETTUA
INSERT INTO EFFETTUA (utente_username, valutazione_effettuata)
VALUES 
('user1', 'V001');
('user2', 'V002');

-- Tabella RICEVE
INSERT INTO RICEVE (utente_username, valutazione_ricevuta)
VALUES 
('user1', 'V002');
('user2', 'V001');

-- Tabella RELATIVA_A
INSERT INTO RELATIVA_A (evento_sportivo_id, valutazione_id)
VALUES 
('E001', 'V001');
('E002', 'V002');
('E004', 'V003');
('E005', 'V004');

-- Tabella RIFERITO_A
INSERT INTO RIFERITO_A (evento_sportivo_id, esito_e_id)
VALUES 
('E001', 'EE001');
('E002', 'EE002');
('E004', 'EE003'),
('E005', 'EE004');

-- Tabella REPORT_P_E
INSERT INTO REPORT_P_E (utente_username, esito_e_id, pts)
VALUES 
('user1', 'EE001', 3);
('user2', 'EE002', 1);
('user1', 'EE003', 5),
('user2', 'EE004', 6);

-- Tabella DISISCRIVE
INSERT INTO DISISCRIVE (utente_username_disiscritto, utente_username_sostituto, evento_sportivo_id)
VALUES 
('user1', 'user2', 'E001');

-- Tabella SI_CANDIDA
INSERT INTO SI_CANDIDA (utente_username, squadra, ruolo, accettato_cand)
VALUES 
('user1', 'S001', 'Attaccante', 'ACCETTATO');
('user2', 'S002', 'Difensore', 'RIFIUTATO');
('user1', 'S001', 'Portiere', 'ACCETTATO'),
('user2', 'S002', 'Difensore', 'ACCETTATO');

-- Tabella SI_ISCRIVE
INSERT INTO SI_ISCRIVE (utente_username, evento_sportivo_id, data, ruolo, accettato_iscr)
VALUES 
('user1', 'E001', '2024-09-08', 'Portiere', 'CONFERMATO');
('user2', 'E002', '2024-09-18', 'Giocatore', 'RIFIUTATO');
('user1', 'E002', '2024-09-18', 'Giocatore', 'CONFERMATO');
('user1', 'E003', '2024-09-28', 'Giocatore', 'CONFERMATO');
('user2', 'E004', '2024-09-30', 'Portiere', 'CONFERMATO');
('user2', 'E005', '2024-10-01', 'Giocatore', 'CONFERMATO');
('user2', 'E003', '2024-10-02', 'Giocatore', 'CONFERMATO');
('user1', 'E004', '2024-10-01', 'Attaccante', 'CONFERMATO');
('user2', 'E005', '2024-10-02', 'Difensore', 'CONFERMATO');

-- Tabella SI_DILETTA
INSERT INTO SI_DILETTA (utente_username, sport, livello)
VALUES 
('user1', 'C001', 80);
('user2', 'C002', 65);

-- Tabella PARTECIPA
INSERT INTO PARTECIPA (squadra, torneo_id)
VALUES 
('S001', 'T001');
('S002', 'T002');

-- Tabella REGISTRARE
INSERT INTO REGISTRARE (squadra, utente_username)
VALUES 
('S001', 'user1');
('S002', 'user2');

-- Tabella REPORT_S
INSERT INTO REPORT_S (squadra, id_esito, goal, pts)
VALUES 
('S001', 'ES001', 3, 6);
('S002', 'ES002', 1, 4);
('S001', 'ES003', 3, 7);
('S002', 'ES004', 2, 6);

-- Tabella REPORT_P
INSERT INTO REPORT_P (utente_username, id_esito, goal, pts)
VALUES 
('user1', 'ES001', 2, 5);
('user2', 'ES002', 1, 3);
('user1', 'ES003', 1, 4);
('user2', 'ES004', 2, 6);

/*************************************************************************************************************************************************************************/ 
--2. Vista
/* Vista Programma che per ogni impianto e mese riassume tornei e eventi che si svolgono in tale impianto, evidenziando in particolare per ogni categoria il numero di tornei, il numero di eventi, il numero di partecipanti coinvolti e di quanti diversi corsi di studio, la durata totale (in termini di minuti) di utilizzo e la percentuale di utilizzo rispetto alla disponibilit� complessiva (minuti totali nel mese in cui l�impianto � utilizzabile) */
/*************************************************************************************************************************************************************************/ 

CREATE VIEW Programma AS
SELECT 
    i.nome AS impianto_nome,                           -- Nome dell'impianto
    DATE_TRUNC('month', e.data) AS mese,               -- Mese dell'evento
    c.id AS categoria_id,                              -- Categoria dell'evento
    COUNT(DISTINCT e.id) AS numero_eventi,             -- Numero di eventi
    COUNT(DISTINCT t.id) AS numero_tornei,             -- Numero di tornei
    COUNT(DISTINCT si.utente_username) AS partecipanti_coinvolti,  -- Numero totale di partecipanti
    COUNT(DISTINCT u.corso) AS corsi_coinvolti,        -- Numero di corsi di studio diversi coinvolti
    COALESCE(SUM(CASE WHEN c.id = 'C001' THEN 90      -- 90 min per calcio
                      WHEN c.id = 'C002' THEN 48      -- 48 min per basket
                      ELSE 60 END), 0) AS durata_totale_minuti,  -- Altri sport 60 min
    ROUND((COALESCE(SUM(CASE WHEN c.id = 'C001' THEN 90
                             WHEN c.id = 'C002' THEN 48
                             ELSE 60 END), 0)::NUMERIC / 
           (DATE_PART('days', DATE_TRUNC('month', e.data) + '1 month'::interval - '1 day'::interval) * 24 * 60)::NUMERIC) * 100, 2) AS percentuale_utilizzo -- Percentuale di utilizzo
FROM 
    IMPIANTO i
LEFT JOIN EVENTO_SPO e ON i.nome = e.impianto_nome     
LEFT JOIN CATEGORIA c ON e.categoria_id = c.id        
LEFT JOIN TORNEO t ON t.organizzatore_username = e.organizzatore_username 
LEFT JOIN SI_ISCRIVE si ON e.id = si.evento_sportivo_id
LEFT JOIN UTENTE u ON si.utente_username = u.username 
GROUP BY 
    i.nome, 
    DATE_TRUNC('month', e.data), 
    c.id
ORDER BY 
    i.nome, mese;

/*************************************************************************************************************************************************************************/ 
--3. Interrogazioni
/*************************************************************************************************************************************************************************/ 

/*************************************************************************************************************************************************************************/ 
/* 3a: Determinare gli utenti che si sono candidati come giocatori e non sono mai stati accettati e quelli che sono stati accettati tutte le volte che si sono candidati */
/*************************************************************************************************************************************************************************/ 


-- Mai accettati
SELECT utente_username
FROM SI_CANDIDA
WHERE accettato_cand = 'RIFIUTATO'
GROUP BY utente_username
HAVING COUNT(*) = (SELECT COUNT(*)
                   FROM SI_CANDIDA sc2
                   WHERE sc2.utente_username = SI_CANDIDA.utente_username);

-- Sempre accettati 
SELECT utente_username
FROM SI_CANDIDA
WHERE accettato_cand = 'ACCETTATO'
GROUP BY utente_username
HAVING COUNT(*) = (SELECT COUNT(*)
                   FROM SI_CANDIDA sc2
                   WHERE sc2.utente_username = SI_CANDIDA.utente_username);

/*************************************************************************************************************************************************************************/ 
/* 3b: determinare gli utenti che hanno partecipato ad almeno un evento di ogni categoria */
/*************************************************************************************************************************************************************************/ 


SELECT utente_username
FROM SI_ISCRIVE si
JOIN EVENTO_SPO e ON si.evento_sportivo_id = e.id
JOIN CATEGORIA c ON e.categoria_id = c.id
GROUP BY utente_username
HAVING COUNT(DISTINCT c.id) = (SELECT COUNT(*) FROM CATEGORIA);

/*************************************************************************************************************************************************************************/ 
/* 3c: determinare per ogni categoria il corso di laurea pi� attivo in tale categoria, cio� quello i cui studenti hanno partecipato al maggior numero di eventi (singoli o all�interno di tornei) di tale categoria */
/*************************************************************************************************************************************************************************/ 

SELECT c.id AS categoria_id, u.corso, COUNT(*) AS num_partecipazioni
FROM SI_ISCRIVE si
JOIN UTENTE u ON si.utente_username = u.username
JOIN EVENTO_SPO e ON si.evento_sportivo_id = e.id
JOIN CATEGORIA c ON e.categoria_id = c.id
GROUP BY c.id, u.corso
ORDER BY c.id, num_partecipazioni DESC;

/*************************************************************************************************************************************************************************/ 
--4. Funzioni
/*************************************************************************************************************************************************************************/ 

/*************************************************************************************************************************************************************************/ 
/* 4a: funzione che effettua la conferma di un giocatore quale componente di una squadra, realizzando gli opportuni controlli */
/*************************************************************************************************************************************************************************/ 

CREATE OR REPLACE FUNCTION conferma_giocatore_squadra(
    p_utente_username VARCHAR,
    p_squadra_id VARCHAR
) RETURNS BOOLEAN AS $$
DECLARE
    numero_giocatori INT;
    numero_massimo INT;
BEGIN
    -- Verifico quanti giocatori sono già confermati nella squadra
    SELECT COUNT(*)
    INTO numero_giocatori
    FROM REGISTRARE
    WHERE squadra = p_squadra_id;

    -- Prendo il numero massimo di partecipanti della squadra
    SELECT numero_partecipanti_massimo
    INTO numero_massimo
    FROM SQUADRA
    WHERE id_squadra = p_squadra_id;

    -- Controllo se la squadra ha già raggiunto il limite massimo di giocatori
    IF numero_giocatori >= numero_massimo THEN
        RAISE EXCEPTION 'La squadra ha già raggiunto il numero massimo di partecipanti.';
    END IF;

    -- Se il controllo è superato, registro il giocatore nella squadra
    INSERT INTO REGISTRARE (squadra, utente_username)
    VALUES (p_squadra_id, p_utente_username);

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

/*************************************************************************************************************************************************************************/ 
/* 4b1: funzione che dato un giocatore ne calcoli il livello */

/* 4b2: funzione corrispondente alla seguente query parametrica: data una categoria e un corso di studi, determinare la frazione di partecipanti a eventi di quella categoria di genere femminile sul totale dei partecipanti provenienti da quel corso di studi */
/*************************************************************************************************************************************************************************/ 

-- 4b1
CREATE OR REPLACE FUNCTION calcola_livello(utente_username VARCHAR)
RETURNS INT AS $$
DECLARE
    total_pts INT;
    num_valutazioni INT;
    livello_calcolato INT;
BEGIN
    -- Somma dei punti accumulati dal giocatore
    SELECT SUM(pts) INTO total_pts
    FROM REPORT_P
    WHERE utente_username = utente_username;

    -- Numero di valutazioni ricevute
    SELECT COUNT(*) INTO num_valutazioni
    FROM REPORT_P
    WHERE utente_username = utente_username;

    -- Se non ci sono valutazioni, il livello è 0
    IF num_valutazioni = 0 THEN
        RETURN 0;
    END IF;

    -- Calcolo la media dei punti e moltiplico per 10 (essendo che il livello è 0-100 e i punteggi sono 0-10, facciamo la media(*10) di tutti i punteggi presi da un utente, cosi il livello rispecchia il suo andamento)
    livello_calcolato := (total_pts / num_valutazioni) * 10;


    RETURN livello_calcolato;
END;
$$ LANGUAGE plpgsql;



-- 4b2
CREATE OR REPLACE FUNCTION frazione_partecipanti_femminili(
    p_categoria_id VARCHAR,
    p_corso_studi VARCHAR
) RETURNS DECIMAL AS $$
DECLARE
    totale_partecipanti INT;
    partecipanti_femminili INT;
BEGIN
    -- Calcolo del totale dei partecipanti per la categoria e il corso di studi
    SELECT COUNT()
    INTO totale_partecipanti
    FROM SI_ISCRIVE si
    JOIN EVENTO_SPO e ON si.evento_sportivo_id = e.id
    JOIN UTENTE u ON si.utente_username = u.username
    WHERE e.categoria_id = p_categoria_id
    AND u.corso = p_corso_studi;

    -- Calcolo dei partecipanti di genere femminile
    SELECT COUNT()
    INTO partecipanti_femminili
    FROM SI_ISCRIVE si
    JOIN EVENTO_SPO e ON si.evento_sportivo_id = e.id
    JOIN UTENTE u ON si.utente_username = u.username
    WHERE e.categoria_id = p_categoria_id
    AND u.corso = p_corso_studi
    AND u.genere = 'F';

    -- Se non ci sono partecipanti totali, evito divisione per zero
    IF totale_partecipanti = 0 THEN
        RETURN 0;
    END IF;

    -- Restituisce la frazione di partecipanti femminili
    RETURN partecipanti_femminili::DECIMAL / totale_partecipanti::DECIMAL;
END;
$$ LANGUAGE plpgsql;

/*************************************************************************************************************************************************************************/ 
--5. Trigger
/*************************************************************************************************************************************************************************/ 

/*************************************************************************************************************************************************************************/ 
/* 5a: trigger per la verifica del vincolo che non � possibile iscriversi a eventi chiusi e che lo stato di un evento sportivo diventa CHIUSO quando si raggiunge un numero di giocatori pari a quello previsto dalla categoria */
/*************************************************************************************************************************************************************************/ 

CREATE OR REPLACE FUNCTION verifica_iscrizione_e_stato() RETURNS TRIGGER AS $$
DECLARE
    num_giocatori_iscritti INT;
    num_giocatori_previsti INT;
BEGIN
    -- Verifico se l'evento è chiuso
    IF (SELECT aperto FROM EVENTO_SPO WHERE id = NEW.evento_sportivo_id) = 'CHIUSO' THEN
        RAISE EXCEPTION 'Non è possibile iscriversi a un evento chiuso.';
    END IF;

    -- Conto i giocatori iscritti
    SELECT COUNT(*) INTO num_giocatori_iscritti
    FROM SI_ISCRIVE
    WHERE evento_sportivo_id = NEW.evento_sportivo_id;

    -- Numero di giocatori previsto per l'evento
    SELECT c.n_giocatori INTO num_giocatori_previsti
    FROM EVENTO_SPO e
    JOIN CATEGORIA c ON e.categoria_id = c.id
    WHERE e.id = NEW.evento_sportivo_id;

    -- Se il numero di iscritti raggiunge o supera il limite, chiudo l'evento
    IF num_giocatori_iscritti + 1 >= num_giocatori_previsti THEN
        UPDATE EVENTO_SPO
        SET aperto = 'CHIUSO'
        WHERE id = NEW.evento_sportivo_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Creazione del trigger che si attiva prima di ogni inserimento di iscrizione
CREATE TRIGGER trigger_verifica_iscrizione
BEFORE INSERT ON SI_ISCRIVE
FOR EACH ROW
EXECUTE FUNCTION verifica_iscrizione_e_stato();

/*************************************************************************************************************************************************************************/ 
/* 5b1: trigger che gestisce la sede di un evento: se la sede � disponibile nel periodo di svolgimento dell�evento la sede viene confermata altrimenti viene individuata una sede alternativa: tra gli impianti disponibili nel periodo di svolgimento dell�evento si seleziona quello meno utilizzato nel mese in corso (vedi vista Programma) */

/* 5b2: trigger per il mantenimento dell�attributo derivato livello */
/*************************************************************************************************************************************************************************/ 

-- 5b1
CREATE OR REPLACE FUNCTION verifica_e_sostituisci_sede()
RETURNS TRIGGER AS $$
DECLARE
    sede_disponibile BOOLEAN;
    sede_alternativa VARCHAR(50);
    mese_evento DATE;
BEGIN
    -- Mese dell'evento
    mese_evento := DATE_TRUNC('month', NEW.data);

    -- Verifico la disponibilità
    SELECT COUNT(*)
    INTO sede_disponibile
    FROM EVENTO_SPO
    WHERE impianto_nome = NEW.impianto_nome
    AND data = NEW.data;

    -- Sede disponibile (nessun altro evento nello stesso giorno)
    IF sede_disponibile = 0 THEN
        RETURN NEW;
    END IF;

    -- Cerco un impianto alternativo (quello meno usato)
    SELECT nome
    INTO sede_alternativa
    FROM Programma
    WHERE mese = mese_evento
    ORDER BY percentuale_utilizzo ASC
    LIMIT 1;

    -- Sede trovata -> evento
    IF sede_alternativa IS NOT NULL THEN
        NEW.impianto_nome = sede_alternativa;
    ELSE
        RAISE EXCEPTION 'Nessun impianto disponibile per la data %', NEW.data;
    END IF;

    -- Restituisce la nuova riga con la sede aggiornata
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verifica_sede_evento
BEFORE INSERT ON EVENTO_SPO
FOR EACH ROW
EXECUTE FUNCTION verifica_e_sostituisci_sede();


-- 5b2
-- Creazione del trigger che si attiva dopo ogni aggiornamento dei report per il mantenimento di livello
CREATE TRIGGER aggiorna_livello_trigger
AFTER INSERT OR UPDATE ON REPORT_P
FOR EACH ROW
EXECUTE FUNCTION aggiorna_livello(NEW.utente_username);
