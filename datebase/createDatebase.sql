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
Amministratore INT DEFAULT 0
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
    ID_Prodotto INT NOT NULL,
    Quantità INT NOT NULL,
    Totale DOUBLE(10, 2) NOT NULL,
    FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente),
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);

-- Creazione della tabella relativa ai dettagli del pagamento
CREATE TABLE Pagamento (
	ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Ordine INT NOT NULL,
    Data_Pagamento DATE NOT NULL,
    Titolare_Carta VARCHAR(60) NOT NULL,
    Numero_Carta CHAR(16) NOT NULL,
    Scadenza DATE NOT NULL,
    CVV CHAR(3) NOT NULL,
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

-- 			+-------------------+ 			--
-- 			|	 INSERIMENTO    | 			--
-- 			+-------------------+ 			--


-- Creazione dell'amministratore
INSERT INTO Utente (Nome, Cognome, Username, Email, Passw, Telefono, Citta, Provincia, Indirizzo, Codice_Postale, Amministratore) VALUES
('Giovanni', 'Manfredi', 'John_64', 'g.manfredi5@studenti.unisa.it', '12345678', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 0),
('Giovanni', 'Manfredi', 'Amministratore', 'aa@aa.aa', 'aaaaaa', '3201234567', 'Fisciano', 'SA', 'Via Giovanni Paolo II, 132', '84084', 1);

INSERT INTO Categoria (Nome_Categoria) VALUES ('Smartphone');
INSERT INTO Categoria (Nome_Categoria) VALUES ('Tablet');
INSERT INTO Categoria (Nome_Categoria) VALUES ('Laptop');
INSERT INTO Categoria (Nome_Categoria) VALUES ('Tutte le opzioni');

-- SEZIONE APPLE
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Ipad", "Display 10.2 - Fotocamera 8 MPX - CPU A13 Bionic - RAM 3GB - ROM 64GB", 389, 50, "images/products/apple/ipadBase.jpg", "Apple", 15, "Tablet"),
("Ipad Air", "Display 10.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 64GB", 699, 23, "images/products/apple/ipadAir.jpg", "Apple", 0, "Tablet"),
("Ipad Mini", "Display 8.3 - Fotocamera 12 MPX - CPU A15 Bionic - RAM 4GB - ROM 64GB", 559, 30, "images/products/apple/ipadMini.jpg", "Apple", 5, "Tablet"),
("Ipad Pro", "Display 12.9 - Fotocamera 12 MPX - CPU M1 - RAM 8GB - ROM 128GB", 1219, 30, "images/products/apple/ipadPro.jpg", "Apple", 0, "Tablet"),
("Iphone 13", "--", 1219, 30, "images/products/apple/iphone13.jpg", "Apple", 5, "Smartphone"),
("Iphone 13 Pro", "--", 999, 30, "images/products/apple/iphone13Pro.jpg", "Apple", 10, "Smartphone"),
("Iphone 13 Mini", "--", 649, 30, "images/products/apple/iphone13Mini.jpg", "Apple", 15, "Smartphone"),
("Iphone 14", "--", 1029, 50, "images/products/apple/iphone14.jpg", "Apple", 5, "Smartphone"),
("Iphone 14 Pro", "--", 1339, 40, "images/products/apple/iphone14Pro.jpg", "Apple", 10, "Smartphone");

-- SEZIONE SAMSUNG
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Galaxy Fold 4", "--", 1879, 30, "images/products/samsung/fold4.jpg", "Samsung", 10, "Smartphone"),
("Galaxy S21", "--", 599, 10, "images/products/samsung/s21.jpg", "Samsung", 15, "Smartphone"),
("Galaxy S21 Plus", "--", 699, 10, "images/products/samsung/s21Plus.jpg", "Samsung", 5, "Smartphone"),
("Tab A7", "--", 149, 30, "images/products/samsung/tabA7.jpg", "Samsung", 20, "Tablet"),
("Tab S6 Lite", "--", 299, 20, "images/products/samsung/tabS6Lite.jpg", "Samsung", 30, "Tablet"),
("Tab S7", "--", 549, 13, "images/products/samsung/tabS7.jpg", "Samsung", 15, "Tablet"),
("Galaxy Book2 Pro 360", "--", 1649, 7, "images/products/samsung/galaxyBook2Pro360.jpg", "Samsung", 10, "Laptop"),
("Galaxy Book2", "--", 1199, 7, "images/products/samsung/galaxyBook2.jpg", "Samsung", 10, "Laptop");

-- SEZIONE XIAOMI
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Xiaomi 12", "--", 649, 20, "images/products/xiaomi/xiaomi12.jpg", "Xiaomi", 0, "Smartphone"),
("Xiaomi 12 Pro", "--", 849, 14, "images/products/xiaomi/xiaomi12Pro.jpg", "Xiaomi", 0, "Smartphone"),
("Xiaomi Mi 11", "--", 799, 10, "images/products/xiaomi/xiaomiMi11.jpg", "Xiaomi", 40, "Smartphone"),
("Xiaomi Redmi Note 11 Pro", "--", 379, 50, "images/products/xiaomi/xiaomiRedmiNote11Pro.jpg", "Xiaomi", 30, "Smartphone"),
("Xiaomi Book S", "--", 329, 30, "images/products/xiaomi/xiaomiBookS.jpg", "Xiaomi", 20, "Tablet"),
("Xiaomi Book S", "--", 699, 30, "images/products/xiaomi/xiaomiBookS.jpg", "Xiaomi", 15, "Laptop"),
("Xiaomi Mi Redmi Pro 14", "--", 1099, 10, "images/products/xiaomi/xiaomiMiRedmiPro14.jpg", "Xiaomi", 10, "Laptop"),
("Xiaomi Mi Redmi Pro 15", "--", 1299, 13, "images/products/xiaomi/xiaomiMiRedmiPro15.jpg", "Xiaomi", 20, "Laptop");

-- SEZIONE HUAWEI
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Huawei P40 Pro", "--", 799, 17, "images/products/huawei/huaweiP40Pro.jpg", "Huawei", 5, "Smartphone"),
("Huawei P30 Pro", "--", 599, 12, "images/products/huawei/huaweiP30Pro.jpg", "Huawei", 15, "Smartphone"),
("Huawei Mate 30 Pro", "--", 699, 10, "images/products/huawei/huaweiMate30Pro.jpg", "Huawei", 10, "Smartphone"),
("Huawei Mate Pad Pro", "--", 649, 24, "images/products/huawei/huaweiMatePadPro.jpg", "Huawei", 20, "Tablet");

-- SEZIONE NOTHING
INSERT INTO Prodotto (Nome, Descrizione, Prezzo, Quantita, Path_Immagine, Brand, Sconto, Nome_Categoria) VALUE
("Nothing Phone 1", "Display 6.55 - Fotocamera 50 MPX - CPU Snapdragon 778G - RAM 8GB - ROM 256GB", 529, 0, "images/products/nothing/nothingPhone1.jpg", "Nothing", 0, "Smartphone");


-- SEZIONE VALUTAZIONE
INSERT INTO Valutazione (ID_Utente, ID_Prodotto, Punteggio, Recensione, Data_Recensione) VALUE
(1, 1, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-07-05'),
(2, 1, 3, "Non male." , '2022-06-05'),
(1, 2, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-08-15'),
(1, 3, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-06-23'),
(1, 4, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-07-12'),
(1, 5, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-05-02'),
(1, 6, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-07-25'),
(1, 7, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-06-12'),
(1, 8, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-09-03'),
(1, 9, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-08-04'),
(1, 10, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-04-01'),
(1, 11, 1, "Il prodotto in questione è pessimo. Reso effettuato." , '2022-04-05'),
(1, 12, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-5-19'),
(1, 13, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-05-21'),
(1, 14, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-07-21'),
(1, 15, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-08-27'),
(1, 16, 5, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-09-02'),
(1, 17, 4, "Il prodotto in questione è ottimo! Consigliato!" , '2022-05-25'),
(1, 18, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-04-13'),
(1, 19, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-05-17'),
(1, 20, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-05-25'),
(1, 21, 1, "Il prodotto in questione è pessimo. Reso effettuato." , '2022-07-07'),
(1, 22, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-04-17'),
(1, 23, 5, "Il prodotto in questione è il migliore sul mercato. Super consigliato!" , '2022-06-06'),
(1, 24, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-08-09'),
(1, 25, 2, "Il prodotto in questione non mi ha fatto impazzire. Non lo consiglio!" , '2022-09-11'),
(1, 26, 1, "Il prodotto in questione è pessimo. Reso effettuato." , '2022-03-19'),
(1, 27, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-07-26'),
(1, 28, 3, "Il prodotto in questione è buono. Lo consiglierei!" , '2022-07-26');
