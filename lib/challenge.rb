require "time"

class Challenge
  attr_reader :earliest_time
  attr_reader :latest_time
  attr_reader :peak_year

  def initialize(file_path)
    @file_path = File.expand_path(file_path)
  end

  def parse
    
    earliest_time = Time.now.to_i 
    latest_time = 0
    peak_year = {}

    File.open(@file_path, "r") do |file| 
        # For loop going through each line in file 
        for line in file.readlines()

            # earliest_time: the earliest time contained within the data set
            if Time.xmlschema(line).to_i < earliest_time
                earliest_time = Time.xmlschema(line).to_i
            end

            # latest_time: the latest time contained within the data set
            if Time.xmlschema(line).to_i > latest_time
                latest_time = Time.xmlschema(line).to_i
            end

            # peak_year: the year with the most number of timestamps contained within the data set
            if peak_year.key?(Time.xmlschema(line).year) == true 
                peak_year[Time.xmlschema(line).year] += 1
            else
                peak_year[Time.xmlschema(line).year] = 1
            end 
        end
    end
    
    @latest_time = Time.at(latest_time)
    @earliest_time = Time.at(earliest_time)
    @peak_year = peak_year.key(peak_year.values.max)
  end
end

