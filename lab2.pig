-- loading preprocessed wikipedia data. Refer etl.rb file more information about preprocessing
-- the input file is expected to be in HDFS at the specified path
olympics_data = LOAD '/pig/data/cleaned_data' USING PigStorage(',') AS (country:chararray,year:int,event:chararray,category:chararray,total:int);

-- this is the gdp data collected from http://goo.gl/YjBLF (extracted year 2000 world countries gdp)
gdp_data = LOAD '/pig/data/countries_gdp_2000.csv' USING PigStorage(',') AS (country:chararray, gdp:long);

-- we will filter year 2000 and will compare fina medal count category of different countries
olympics_2000_rank = FILTER olympics_data BY year==2000 AND category == 'rankInFinalMedalCount';

-- performing join using country name as join key
olympics_and_gdp = JOIN olympics_2000_rank BY country, gdp_data BY country;

-- sort it based on GDP
gdp_ordered = ORDER olympics_and_gdp BY gdp DESC;

-- we will compare top 3 results
top_3_results = LIMIT gdp_ordered 3;

dump top_3_results;