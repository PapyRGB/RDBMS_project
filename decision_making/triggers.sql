CREATE OR REPLACE FUNCTION update_financial_dashboard()
RETURNS TRIGGER AS $$
BEGIN
    -- Logic to update financial dashboard
    UPDATE financial_dashboard_for_clients
    SET TotalBalance = NEW.Balance
    WHERE ClientID = NEW.ClientID;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_portfolio_update
AFTER INSERT OR UPDATE ON Wallets
FOR EACH ROW EXECUTE FUNCTION update_financial_dashboard();
