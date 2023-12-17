CREATE OR REPLACE PROCEDURE monte_carlo_option_pricing(
    stock_id INTEGER,
    strike_price DECIMAL,
    volatility DECIMAL,
    risk_free_rate DECIMAL,
    time_to_maturity DECIMAL,
    num_simulations INTEGER
) AS $$
DECLARE
    current_price DECIMAL;
    i INTEGER;
    sum_call_payoff DECIMAL := 0;
    sum_put_payoff DECIMAL := 0;
    simulated_price DECIMAL;
    call_payoff DECIMAL;
    put_payoff DECIMAL;
    call_option_price DECIMAL;
    put_option_price DECIMAL;
BEGIN
    SELECT CurrentPrice INTO current_price FROM Stocks WHERE StockID = stock_id;

    FOR i IN 1..num_simulations LOOP
        simulated_price := current_price * exp((risk_free_rate - 0.5 * volatility^2) * time_to_maturity + volatility * sqrt(time_to_maturity) * random());
        call_payoff := GREATEST(simulated_price - strike_price, 0);
        put_payoff := GREATEST(strike_price - simulated_price, 0);
        sum_call_payoff := sum_call_payoff + call_payoff;
        sum_put_payoff := sum_put_payoff + put_payoff;
    END LOOP;

    call_option_price := exp(-risk_free_rate * time_to_maturity) * sum_call_payoff / num_simulations;
    put_option_price := exp(-risk_free_rate * time_to_maturity) * sum_put_payoff / num_simulations;

    INSERT INTO TempOptionPricing (OptionID, MonteCarloCallPrice, MonteCarloPutPrice)
    VALUES (stock_id, call_option_price, put_option_price);
END;
$$ LANGUAGE plpgsql;
