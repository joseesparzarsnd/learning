SELECT TOP 50 * FROM bronze.AirlineDelayCausesData;

/*
By analizing the data, I've noticed the following:
- The year and month are integers. Month can be a tinyint, while year can be a smallint.
- Carrier has a fixed length of 2 characters.
- Airport has a fixed length of 3 characters.
- The columns from arr_flights onwards are all decimal numbers.
*/

-- Check if carrier and month are fixed length.
SELECT
	MAX(LEN(carrier)) AS max_carrier_len,
	MIN(LEN(carrier)) AS min_carrier_len,
	MAX(LEN(airport)) AS max_airport_len,
	MIN(LEN(airport)) AS min_airport_len
FROM
	bronze.AirlineDelayCausesData;

-- Count nulls.
SELECT
	SUM(CASE WHEN COALESCE(year, '') = '' THEN 1 ELSE 0 END) AS year_nulls,
	SUM(CASE WHEN COALESCE(month, '') = '' THEN 1 ELSE 0 END) AS month_nulls,
	SUM(CASE WHEN COALESCE(carrier, '') = '' THEN 1 ELSE 0 END) AS carrier_nulls,
	SUM(CASE WHEN COALESCE(carrier_name, '') = '' THEN 1 ELSE 0 END) AS carrier_name_nulls,
	SUM(CASE WHEN COALESCE(airport, '') = '' THEN 1 ELSE 0 END) AS airport_nulls,
	SUM(CASE WHEN COALESCE(airport_name, '') = '' THEN 1 ELSE 0 END) AS airport_name_nulls,
	SUM(CASE WHEN COALESCE(arr_flights, '') = '' THEN 1 ELSE 0 END) AS arr_flights_nulls,
	SUM(CASE WHEN COALESCE(arr_del15, '') = '' THEN 1 ELSE 0 END) AS arr_del15_nulls,
	SUM(CASE WHEN COALESCE(carrier_ct, '') = '' THEN 1 ELSE 0 END) AS carrier_ct_nulls,
	SUM(CASE WHEN COALESCE(weather_ct, '') = '' THEN 1 ELSE 0 END) AS weather_ct_nulls,
	SUM(CASE WHEN COALESCE(nas_ct, '') = '' THEN 1 ELSE 0 END) AS nas_ct_nulls,
	SUM(CASE WHEN COALESCE(security_ct, '') = '' THEN 1 ELSE 0 END) AS security_ct_nulls,
	SUM(CASE WHEN COALESCE(late_aircraft_ct, '') = '' THEN 1 ELSE 0 END) AS late_aircraft_ct_nulls,
	SUM(CASE WHEN COALESCE(arr_canceled, '') = '' THEN 1 ELSE 0 END) AS arr_canceled_nulls,
	SUM(CASE WHEN COALESCE(arr_diverted, '') = '' THEN 1 ELSE 0 END) AS arr_diverted_nulls,
	SUM(CASE WHEN COALESCE(arr_delay, '') = '' THEN 1 ELSE 0 END) AS arr_delay_nulls,
	SUM(CASE WHEN COALESCE(carrier_delay, '') = '' THEN 1 ELSE 0 END) AS carrier_delay_nulls,
	SUM(CASE WHEN COALESCE(weather_delay, '') = '' THEN 1 ELSE 0 END) AS weather_delay_nulls,
	SUM(CASE WHEN COALESCE(nas_delay, '') = '' THEN 1 ELSE 0 END) AS nas_delay_nulls,
	SUM(CASE WHEN COALESCE(security_delay, '') = '' THEN 1 ELSE 0 END) AS security_delay_nulls,
	SUM(CASE WHEN COALESCE(SUBSTRING(late_aircraft_delay, 0, LEN(late_aircraft_delay)), '') = '' THEN 1 ELSE 0 END) AS late_aircraft_delay_nulls
FROM bronze.AirlineDelayCausesData;

/*
The numeric columns for this table all expect nulls. Now, let's check if they're comprised of decimals or integers.
*/

