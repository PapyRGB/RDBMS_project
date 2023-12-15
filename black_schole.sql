CREATE OR REPLACE FUNCTION black_scholes_option_pricing(
    stock_id INTEGER,
    strike_price DECIMAL,
    time_to_maturity DECIMAL,
    risk_free_rate DECIMAL,
    volatility DECIMAL
)
RETURNS TABLE (call_option_price DECIMAL, put_option_price DECIMAL) AS $$
DECLARE
    current_price DECIMAL;
    d1 DECIMAL;
    d2 DECIMAL;
BEGIN
    SELECT CurrentPrice INTO current_price FROM Stocks WHERE StockID = stock_id;
    d1 := (ln(current_price / strike_price) + (risk_free_rate + volatility^2 / 2) * time_to_maturity) / (volatility * sqrt(time_to_maturity));
    d2 := d1 - volatility * sqrt(time_to_maturity);

    call_option_price := current_price * normal_cdf(d1) - strike_price * exp(-risk_free_rate * time_to_maturity) * normal_cdf(d2);
    put_option_price := strike_price * exp(-risk_free_rate * time_to_maturity) * normal_cdf(-d2) - current_price * normal_cdf(-d1);

    RETURN QUERY SELECT call_option_price, put_option_price;
END;
$$ LANGUAGE plpgsql;
