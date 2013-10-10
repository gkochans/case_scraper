# case_scraper
#
# This script uses the Yomu library 
# to extract the text from a legal
# brief that is in RTF format. The
# script then applies regular
# expressions to search the text of
# the document for case citations.

# You have the option of extracting
# only the volume, reporter, and starting
# page number for each case, or extracting
# the entire citation (though this is
# imperfect) along with the organizational
# headings from the brief, with the case
# citations each placed under the
# appropriate section or subsection. The
# case citations and heading text are
# then output to a text file, with one
# citation or heading per line.
#
# This is an experimental script. Use 
# at your own risk and please be sure 
# to check the output against the 
# list of cases in the original brief 
# to ensure you have a complete list.
#
# THIS SCRIPT ONLY FOCUSES ON 
# REPORTED U.S. STATE AND FEDERAL 
# CASELAW AND UNREPORTED U.S. STATE 
# AND FEDERAL CASELAW FOR WHICH A 
# LEXIS OR WESTLAW CITATION IS 
# AVAILABLE. IT IS NOT DESIGNED TO 
# DETECT CITATIONS TO CASELAW FROM 
# ANY OTHER JURISDICTION.
#
# THIS SCRIPT ONLY EXTRACTS CASE 
# CITATIONS, NOT CITATIONS FOR 
# STATUTES OR OTHER AUTHORITIES.
#
# Author: Greg Kochansky
# E-mail: greg@greg-k.com
# Website: www.greg-k.com
# License: MIT

# Require the external Yomu library.

require 'yomu'
require 'optparse'

# Define options for toggling citation
# type and inclusion of headings in the
# brief.

options = {}

optparse = OptionParser.new do|opts|
   # Help banner.
   opts.banner = "Usage: case_scraper.rb [options] InputFile.rtf OutputFile.txt ..."
 
   # Define options.
   options[:fullcite] = false
   opts.on( '-f', '--full', 'Scrape complete case citations with headings.' ) do
     options[:fullcite] = true
   end
 
   opts.on( '-h', '--help', 'Display help.' ) do
     puts opts
     exit
   end
 end
 
# Parse the command-line and remove options from ARGV array.
optparse.parse!

# Test that input and output files 
# are specified.

unless ARGV.length == 2
  puts "You must include an input filename (RTF format) and an output filename (TXT format)."
  puts "Usage: ruby case_scraper.rb InputFile.rtf OutputFile.txt\n"
  exit
end

if options[:fullcite]

# Regexp for scraping the entire case citation

  citationregex = "(((([a-z]{3}(\\.|\\?|!)\"?)|see also|see|accord)\\s)|^[A-Z][a-z]*\\s([Vv][\\.]*\\s))[A-Z].{1,125}(\\,|\\s(\\[\\d{4,4}\\])|\\s\\(\\d{4,4}\\)|\\s)\\s\\d{1,4}\\s[A-Za-z0-9\\.\\s]{3,17}\\d{1,8}(\\s?|\\,|\\.)((\\(|\\[)([A-Za-z0-9\\.\\,\\s]{1,20})*\\d{4,4}(\\]|\\))*)*|^\\s*[A-Za-z0-9]{1,4}\\.\\s.{1,150}$"
else

  # Regexp for scraping the just the volume,
  # reporter, and first page number.

  citationregex = "\\d{1,4}\\s\[^\\[\\(]{1,16}\\s\\d{1,7}"
end

# Regexp for scraping the brief headings.

# Set the two command line arguments 
# as variables.

input = ARGV[0]
output = ARGV[1]

# Import body text from the input RTF 
# file.

data = File.read input
text = Yomu.read :text, data

# Test whether output file already 
# exists.
#
# If so, then warn before overwriting.
#
# If not, then create the output file.

if File.exist?(output)
  puts "WARNING: #{output} already exists. It will be overwritten."
  puts "Press CTRL-C to cancel, or press RETURN to proceed."
  print "[CRTL-C or RETURN?]"
  STDIN.gets

  puts "Opening #{output}."
  target = File.open(output, 'w')
  puts "Erasing contents of #{output}."
  target.truncate(target.size)
else
  puts "Creating #{output}."
  target = File.open(output, 'w')
end
  
# Using regular expressions, extract 
# the citations and headings, per
# the specified options.
# The regular expressions should
# catch common variations, including 
# spacing or lack of spacing in the 
# reporter abbreviation, 
# state-specific citation formats for 
# New York and California, and
# WestLaw and LEXIS citations for 
# unpublished rulings. As you may see
# if you run the example file, the script
# is imperfect and may over-select when
# dealing with short sentences or
# certain citations at the beginning
# of a new line.

puts "Scraping case citations from #{input}."

# Alternative processing procedures
# depending on whether the script is
# extracting full or partial citations.
# Slightly more processing is required
# for full citations because the regexp
# has a lot of nested captures and the
# resulting array is more complex.

if options[:fullcite]
	allcapture_array = text.scan(/(#{citationregex})/)

	fullcase_array = allcapture_array.transpose

	fullcases_only_array = fullcase_array.first

	fullcases_only_array.flatten

	fullcases_only_array.each do |a|
	  a.gsub!(/^[a-z]{3,3}\."?\s/, "")
	end

	fullcases_only_array.reject! { |c| c.empty? }
	
	puts "Writing case citations to #{output}."
		
	File.open(target, "w+") do |f|
	  f.puts(fullcases_only_array)
	end

else
	allcapture_array = text.scan(/(#{citationregex})/)
	fullcase_array = allcapture_array.transpose

	fullcases_only_array = fullcase_array.first

	fullcases_only_array.reject! { |c| c.empty? }

	
	fullcases_only_array.flatten
		File.open(target, "w+") do |f|
	  f.puts(fullcases_only_array)
	end
end

puts "Writing case citations to #{output}."

# Close the output file after writing.

target.close()

# Open the output file in the user's 
# default text editor.
#
# If the chosen output is a bare,
# partial citation list, then the
# output, with one citation per line, 
# is in the appropriate format for 
# cutting and pasting directly into 
# Westlaw "Find & Print." (The 
# maximum number of lines for a 
# single query is 99.)
#
# For full citations with headings, 
# the output should save you time in
# structuring your opposition / reply
# brief.

%x{ call #{output} }

Process.exit()