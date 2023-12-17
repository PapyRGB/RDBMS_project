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
