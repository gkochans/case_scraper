# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'case_scraper'
  s.version     = '0.0.3'
  s.date		= '2013-10-02'
  s.summary     = "Scrape case citations from legal briefs in rtf format."
  s.description = "Scrape case citations from legal briefs in rtf format using the Yomu text extraction library."
  s.authors     = ["Greg Kochansky"]
  s.email       = 'greg@greg-k.com'
  s.homepage    = 'http://github.com/gkochans/case_scraper'
  s.files       = ["lib/case_scraper.rb"]
  s.license		= "MIT"
  s.add_dependency('yomu')
end