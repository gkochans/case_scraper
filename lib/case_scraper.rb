# case_scraper
#
# This script uses the Yomu library 
# to extract the text from a legal
# brief in RTF format. It then uses
# regular expressions to search the
# document for case citations and
# extract the volume, reporter, and
# starting page for each case. The case
# citations are then output to a text
# file, with one citation per line.
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

# Test that input and output files 
# are specified.

unless ARGV.length == 2
  puts "You must include an input filename (RTF format) and an output filename (TXT format)."
  puts "Usage: ruby MyScript.rb InputFile.rtf OutputFile.txt\n"
  exit
end

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
# the case volume, the reporter 
# abbreviation, and the starting page 
# number for (hopefully . . . ) each 
# full case citation in the brief.
#
# The regular expressions should
# catch common variations, including 
# spacing or lack of spacing in the 
# reporter abbreviation, 
# state-specific citation formats for 
# New York and California, and
# Westlaw and LEXIS citations for 
# unpublished rulings.

puts "Scraping case citations from #{input}."
text.scan(/\d+\s\i*\w+\.+\s*\w*\.*\s*\w*\.*\s*\w*\.*\s\d+/) { |w| target.write "#{w}\n" }

puts "Writing case citations to #{output}."

# Close the output file after writing.

target.close()

# Open the output file in the user's 
# default text editor.
#
# The citation list, one per line, is 
# in the appropriate format for 
# cutting and pasting directly into 
# Westlaw "Find & Print." (The 
# maximum number of lines for a 
# single query is 99.)

%x{ call #{output} }

Process.exit()