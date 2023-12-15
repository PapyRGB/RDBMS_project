CREATE VIEW ClientStockOptionPrices AS
SELECT 
    c.ClientID, 
    c.Name AS ClientName, 
    s.StockID, 
    s.Name AS StockName, 
    o.Type, 
    o.StrikePrice, 
    o.ExpirationDate,
    mc.call_option_price AS MonteCarloCallPrice,
    mc.put_option_price AS MonteCarloPutPrice,
    bs.call_option_price AS BlackScholesCallPrice,
    bs.put_option_price AS BlackScholesPutPrice
FROM 
    Clients c
JOIN 
    Options o ON c.ClientID = o.ClientID
JOIN 
    Stocks s ON o.StockID = s.StockID
CROSS JOIN 
    LATERAL monte_carlo_option_pricing(s.CurrentPrice, /* other params */) mc
CROSS JOIN 
    LATERAL black_scholes_option_pricing(s.CurrentPrice, /* other params */) bs;
