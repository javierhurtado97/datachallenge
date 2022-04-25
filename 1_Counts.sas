
PROC SQL;
CREATE TABLE WORK.TEMP1 AS
	SELECT
		*
	FROM WORK.RATES
	(obs = 20)
	;
QUIT;

PROC SQL;
CREATE TABLE WORK.TEMP2 AS
	SELECT
		*
	FROM WORK.TRANSACTIONS
	(obs = 20)
	;
QUIT;

PROC SQL;
CREATE TABLE WORK.TEMP3 AS
	SELECT
		*
	FROM WORK.USERS
	(obs = 20)
	;
QUIT;

PROC SQL;
CREATE TABLE WORK.count_rates AS
	SELECT
		count(*)
	FROM WORK.RATES
	;
QUIT;
/* Diccionario de Rates */

PROC SQL;
CREATE TABLE WORK.count_transactions AS
	SELECT
		count(*)
	FROM WORK.TRANSACTIONS
	;
QUIT;
/* 8.836 Transactions - PK ID, FK USER_ID */

PROC SQL;
CREATE TABLE WORK.count_users AS
	SELECT
		count(*)
		, count(distinct USER_ID)
	FROM WORK.USERS
	;
QUIT;
/* 50.000 USERS, 50.000 DISTINCT USERS - PK USER_ID */
