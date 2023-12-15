CREATE TABLE Clients (
    client_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    risk_adversity_factor DECIMAL(3, 2) CHECK (risk_adversity_factor BETWEEN 0 AND 1)
);

CREATE TABLE Wallets (
    wallet_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Clients(client_id),
    balance DECIMAL(15, 2) NOT NULL
);

CREATE TABLE Options_in_Wallets (
    option_id SERIAL PRIMARY KEY,
    wallet_id INT REFERENCES Wallets(wallet_id),
    type VARCHAR(4) CHECK (type IN ('Put', 'Call')),
    strike_price DECIMAL(10, 2) NOT NULL,
    expiration_date DATE NOT NULL
);

CREATE TABLE Monitored_Stocks (
    stock_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    current_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Historical_Stock_Price_Data (
    data_id SERIAL PRIMARY KEY,
    stock_id INT REFERENCES Monitored_Stocks(stock_id),
    date DATE NOT NULL,
    historical_price DECIMAL(10, 2) NOT NULL
);
