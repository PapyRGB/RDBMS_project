# Project Title: Options Trading System in a Banking Environment

## Overview

This project aims to develop a robust Relational Database Management System (RDBMS) using PostgreSQL, focusing on options trading within a banking system. It integrates financial models, decision-making processes, and database management to create a comprehensive system for managing and evaluating stock options.

## Components

The project is divided into several key components, each focusing on a specific aspect of the options trading system:

1. **Database Modelization**
   - Design of a relational database schema to manage clients, wallets, options, stocks, and historical stock data.

2. **Monte Carlo Simulation Stored Procedure**
   - Implementation of a stored procedure for Monte Carlo simulations to estimate option prices.

3. **Black-Scholes Model Stored Procedure**
   - Creation of a stored procedure to calculate option prices using the Black-Scholes formula.

4. **Option Prices View**
   - Development of a view that combines Monte Carlo and Black-Scholes prices for client-stock pairs.

5. **Triggers and Stored Procedure Updates**
   - Implementation of triggers for automatic updates of option prices based on changes in stock prices or client data.

6. **Decision-Making Process for Options Trading**
   - A comprehensive system including ranking systems for options, decision logic, client portfolio management, and financial dashboards.

## Theoretical Concepts and Formulas

### Monte Carlo Simulation

The Monte Carlo simulation is a statistical method used to estimate the probable outcomes of an uncertain process. In this project, it is employed to predict future stock prices and option valuations. The formula used is based on Geometric Brownian Motion, reflecting the random walk theory of stock price movements.

### Black-Scholes Model

The Black-Scholes model is a mathematical model for pricing European-style options. It calculates the theoretical value of options using key inputs like the stock price, strike price, volatility, risk-free interest rate, and time to maturity. The model includes two primary formulas for call and put options:

- Call Option Price: `C = S0 * N(d1) - K * e^(-rT) * N(d2)`
- Put Option Price: `P = K * e^(-rT) * N(-d2) - S0 * N(-d1)`
where `d1` and `d2` are intermediate variables based on the other parameters.

## Usage and Implementation

Each component of the project is implemented through SQL scripts and stored procedures in PostgreSQL. The database schema is carefully designed to encapsulate all necessary aspects of options trading within a bank environment. The stored procedures for Monte Carlo simulations and the Black-Scholes model are critical for calculating the option prices, which are then made accessible through a dedicated view.

## Conclusion

This project successfully integrates complex financial theories and database management techniques to create a versatile and efficient system for options trading in a banking environment. It exemplifies the practical application of theoretical concepts to solve real-world financial problems.
"""
