# The given source file(mappingbased_properties_en.nq) contains input of the form <filed1> <field2> ""<field3> .
# Following is a sample tuple from original input data
# <http://dbpedia.org/resource/United_States_at_the_2004_Summer_Olympics> <http://dbpedia.org/ontology/rankInFinalMedalCount> "1"^^<http://www.w3.org/2001/XMLSchema#positiveInteger> <http://en.wikipedia.org/wiki/United_States_at_the_2004_Summer_Olympics?oldid=490274824#absolute-line=10> .
# Since this tuple is difficult to parse in pig, the preprocessing is done in this file. The above tuple will be 
# converted to the form <country>,<year>,<event>,<category>,<rank>
# After preprocessing the above tuple will be United States,2004,Summer_Olympics,rankInFinalMedalCount,1

# NOTE: The reason why we are performing preprocessing here is the join key used for the assignment is country
# and when performing equi-joins the country format should match with second input data set. This preprocessing
# makes sure that the country key conforms to the format of second data set.

# USAGE:
# cat mappingbased_properties_en.nq | ruby etl.rb > output_file
# since this program reads from console and writes back to console, this particular program should take only constant
# memory irrespective of the data size. 

# read the input from input file or console
ARGF.each_line do |line|
	# we expect the first character to begin with <
	next if line[0] != '<'
	output = []
	line.split("> ").slice(0..2).each_with_index do |word, idx|
		if(idx == 0)
			val = word[(word.rindex("/")+1)..-1]
			validx = val.index("_at_the_")
			next if validx == nil
			# The join is country and so matching the format of country to match with countries_gdp_2000.csv file
			country = val[0..validx-1].gsub('_', ' ')
			# extract numbers
			year = word.scan(/\d+/).join
			event = val.split("_").slice(-2,2)
			event = event.join("_")
			output.push(country)
			output.push(year)
			output.push(event)
		elsif(idx==1)
			category = word[(word.rindex("/")+1)..-1].to_s unless idx==2
			output.push(category)
		else
			rank = word.scan(/"([^"]*)"/).flatten.join unless idx!=2
			output.push(rank)
		end
	end
	# though pig handles null values, it is easier to reject nulls or emptry string while preprocessing
	output = output.reject { |e| e == nil || e.empty? || e == ""}
	next if output.size != 5

	# write the output to console
	puts output.join(",") 
end