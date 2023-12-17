-- Clients Table
INSERT INTO Clients (ClientID, Name, RiskAdversityFactor) VALUES
(1, 'John Doe', 3),
(2, 'Jane Smith', 5),
(3, 'Alice Johnson', 2);


-- Stocks Table
INSERT INTO Stocks (StockID, Name, CurrentPrice, Volatility) VALUES
(1, 'TechCo', 150.00, 0.2),
(2, 'HealthCare Inc.', 80.00, 0.15),
(3, 'EcoEnergy', 60.00, 0.25);


-- Wallets Table
INSERT INTO Wallets (WalletID, ClientID, Balance) VALUES
(1, 1, 10000.00),
(2, 2, 15000.00),
(3, 3, 5000.00);


-- Options Table
INSERT INTO Options (WalletID, StockID, Type, StrikePrice, ExpirationDate, RiskFreeRate, TimeToMaturity, NumSimulations) VALUES
(1, 1, 'Call', 160.00, '2023-12-31', 0.05, 1, 1000),
(1, 2, 'Put', 75.00, '2023-06-30', 0.05, 0.5, 1000),
(2, 3, 'Call', 65.00, '2024-01-31', 0.05, 1.1, 1000);


-- HistoricalPrices Table
INSERT INTO HistoricalPrices (StockID, Date, Price) VALUES
(1, '2023-01-01', 148.00),
(1, '2023-01-02', 149.50),
(1, '2023-01-03', 150.50),
(2, '2023-01-01', 79.00),
(2, '2023-01-02', 80.50),
(2, '2023-01-03', 81.00),
(3, '2023-01-01', 59.50),
(3, '2023-01-02', 60.25),
(3, '2023-01-03', 60.75);
