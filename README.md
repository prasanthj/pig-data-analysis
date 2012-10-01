Data analysis using Apache Pig 
==============================
The code available in this repository are developed as a part of large scale data analysis course. 

**PREPROCESSING**

The input wikipedia data from dbpedia website is not properly formatted. There is no proper delimiter or identifiable data types.
To perform preprocessing etl.rb script is implemented. The script accepts input from STDIN and writes output to STDOUT.
Since this script processing each lines from the STDIN and writes to STDOUT, the runtime memory of this program is constant irrespective of the datasize. More information can be found in etl.rb file
Usage of this script:
cat mappingbased_properties_en.nq | ruby etl.rb > cleaned_data

This cleaned data should be copied to HDFS path ("/pig/data"). If using in local mode or Amazon S3 then appropriate path should be specified in lab2.pig load statements.

**ADDITIONAL INFO**

In addition to the provided dataset countries_gdp_2000.csv file is used for comparing the sporting event with GDP of the country. This source is obtained from http://goo.gl/YjBLF and preprocessed using Microsoft Excel. The preprocessed output is saved in this folder for reference. The countries_gdp_2000 file should also be imported to HDFS.

**RESULTS**

The idea behind the program (lab2.pig) is to find if there is any correlation between a countries performance in Summer Olympics vs the Countries GDP. The actual output of the program after exection is 


(United States,2000,Summer_Olympics,rankInFinalMedalCount,1,United States,8019378)
(France,2000,Summer_Olympics,rankInFinalMedalCount,6,France,1263467)
(Italy,2000,Summer_Olympics,rankInFinalMedalCount,7,Italy,1084305)

It can be seen from the results that the output olympics rank is correlated to gdp of the country.
Higher the GDP of a country, better the infrastructure for all sports and better the results in olympics.

NOTE: Please refer program for more description about the execution of the program.


