create schema assignment2;
USE assignment2;
DROP TABLE portfolio, company;

CREATE TABLE company (	
	company_name varchar(255), 
    stock_ticker varchar(255) NOT NULL,
    industry varchar(255),
    PRIMARY KEY (stock_ticker)
);
CREATE TABLE portfolio (
	id int NOT NULL,
	stock_ticker varchar(255) NOT NULL, 
    number_of_shares int,
    date_purchased DATE,
    price_purchased double,
    current_price double,
    PRIMARY KEY (id),
    FOREIGN KEY (stock_ticker) REFERENCES 
company(stock_ticker)
);


INSERT INTO company(company_name, stock_ticker, industry)
	VALUES("Alphabet Inc.", "GOOG", "Internet Content & Information");
    
INSERT INTO portfolio(id, stock_ticker, number_of_shares, date_purchased,
	price_purchased, current_price) 
    VALUES (1, "GOOG", 1000, "2010-01-04", 15.61, 136.20);

INSERT INTO company(company_name, stock_ticker, industry)
	VALUES("Meta Platforms, Inc.", "META", "Internet Content & Information");
    
INSERT INTO portfolio(id, stock_ticker, number_of_shares, date_purchased,
	price_purchased, current_price) 
    VALUES (2, "META", 1000000, "2012-09-19", 23.29, 298.67);

INSERT INTO company(company_name, stock_ticker, industry)
	VALUES("Netflix", "NFLX", "Entertainment");
    
INSERT INTO portfolio(id, stock_ticker, number_of_shares, date_purchased,
	price_purchased, current_price) 
    VALUES (3, "NFLX", 100000, "2003-8-15", 1.78, 443.14);

INSERT INTO company(company_name, stock_ticker, industry)
	VALUES("Tesla Inc", "TSLA", "Auto Manufacturers");
    
INSERT INTO portfolio(id, stock_ticker, number_of_shares, date_purchased,
	price_purchased, current_price) 
    VALUES (4, "TSLA", 1000000, "2011-7-22", 1.95, 251.49);
    
INSERT INTO company(company_name, stock_ticker, industry)
	VALUES("Apple Inc.", "AAPL", "Consumer Electronics");

INSERT INTO portfolio(id, stock_ticker, number_of_shares, date_purchased,
	price_purchased, current_price) 
    VALUES (5, "AAPL", 500, "1999-06-04", 0.36, 177.56);

INSERT INTO company(company_name, stock_ticker, industry)
	VALUES("Amazon.com, Inc.", "AMZN", "Internet Retail");

INSERT INTO portfolio(id, stock_ticker, number_of_shares, date_purchased,
	price_purchased, current_price) 
    VALUES (6, "AMZN", 50, "2000-09-22", 2.07, 137.85);

SELECT c.company_name AS "Company Name", c.stock_ticker AS "Ticker", p.number_of_shares AS "# Shares", (p.number_of_shares * p.current_price) AS "Value" FROM
	portfolio AS p JOIN company AS c ON p.stock_ticker = c.stock_ticker;

