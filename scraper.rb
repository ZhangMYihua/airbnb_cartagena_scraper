require 'open-uri'
require 'nokogiri'
require 'csv'

# Store URL to be scraped
url = "https://www.airbnb.ca/s/Cartagena-~-Bolivar--Colombia"

#parse the page with nokogiri
page = Nokogiri::HTML(open(url))

