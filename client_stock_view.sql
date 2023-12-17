CREATE TEMP TABLE IF NOT EXISTS TempOptionPricing (
    OptionID INTEGER,
    MonteCarloCallPrice DECIMAL,
    MonteCarloPutPrice DECIMAL,
    BlackScholesCallPrice DECIMAL,
    BlackScholesPutPrice DECIMAL
);


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


CREATE VIEW ClientStockOptionPrices AS
SELECT 
    c.ClientID, 
    c.Name AS ClientName, 
    s.StockID, 
    s.Name AS StockName, 
    o.Type, 
    o.StrikePrice, 
    o.ExpirationDate,
    temp.MonteCarloCallPrice,
    temp.MonteCarloPutPrice,
    temp.BlackScholesCallPrice,
    temp.BlackScholesPutPrice
FROM 
    Clients c
JOIN 
    Wallets w ON c.ClientID = w.ClientID
JOIN 
    Options o ON w.WalletID = o.WalletID
JOIN 
    Stocks s ON o.StockID = s.StockID
JOIN 
    TempOptionPricing temp ON o.OptionID = temp.OptionID;
	
	
	
SELECT * FROM clientstockoptionprices;
