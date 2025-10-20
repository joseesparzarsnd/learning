/* 
Create tables and bulk insert the data into them. 
** Note: This data is from 2023.
*/

-- Drop schema and tables in case they already exist.
DROP TABLE IF EXISTS [USA_gov_data].[bronze].[EnergyConsumptionData];
DROP TABLE IF EXISTS [USA_gov_data].[bronze].[AirlineDelayCausesData];
DROP TABLE IF EXISTS [USA_gov_data].[bronze].[PopulationEstimatesData];

DROP SCHEMA IF EXISTS [bronze];

-- Create new bronze schema with its respective tables.
GO
CREATE SCHEMA [bronze]
	CREATE TABLE [EnergyConsumptionData] (
		period VARCHAR(255) NULL,
		seriesId VARCHAR(255) NULL,
		seriesDescription VARCHAR(255) NULL,
		stateId VARCHAR(255) NULL,
		stateDescription VARCHAR(255) NULL,
		value VARCHAR(255) NULL,
		unit VARCHAR(255) NULL
	)
	CREATE TABLE [AirlineDelayCausesData] (
		year VARCHAR(255) NULL,
		month VARCHAR(255) NULL,
		carrier VARCHAR(255) NULL,
		carrier_name VARCHAR(255) NULL,
		airport VARCHAR(255) NULL,
		airport_name VARCHAR(255) NULL,
		arr_flights VARCHAR(255) NULL,
		arr_del15 VARCHAR(255) NULL,
		carrier_ct VARCHAR(255) NULL,
		weather_ct VARCHAR(255) NULL,
		nas_ct VARCHAR(255) NULL,
		security_ct VARCHAR(255) NULL,
		late_aircraft_ct VARCHAR(255) NULL,
		arr_canceled VARCHAR(255) NULL,
		arr_diverted VARCHAR(255) NULL,
		arr_delay VARCHAR(255) NULL,
		carrier_delay VARCHAR(255) NULL,
		weather_delay VARCHAR(255) NULL,
		nas_delay VARCHAR(255) NULL,
		security_delay VARCHAR(255) NULL,
		late_aircraft_delay VARCHAR(255) NULL
	)
	CREATE TABLE [PopulationEstimatesData] (
		[Geographic Area Name (NAME)] VARCHAR(255) NULL,
		[Vintage Month Description (MONTH_DESC)] VARCHAR(255) NULL,
		[Vintage Year (YEAR)] VARCHAR(255) NULL,
		[Age Group (AGE_DESC)] VARCHAR(255) NULL,
		[Universe Description (UNIVERSE_DESC)] VARCHAR(255) NULL,
		[Sex (SEX_DESC)] VARCHAR(255) NULL,
		[Population Estimate (POP)] VARCHAR(255) NULL
	);
GO

-- Bulk insert energy consumption data.
BULK INSERT
	[USA_gov_data].[bronze].[EnergyConsumptionData]
FROM 
	'C:\Users\D&C\Documents\learning\Python\data engineering\US gov data pipeline exercise\data\SEDS_Data.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDQUOTE = '"',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a'
);

-- Bulk insert airline delay data.
BULK INSERT
	[USA_gov_data].[bronze].[AirlineDelayCausesData]
FROM 
	'C:\Users\D&C\Documents\learning\Python\data engineering\US gov data pipeline exercise\data\Airline_Delay_Cause.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDQUOTE = '"',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	KEEPNULLS
);

-- Bulk insert the population data into the temporary table.
BULK INSERT
	[USA_gov_data].[bronze].[PopulationEstimatesData]
FROM
	'C:\Users\D&C\Documents\learning\Python\data engineering\US gov data pipeline exercise\data\Population_Estimates.csv'
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDQUOTE = '"',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0d0a',
	KEEPNULLS
);