SELECT
    SUM(CASE WHEN TRY_CAST(arr_flights AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(arr_flights AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_flights_integers,
	SUM(CASE WHEN TRY_CAST(arr_flights AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(arr_flights AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_flights_decimals,
	---
    SUM(CASE WHEN TRY_CAST(arr_del15 AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(arr_del15 AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_del15_integers,
	SUM(CASE WHEN TRY_CAST(arr_del15 AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(arr_del15 AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_del15_decimals,
	---
    SUM(CASE WHEN TRY_CAST(carrier_ct AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(carrier_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS carrier_ct_integers,
	SUM(CASE WHEN TRY_CAST(carrier_ct AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(carrier_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS carrier_ct_decimals,
	---
    SUM(CASE WHEN TRY_CAST(weather_ct AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(weather_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS weather_ct_integers,
	SUM(CASE WHEN TRY_CAST(weather_ct AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(weather_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS weather_ct_decimals,
	---
    SUM(CASE WHEN TRY_CAST(nas_ct AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(nas_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS nas_ct_integers,
	SUM(CASE WHEN TRY_CAST(nas_ct AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(nas_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS nas_ct_decimals,
	---
    SUM(CASE WHEN TRY_CAST(security_ct AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(security_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS security_ct_integers,
	SUM(CASE WHEN TRY_CAST(security_ct AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(security_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS security_ct_decimals,
	---
    SUM(CASE WHEN TRY_CAST(late_aircraft_ct AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(late_aircraft_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS late_aircraft_ct_integers,
	SUM(CASE WHEN TRY_CAST(late_aircraft_ct AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(late_aircraft_ct AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS late_aircraft_ct_decimals,
	---
    SUM(CASE WHEN TRY_CAST(arr_canceled AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(arr_canceled AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_canceled_integers,
	SUM(CASE WHEN TRY_CAST(arr_canceled AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(arr_canceled AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_canceled_decimals,
	---
    SUM(CASE WHEN TRY_CAST(arr_diverted AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(arr_diverted AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_diverted_integers,
	SUM(CASE WHEN TRY_CAST(arr_diverted AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(arr_diverted AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_diverted_decimals,
	---
    SUM(CASE WHEN TRY_CAST(arr_delay AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(arr_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_delay_integers,
	SUM(CASE WHEN TRY_CAST(arr_delay AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(arr_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS arr_delay_decimals,
	---
    SUM(CASE WHEN TRY_CAST(carrier_delay AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(carrier_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS carrier_delay_integers,
	SUM(CASE WHEN TRY_CAST(carrier_delay AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(carrier_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS carrier_delay_decimals,
	---
    SUM(CASE WHEN TRY_CAST(weather_delay AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(weather_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS weather_delay_integers,
	SUM(CASE WHEN TRY_CAST(weather_delay AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(weather_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS weather_delay_decimals,
	---
    SUM(CASE WHEN TRY_CAST(nas_delay AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(nas_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS nas_delay_integers,
	SUM(CASE WHEN TRY_CAST(nas_delay AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(nas_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS nas_delay_decimals,
	---
    SUM(CASE WHEN TRY_CAST(security_delay AS DECIMAL(38, 10)) = FLOOR(TRY_CAST(security_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS security_delay_integers,
	SUM(CASE WHEN TRY_CAST(security_delay AS DECIMAL(38, 10)) <> FLOOR(TRY_CAST(security_delay AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS security_delay_decimals,
	---
    SUM(CASE WHEN TRY_CAST(SUBSTRING(late_aircraft_delay, 0, LEN(late_aircraft_delay)) AS FLOAT) = FLOOR(TRY_CAST(SUBSTRING(late_aircraft_delay, 0, LEN(late_aircraft_delay)) AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS late_aircraft_delay_integers,
	SUM(CASE WHEN TRY_CAST(SUBSTRING(late_aircraft_delay, 0, LEN(late_aircraft_delay)) AS FLOAT) <> FLOOR(TRY_CAST(SUBSTRING(late_aircraft_delay, 0, LEN(late_aircraft_delay)) AS DECIMAL(38, 10))) THEN 1 ELSE 0 END) AS late_aircraft_delay_decimals
FROM bronze.AirlineDelayCausesData;

/*
The following data types should be used per column:
- arr_flights: INT.
- arr_del15: INT.
- carrier_ct = DECIMAL(38, 10).
- weather_Ct = DECIMAL(38, 10).
- nas_ct = DECIMAL(38, 10).
- security_ct = DECIMAL(38, 10).
- late_aircraft_ct = DECIMAL(38, 10).
- arr_canceled = INT.
- arr_diverted = INT.
- arr_delay = INT.
*/

-- Create the silver table.
/*
- The year and month are integers. Month can be a tinyint, while year can be a smallint.
- Carrier has a fixed length of 2 characters.
- Airport has a fixed length of 3 characters.
- arr_flights: INT.
- arr_del15: INT.
- carrier_ct = DECIMAL(38, 10).
- weather_Ct = DECIMAL(38, 10).
- nas_ct = DECIMAL(38, 10).
- security_ct = DECIMAL(38, 10).
- late_aircraft_ct = DECIMAL(38, 10).
- arr_canceled = INT.
- arr_diverted = INT.
- arr_delay = INT.
- The numeric columns (except year and month) for this table all expect nulls. Now, let's check if they're comprised of decimals or integers.


*/