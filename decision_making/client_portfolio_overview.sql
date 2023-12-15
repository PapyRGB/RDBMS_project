CREATE VIEW client_portfolio_overview AS
SELECT
    c.ClientID,
    c.Name,
    SUM(o.CurrentValue) AS TotalOptionsValue,
    SUM(s.CurrentPrice * os.Quantity) AS TotalStocksValue,
    w.Balance AS WalletBalance,
    (SUM(o.CurrentValue) + SUM(s.CurrentPrice * os.Quantity) + w.Balance) AS TotalPortfolioValue
FROM
    Clients c
JOIN
    Wallets w ON c.ClientID = w.ClientID
JOIN
    OptionsInWallet ow ON w.WalletID = ow.WalletID
JOIN
    Options o ON ow.OptionID = o.OptionID
JOIN
    StocksInWallet sw ON w.WalletID = sw.WalletID
JOIN
    Stocks s ON sw.StockID = s.StockID
GROUP BY
    c.ClientID, c.Name, w.Balance;
