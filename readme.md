# Progetto Smart Contract con Solidity di Alessandro Ponton 
## Ambito Fashion

### Testnet https://sepolia.etherscan.io/address/0xe2704aa2c89602ce3bb011aaccd0f6a2d08e6ce4

Questo smart contract scritto in Solidity gestisce un sistema di e-commerce per la vendita di abbigliamento utilizzando Ethereum. Il contratto consente di aggiungere prodotti, tracciare le vendite e gestire gli acquisti in Ether. Lo smart contract è diviso in due sotto-contratti: `ProductManager` e `FashionCommerceManager`, dove il secondo eredita le funzionalità dal primo.

## Struttura del Contratto

### 1. Contratto ProductManager

Il contratto `ProductManager` funziona come base per la gestione di prodotti e vendite.

#### Struct:

- **Product**: Memorizza le informazioni di un prodotto, tra cui ID, nome, quantità e prezzo in Ether.
- **Sale**: Contiene l'ID del prodotto venduto, l'indirizzo dell'acquirente e il timestamp di una vendita.

#### Funzioni:

- **getProductsPurchasedBy**: Restituisce la lista dei prodotti acquistati da un determinato cliente.
- **calculateSalesAmount**: Calcola l'importo totale delle vendite dato un intervallo di tempo specifico.

### 2. Contratto FashionCommerceManager

Il contratto `FashionCommerceManager` estende `ProductManager` e aggiunge funzionalità per la gestione del processo di e-commerce.

#### Variabili di Stato:

- **owner**: L'indirizzo del proprietario del contratto.
- **products**: Un array che memorizza tutti i prodotti disponibili.
- **sales**: Un array che memorizza tutte le vendite effettuate.
- **totalSales**: Un contatore per il numero totale di vendite registrate.

#### Eventi:

- **SaleRecorded**: Emette un evento ogni volta che una nuova vendita viene registrata all'array delle vendite. Contiene l'ID della vendita, l'ID del prodotto, l'indirizzo dell'acquirente e il timestamp.

#### Modificatori:

- **onlyOwner**: Permette l'accesso a determinate funzioni solo al proprietario del contratto.

#### Funzioni:

- **addProduct**: Consente al proprietario di aggiungere un nuovo prodotto al catalogo, specificando nome, quantità e prezzo in Ether.
- **getProduct**: Recupera i dettagli di un prodotto in base al suo ID.
- **purchaseProduct**: Consente a un cliente di acquistare un prodotto inviando Ether. La funzione verifica la disponibilità del prodotto e la disponibilità di fondi prima di registrare la vendita. Una volta effettuata la vendita, aggiorna il catalogo dei prodotti.
- **withdraw**: Consente al proprietario di ritirare il saldo di Ether dal contratto.
- **getSale**: Recupera le informazioni su una vendita specifica in base al suo ID.

## Come Funziona

1. **Aggiunta di Prodotti**: Il proprietario può aggiungere nuovi prodotti specificando nome, quantità e prezzo in Ether. Ad ogni prodotto viene assegnato un ID univoco.
2. **Acquisto di Prodotti**: I clienti possono acquistare prodotti chiamando la funzione `purchaseProduct` e inviando la quantità necessaria di Ether. Conseguentemente, La quantità del prodotto viene ridotta e la vendita viene registrata nell'array delle vendite.
3. **Tracciamento delle Vendite**: Il contratto tiene traccia di tutte le vendite, ed emette l'evento `SaleRecorded` per ogni vendita effettuata.
4. **Ritirare Fondi**: Il proprietario del contratto può ritirare il saldo di Ether raccolto utilizzando la funzione `withdraw`.

## Considerazioni sulla Sicurezza

- Il contratto utilizza istruzioni **require** per convalidare le condizioni, come il controllo della disponibilità del prodotto e di fondi sufficienti.

## Distribuzione

Per distribuire questo contratto, avrai bisogno di:

- **Solidity Compiler**: Versione 0.8.18 o compatibile.
- **Wallet Ethereum**: Per distribuire e interagire con il contratto su una testnet o mainnet.


## Licenza

Licenza MIT.

