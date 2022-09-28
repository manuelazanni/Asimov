-- Script per la creazione della tabella Utenti
DROP DATABASE IF EXISTS Asimov;
CREATE DATABASE Asimov;
USE Asimov;

-- Creazione della tabella relativa all'utente
CREATE TABLE Utente (
ID_Utente INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(30) NOT NULL,
Cognome VARCHAR(30) NOT NULL,
Username VARCHAR(30) NOT NULL,
Email VARCHAR(100) NOT NULL,
Passw VARCHAR(20) NOT NULL,
Telefono CHAR(10),
Citta VARCHAR(20),
Provincia CHAR(2),
Indirizzo VARCHAR(50),
Codice_Postale CHAR(5),
Amministratore INT DEFAULT 0,
Sospeso INT DEFAULT 0
);

-- Creazione della tabella relativa alla categoria dei vari prodotti
CREATE TABLE Categoria(
Nome_Categoria VARCHAR(50) PRIMARY KEY
);

-- Creazione della tabella relativa ai prodotti
CREATE TABLE Prodotto(
ID_Prodotto INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(30) NOT NULL,
Descrizione VARCHAR(255) NOT NULL,
Prezzo DOUBLE(10, 2) NOT NULL,
Quantita INT NOT NULL DEFAULT 0,
Path_Immagine VARCHAR(255) NOT NULL,
Brand VARCHAR(50) NOT NULL,
Sconto INT NOT NULL,
Nome_Categoria VARCHAR(50) NOT NULL,
FOREIGN KEY (Nome_Categoria) REFERENCES Categoria(Nome_Categoria)
);

-- Creazione della tabella relativa alle recensioni
CREATE TABLE Valutazione(
ID_Recensione INT AUTO_INCREMENT PRIMARY KEY,
ID_Utente INT NOT NULL,
ID_Prodotto INT NOT NULL,
Punteggio DOUBLE NOT NULL,
Recensione VARCHAR(255) NOT NULL,
Data_Recensione DATE,
FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente),
FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);

-- Creazione della tabella relativa alle recensioni
CREATE TABLE Preferiti(
ID_Utente INT NOT NULL,
ID_Prodotto INT NOT NULL,
PRIMARY KEY (ID_Utente, ID_Prodotto),
FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente),
FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);

-- Creazione della tabella relativa agli ordini effettuati dal cliente
CREATE TABLE Ordine (
	ID_Ordine INT AUTO_INCREMENT PRIMARY KEY,
    ID_Utente INT NOT NULL,
    Totale DOUBLE(10, 2) NOT NULL,
    FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente)
);

-- Creazione della tabella relativa al prodotto ordinato
CREATE TABLE Ordine_Prodotto (
	ID_Ordine INT NOT NULL,
	ID_Prodotto INT NOT NULL,
    Quantita INT NOT NULL,
    Prezzo DOUBLE(10, 2),
    FOREIGN KEY (ID_Ordine) REFERENCES Ordine(ID_Ordine)
);

-- Creazione della tabella relativa ai dettagli del pagamento
CREATE TABLE Pagamento (
	ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Ordine INT NOT NULL,
    Data_Pagamento DATE NOT NULL,
    Numero_Carta CHAR(16) NOT NULL,
    CVV CHAR(3) NOT NULL,
    Scadenza DATE NOT NULL,
    Titolare_Carta VARCHAR(60) NOT NULL,
    FOREIGN KEY (ID_Ordine) REFERENCES Ordine(ID_Ordine)
);

-- Creazione della tabella relativa al carrello
CREATE TABLE Carrello (
	ID_Utente INT NOT NULL,
	ID_Prodotto INT NOT NULL,
    Quantita INT NOT NULL,
    FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente),
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);

-- Creazione della tabella relativa alle news
CREATE TABLE News (
	ID_News INT AUTO_INCREMENT PRIMARY KEY,
    Titolo VARCHAR(100) NOT NULL,
	Testo VARCHAR(5000) NOT NULL
);

-- 			+-------------------+ 			--
-- 			|	 INSERIMENTO    | 			--
-- 			+-------------------+ 			--

