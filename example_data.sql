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


-- First, ensure that the TempOptionPricing table is empty
TRUNCATE TempOptionPricing;

-- Then, iterate over each option in the Options table
DO $$
DECLARE
    option_record RECORD;
BEGIN
    FOR option_record IN SELECT o.OptionID, s.StockID, o.StrikePrice, s.Volatility, o.RiskFreeRate, o.TimeToMaturity, o.NumSimulations
                          FROM Options o
                          JOIN Stocks s ON o.StockID = s.StockID
    LOOP
        -- Call Monte Carlo procedure for each option
        CALL monte_carlo_option_pricing(option_record.StockID, option_record.StrikePrice, option_record.Volatility, option_record.RiskFreeRate, option_record.TimeToMaturity, option_record.NumSimulations);

        -- Call Black-Scholes procedure for each option
        CALL black_scholes_option_pricing(option_record.StockID, option_record.StrikePrice, option_record.TimeToMaturity, option_record.RiskFreeRate, option_record.Volatility);

        -- Update the OptionID in the TempOptionPricing table
        UPDATE TempOptionPricing
        SET OptionID = option_record.OptionID
        WHERE OptionID IS NULL;
    END LOOP;
END $$;
