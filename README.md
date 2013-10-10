# Scraping case citations from legal briefs in RTF format.

This simple Ruby script relies on the [Yomu](https://github.com/Erol/yomu) library, which extracts the body text from various document formats. With Version 0.1.0, the script now extract either the full citations, organized under the brief's section headings and sub-headings, or only the volume number, reporter abbreviation, and starting page number.

The "full citation with headings" approach allows you to automate the tedious first step in structuring an opposition or reply brief. You can use the output text as a starting point to structure your own argument and make sure that you are addressing the cases cited by your opponent.

The "volume, reporter, first page only" option gives you a list of citations that you can copy and paste into a service like Westlaw's "Find & Print" and retrieve all the cases in a single batch. Auto-generating the list saves a considerable amount of time compared to copying cites manually, one by one.

For whatever reason, I have had success with Yomu extracting text from *.RTF files, but not from *.DOC or *.DOCX files. The header/metadata information extracts properly from files in the latter two formats, but not the body text. Although it isn't difficult to convert a Word file to RTF, it would be nice to eliminate this extra step. It is on the list of feature enhancements.

I have included `test.rtf`, which contains a list of citations to a variety of federal and state reporters, to demonstrate how the script works. As the file notes, these case citations were taken from the Wikipedia entry for "case citation". They reflect a relatively wide variety of citation styles. However, there are no doubt additional variations that the script may not parse properly. Constructing a regular expression that captures every possible case citation variation is a known (and, possibly, unsolvable) problem. Any suggestions on improving the regular expressions used in this script are more than welcome. Please fork / pull request away.

# Installation And Dependencies

```
gem install case_scraper
```

[Yomu](https://github.com/Erol/yomu) is required by the *.gemspec file for `case_scraper`, so it should be installed automatically. However, you will need to install [jruby with JRE](http://jruby.org/download) manually.

# Usage

```
case_scraper.rb [option "-f" toggles on full case citations with headers] [input.rtf] [output.txt]
```

Follow the prompts. The script will launch the output file in your default text editor.

# Disclaimer

This is an experimental script. Use at your own risk and please be sure to check the output against the list of cases in the original brief to ensure you have a complete list.

THIS SCRIPT ONLY FOCUSES ON REPORTED U.S. STATE AND FEDERAL CASELAW AND UNREPORTED U.S. STATE AND FEDERAL CASELAW FOR WHICH A LEXIS OR WESTLAW CITATION IS AVAILABLE. IT IS NOT DESIGNED TO DETECT CITATIONS TO CASELAW FROM ANY OTHER JURISDICTION.

THIS SCRIPT ONLY EXTRACTS CASE CITATIONS, NOT CITATIONS FOR STATUTES OR OTHER AUTHORITIES.

# To-Do List

- Figure out how to get Yomu to read in the text from Word files.

- Identify case citations that the script does not parse, or parses improperly, and fix the regular expressions to address those variations.

- Parse citations to statutes and secondary authorities.