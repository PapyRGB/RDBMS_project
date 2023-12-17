CREATE TABLE Clients (
    ClientID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    RiskAdversityFactor INTEGER NOT NULL
);

CREATE TABLE Stocks (
    StockID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    CurrentPrice DECIMAL NOT NULL,
    Volatility DECIMAL NOT NULL
);

CREATE TABLE Wallets (
    WalletID SERIAL PRIMARY KEY,
    ClientID INTEGER NOT NULL REFERENCES Clients(ClientID),
    Balance DECIMAL NOT NULL
);


CREATE TABLE Options (
    OptionID SERIAL PRIMARY KEY,
    WalletID INTEGER NOT NULL REFERENCES Wallets(WalletID),
    StockID INTEGER NOT NULL REFERENCES Stocks(StockID),
    Type VARCHAR(50) NOT NULL CHECK (Type IN ('Put', 'Call')),
    StrikePrice DECIMAL NOT NULL,
    ExpirationDate DATE NOT NULL,
    RiskFreeRate DECIMAL NOT NULL, 
    TimeToMaturity DECIMAL NOT NULL, 
    NumSimulations INT NOT NULL
);


CREATE TABLE HistoricalPrices (
    PriceID SERIAL PRIMARY KEY,
    StockID INTEGER NOT NULL REFERENCES Stocks(StockID),
    Date DATE NOT NULL,
    Price DECIMAL NOT NULL
);


CREATE TEMP TABLE TempOptionPricing (
    OptionID INTEGER,
    MonteCarloCallPrice DECIMAL,
    MonteCarloPutPrice DECIMAL,
    BlackScholesCallPrice DECIMAL,
    BlackScholesPutPrice DECIMAL
);

