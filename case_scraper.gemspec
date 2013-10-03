# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'case_scraper'
  s.version     = '0.0.4'
  s.date		= '2013-10-03'
  s.summary     = "Scrape case citations - volume, reporter, and starting page number - from legal briefs that are in rtf format."
  s.description = "Scrape case citations - volume, reporter, and starting page number - from legal briefs that are in rtf format."
  s.authors     = ["Greg Kochansky"]
  s.email       = 'greg@greg-k.com'
  s.homepage    = 'http://github.com/gkochans/case_scraper'
  s.files       = ["lib/case_scraper.rb"]
  s.license		= "MIT"
  s.add_dependency('yomu')
end