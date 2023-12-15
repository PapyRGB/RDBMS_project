CREATE VIEW financial_dashboard_for_clients AS
SELECT
    ClientID,
    SUM(Balance) AS TotalBalance,
    COUNT(DISTINCT OptionID) AS TotalOptions,
    AVG(RiskScore) AS AverageRiskScore
FROM
    Wallets
JOIN
    OptionsInWallet ON Wallets.WalletID = OptionsInWallet.WalletID
JOIN
    Options ON OptionsInWallet.OptionID = Options.OptionID
GROUP BY
    ClientID;
