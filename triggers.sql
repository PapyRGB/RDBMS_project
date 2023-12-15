-- Triggers for Stock Price Changes

CREATE OR REPLACE FUNCTION update_option_prices_on_stock_change()
RETURNS TRIGGER AS $$
BEGIN
    -- Call stored procedures to update option prices
    -- Assuming a procedure 'update_option_prices' exists
    PERFORM update_option_prices(NEW.StockID, NEW.CurrentPrice);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_stock_price_change
AFTER UPDATE OF CurrentPrice ON Stocks
FOR EACH ROW EXECUTE FUNCTION update_option_prices_on_stock_change();


-- Triggers for Client Information Changes

CREATE OR REPLACE FUNCTION update_client_options_on_client_change()
RETURNS TRIGGER AS $$
BEGIN
    -- Update client's options based on new client information
    -- Assuming a procedure 'update_client_options' exists
    PERFORM update_client_options(NEW.ClientID);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_client_info_change
AFTER UPDATE ON Clients
FOR EACH ROW EXECUTE FUNCTION update_client_options_on_client_change();
