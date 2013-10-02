# Scraping case citations from legal briefs in RTF format.

This simple Ruby script relies on the [Yomu](https://github.com/Erol/yomu) library, which extracts the body text from various document formats. It does not extract the complete citation, only the volume number, reporter abbreviation, and starting page number. The idea is to copy and paste that list into a service like Westlaw's "Find & Print" to retrieve all the cases. Auto-generating the list saves a considerable amount of time compared to copying cites manually, one by one.

For whatever reason, I have had success extracting text from *.RTF files, but not from *.DOC or *.DOCX files. The header/metadata information extracts properly from files in the latter two formats, but not the body text.

# Installation And Dependencies

```
gem install case_scraper
```

[Yomu](https://github.com/Erol/yomu) is required by the *.gemspec file for `case_scraper`, so it should be installed automatically. However, you will need to install [jruby with JRE](http://jruby.org/download) manually.

# Usage

```
case_scraper [input.rtf] [output.txt]
```

Follow the prompts. The script will launch the output file in your default text editor.

The citation list, one per line, is in the appropriate format for cutting and pasting directly into Westlaw's "Find & Print" feature. (The maximum number of lines for a single Find & Print query is 99.)

# Disclaimer

This is an experimental script. Use at your own risk and please be sure to check the output against the list of cases in the original brief to ensure you have a complete list.

THIS SCRIPT ONLY FOCUSES ON REPORTED U.S. STATE AND FEDERAL CASELAW AND UNREPORTED U.S. STATE AND FEDERAL CASELAW FOR WHICH A LEXIS OR WESTLAW CITATION IS AVAILABLE. IT IS NOT DESIGNED TO DETECT CITATIONS TO CASELAW FROM ANY OTHER JURISDICTION.

THIS SCRIPT ONLY EXTRACTS CASE CITATIONS, NOT CITATIONS FOR STATUTES OR OTHER AUTHORITIES.