-- Creazione dell'amministratore
INSERT INTO Utente (Nome, Cognome, Username, Email, Passw, Telefono, Citta, Provincia, Indirizzo, Codice_Postale, Amministratore, Sospeso) VALUES
('Giovanni', 'Manfredi', 'John_64', 'g.manfredi5@studenti.unisa.it', '12345678', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 1, 0),
('Admin', 'Admin', 'Amministratore', 'aa@aa.aa', 'aaaaaa', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 1, 0),
('Alberto', 'Naska', 'Paolo29', 'bb@bb.bb', 'bbbbbb', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 0, 1),
('Valentino', 'Rossi', 'Valentino46', 'cc@cc.cc', 'cccccc', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 0, 0),
('Aldo', 'Baglio', 'Ajeje_Brazorf', 'dd@dd.dd', 'dddddd', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 1, 0),
('Giovanni', 'Storti', 'Pdor', 'ee@ee.ee', 'eeeeee', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 0, 0),
('Giacomo', 'Poretti', 'Giacomino', 'dd@dd.dd', 'ffffff', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 0, 1);

-- Creazione delle categorie
INSERT INTO Categoria (Nome_Categoria) VALUES 
('Smartphone'),
('Tablet'),
('Laptop'),
('Tutte le opzioni');

-- SEZIONE APPLE
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Ipad", "Display 10.2 - Fotocamera 8 MPX - CPU A13 Bionic - RAM 3GB - ROM 64GB", 389, 50, "images/products/apple/ipadBase.jpg", "Apple", 15, "Tablet"),
("Ipad Air", "Display 10.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 64GB", 699, 23, "images/products/apple/ipadAir.jpg", "Apple", 0, "Tablet"),
("Ipad Mini", "Display 8.3 - Fotocamera 12 MPX - CPU A15 Bionic - RAM 4GB - ROM 64GB", 559, 30, "images/products/apple/ipadMini.jpg", "Apple", 5, "Tablet"),
("Ipad Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1219, 30, "images/products/apple/ipadPro.jpg", "Apple", 0, "Tablet"),
("Iphone 13", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1219, 30, "images/products/apple/iphone13.jpg", "Apple", 0, "Smartphone"),
("Iphone 13 Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 999, 30, "images/products/apple/iphone13Pro.jpg", "Apple", 10, "Smartphone"),
("Iphone 13 Mini", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 649, 30, "images/products/apple/iphone13Mini.jpg", "Apple", 10, "Smartphone"),
("Iphone 14", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1029, 50, "images/products/apple/iphone14.jpg", "Apple", 0, "Smartphone"),
("Iphone 14 Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1339, 40, "images/products/apple/iphone14Pro.jpg", "Apple", 0, "Smartphone");

-- SEZIONE SAMSUNG
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Galaxy Fold 4", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1879, 30, "images/products/samsung/fold4.jpg", "Samsung", 0, "Smartphone"),
("Galaxy S21", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 599, 10, "images/products/samsung/s21.jpg", "Samsung", 15, "Smartphone"),
("Galaxy S21 Plus", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 699, 10, "images/products/samsung/s21Plus.jpg", "Samsung", 0, "Smartphone"),
("Tab A7", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 149, 30, "images/products/samsung/tabA7.jpg", "Samsung", 20, "Tablet"),
("Tab S6 Lite", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 299, 20, "images/products/samsung/tabS6Lite.jpg", "Samsung", 30, "Tablet"),
("Tab S7", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 549, 13, "images/products/samsung/tabS7.jpg", "Samsung", 15, "Tablet"),
("Galaxy Book2 Pro 360", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1649, 7, "images/products/samsung/galaxyBook2Pro360.jpg", "Samsung", 10, "Laptop"),
("Galaxy Book2", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1199, 7, "images/products/samsung/galaxyBook2.jpg", "Samsung", 0, "Laptop");

-- SEZIONE XIAOMI
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Xiaomi 12", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 649, 20, "images/products/xiaomi/xiaomi12.jpg", "Xiaomi", 0, "Smartphone"),
("Xiaomi 12 Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 849, 14, "images/products/xiaomi/xiaomi12Pro.jpg", "Xiaomi", 0, "Smartphone"),
("Xiaomi Mi 11", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 799, 10, "images/products/xiaomi/xiaomiMi11.jpg", "Xiaomi", 40, "Smartphone"),
("Xiaomi Redmi Note 11 Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 379, 50, "images/products/xiaomi/xiaomiRedmiNote11Pro.jpg", "Xiaomi", 30, "Smartphone"),
("Xiaomi Book S", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 329, 30, "images/products/xiaomi/xiaomiBookS.jpg", "Xiaomi", 0, "Tablet"),
("Xiaomi Book S", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 699, 30, "images/products/xiaomi/xiaomiBookS.jpg", "Xiaomi", 15, "Laptop"),
("Xiaomi Mi Redmi Pro 14", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1099, 10, "images/products/xiaomi/xiaomiMiRedmiPro14.jpg", "Xiaomi", 10, "Laptop"),
("Xiaomi Mi Redmi Pro 15", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1299, 13, "images/products/xiaomi/xiaomiMiRedmiPro15.jpg", "Xiaomi", 0, "Laptop");

-- SEZIONE HUAWEI
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Huawei P40 Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 799, 17, "images/products/huawei/huaweiP40Pro.jpg", "Huawei", 0, "Smartphone"),
("Huawei P30 Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 599, 12, "images/products/huawei/huaweiP30Pro.jpg", "Huawei", 15, "Smartphone"),
("Huawei Mate 30 Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 699, 10, "images/products/huawei/huaweiMate30Pro.jpg", "Huawei", 0, "Smartphone"),
("Huawei Mate Pad Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 649, 24, "images/products/huawei/huaweiMatePadPro.jpg", "Huawei", 20, "Tablet");

-- SEZIONE NOTHING
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Nothing Phone 1", "Display 6.55 - Fotocamera 50 MPX - CPU Snapdragon 778G - RAM 8GB - ROM 256GB", 529, 0, "images/products/nothing/nothingPhone1.jpg", "Nothing", 0, "Smartphone");

-- SEZIONE VALUTAZIONE
INSERT INTO Valutazione (ID_Utente, ID_Prodotto, Punteggio, Recensione, Data_Recensione) VALUE
(1, 1, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-07-05'),
(2, 1, 3, "Non male." , '2022-06-05'),
(5, 2, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-08-15'),
(7, 3, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-06-23'),
(1, 4, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-07-12'),
(6, 5, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-05-02'),
(1, 6, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-07-25'),
(1, 7, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-06-12'),
(3, 8, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-09-03'),
(2, 9, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-08-04'),
(1, 10, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-04-01'),
(6, 11, 1, "Il prodotto in questione è pessimo. Reso effettuato." , '2022-04-05'),
(1, 12, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-5-19'),
(5, 13, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-05-21'),
(3, 14, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-07-21'),
(1, 15, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-08-27'),
(2, 16, 5, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-09-02'),
(4, 17, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-05-25'),
(2, 18, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-04-13'),
(3, 19, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-05-17'),
(1, 20, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-05-25'),
(7, 21, 1, "Il prodotto in questione è pessimo. Reso effettuato." , '2022-07-07'),
(4, 22, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-04-17'),
(1, 23, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-06-06'),
(3, 24, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-08-09'),
(1, 25, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-09-11'),
(7, 26, 1, "Il prodotto in questione è pessimo. Reso effettuato." , '2022-03-19'),
(2, 27, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-07-26'),
(1, 28, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-07-26');

-- SEZIONE NEWS
INSERT INTO News (Titolo, Testo) VALUE
("Nothing Phone, tra trasparenze e Led lo smartphone modulare fa un altro passo avanti", "È appena scattata la vendita su Amazon (con qualche sconto), il sito ufficiale nothing.tech e quello di WindTre e per averlo bisogna spendere non meno di 499 euro. Stiamo quindi parlando di uno smartphone di fascia media (alta) ma rispetto a tutto gli altri il Nothing Phone (1), prima attesissima creatura partorita dalla startup di Carl Pei, il fondatore di OnePlus, è oggettivamente un device diverso. Nella sua tecnica costruttiva e nell'estetica, per la sua scocca posteriore completamente trasparente e la presenza di 900 Led funzionali che possono illuminarsi in modo del tutto personalizzabile attraverso l'interfaccia Glyph. E per una user experience che, come dice Pei, “speriamo segni l'inizio di un cambiamento in un settore oggi stagnante”. Al suo interno, per esempio, c'è una bobina per la ricarica wireless con i bordi tagliati per assecondare le linee estetiche del telefono e la componente di design detta legge anche in chiave materiali, vedi i componenti metallici e in plastica (metà di questi derivati da bio materiali) che fanno il paio con il telaio in alluminio riciclato al 100%. Nothing Phone (1) è uno smartphone modulare sui generis (solo parte della struttura è componibile) e segna una nuova frontiera nel modo di concepire i telefonini. Senza, ovviamente, rinunciare alle prestazioni. Nella dotazione hardware troviamo infatti un display Oled da 6,55 pollici Hdr 10+ con risoluzione da 2400 x1080 pixel, una doppia fotocamera con sensori (Sony e Samsung) da 50 Megapixel, una batteria da 4500 mAh e un processore Qualcomm Snapdragon 778G+. Il tutto condito da un'ampia batteria di sensori (compreso quello per il riconoscimento delle impronte digitali integrato nello schermo) e dal sistema operativo Nothing OS basato su Android 12, che promette grande fluidità e assenza di bloatware, e quindi libero dal peso delle applicazioni “inutili” solitamente installate dai produttori (sono caricate solo quelle di Google). E poi, non in ultimo, ecco preziosismi quali il supporto nativo per la visualizzazione di Nft nella galleria immagini oppure la possibilità di associare il telefono a un account Tesla per sbloccare le portiere o accendere a distanza l'aria condizionata dell'auto, direttamente dalle impostazioni del telefonino. Sarà un prodotto per cui ci si metterà in fila fuori dai negozi? Forse no, ma che sia diverso (e tanto) da tutti gli altri non ci sono dubbi."),
("iPhone 14 Pro Max. La differenza nei dettagli","Nessuno si aspettava rivoluzioni epocali, soprattutto chi conosce bene Apple: ogni soluzione tecnologica viene adottata nel momento esatto in cui la sua adozione non richiede compromessi di alcun tipo. Nel caso dell’iPhone 14 Pro l’elemento più significativo per capire la filosofia Apple è l’Always on Display: sono anni che i produttori di smartphone Android vendono telefoni con Always on Display, ma dopo aver visto il modo in cui Apple ha implementato questa tecnologia forse sarebbe il caso di ribattezzare quanto si è visto fino ad ora “always on pixels”. Abbiamo avuto flebili orologi su schermo nero, con qualche icona e qualche animazione, ora con iPhone 14 Pro abbiamo uno schermo che, se vogliamo, è totalmente attivo, ogni singolo pixel. Le foto non rendono forse l’idea, va visto dal vivo, ma è davvero impressionante vedere come Apple sia riuscita a mantenere una fedeltà cromatica impeccabile anche con una luminosità bassa e senza alcun flicker percepibile, nonostante lo schermo venga gestito ad una frequenza di refresh bassissima.Non è solo questo, perché ci sono decine di altri piccoli dettagli legati a questa specifica funzione che non passano inosservati: la luminosità dell’always on display viene regolata dinamicamente in base alla luminosità ambientale, e quest’anno Apple ha inserito addirittura un doppio sensore di luminosità, quello anteriore davanti allo schermo e uno posteriore che serve a bilanciare la luminosità nel caso in cui il sole non sia alle spalle di chi guarda ma di fronte, con un comportamento differente della pupilla. L’always on display ha widget dinamici, si spegne se si indossa l’Apple Watch e ci si sposta in un’altra stanza e riesce a capire quando non c’è nessuno nei paraggi e quindi non serve che resti acceso. Si spegne anche se è in tasca, nella borsa o in determinate modalità focus. Il tutto senza impattare più di tanto sull’autonomia della batteria, e con una serie di funzioni integrate nello schermo LTPO per evitare problemi di burn-in, ovvero di stampaggio dell’OLED. Problemi che comunque non dovrebbero verificarsi se si considerano le luminosità in gioco. Abbiamo preso questo esempio perché quelle che sono le principali novità dal punto di vista hardware del nuovo melafonino, vedi la fotocamera integrata nello schermo, o il sensore da 48 megapixel, o ancora il processore a 4 nanometri (5 in realtà), sono tutte cose che abbiamo già visto in questi anni su telefoni Android. A fare la differenza però sono i dettagli: ogni elemento nel caso del nuovo iPhone non solo è stato curato sotto ogni angolazione, ma è anche stato profondamente integrato con iOS.");
