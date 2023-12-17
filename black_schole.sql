CREATE OR REPLACE FUNCTION abramowitz_stegun_approximation(z DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $$
DECLARE
    s DOUBLE PRECISION;
    t DOUBLE PRECISION;
    y DOUBLE PRECISION;
BEGIN
    s := 1.0 / (1.0 + 0.2316419 * ABS(z));
    t := s * (0.319381530 + s * (-0.356563782 + s * (1.781477937 + s * (-1.821255978 + 1.330274429 * s))));
    y := exp(-0.5 * z * z) / 2.506628274631;

    IF z > 0 THEN
        RETURN 1.0 - y * t;
    ELSE
        RETURN y * t;
    END IF;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE black_scholes_option_pricing(
    stock_id INTEGER,
    strike_price DECIMAL,
    time_to_maturity DECIMAL,
    risk_free_rate DECIMAL,
    volatility DECIMAL
) AS $$
DECLARE
    current_price DECIMAL;
    d1 DECIMAL;
    d2 DECIMAL;
    call_option_price DECIMAL;
    put_option_price DECIMAL;
BEGIN
    SELECT CurrentPrice INTO current_price FROM Stocks WHERE StockID = stock_id;
    d1 := (ln(current_price / strike_price) + (risk_free_rate + volatility^2 / 2) * time_to_maturity) / (volatility * sqrt(time_to_maturity));
    d2 := d1 - volatility * sqrt(time_to_maturity);

    call_option_price := current_price * abramowitz_stegun_approximation(d1) - strike_price * exp(-risk_free_rate * time_to_maturity) * abramowitz_stegun_approximation(d2);
    put_option_price := strike_price * exp(-risk_free_rate * time_to_maturity) * abramowitz_stegun_approximation(-d2) - current_price * abramowitz_stegun_approximation(-d1);

    INSERT INTO TempOptionPricing (OptionID, BlackScholesCallPrice, BlackScholesPutPrice)
    VALUES (stock_id, call_option_price, put_option_price);
END;
$$ LANGUAGE plpgsql;

