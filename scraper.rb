require 'open-uri'
require 'nokogiri'
require 'csv'

# Store URL to be scraped
url = "https://www.airbnb.ca/s/Cartagena-~-Bolivar--Colombia"

#parse the page with nokogiri
page = Nokogiri::HTML(open(url))

# store data in arrays
name = []
price = []

page.css('h3.h5.listing-name.text-truncate').each do |element|
  name << element.text
end

page.css('span.h3.price-amount').each do |cost|
  price << cost.text
end

