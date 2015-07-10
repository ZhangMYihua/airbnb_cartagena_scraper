require 'open-uri'
require 'nokogiri'
require 'csv'

# Store URL to be scraped
url = "https://www.airbnb.ca/s/Cartagena-~-Bolivar--Colombia"

# Parse the page with nokogiri
page = Nokogiri::HTML(open(url))

# Store data in arrays
name = []
price = []
details = []

page.css('h3.h5.listing-name.text-truncate').each do |element|
  name << element.text.strip
end

page.css('span.h3.price-amount').each do |cost|
  price << cost.text
end

page.css('div.text-muted.listing-location.text-truncate').each do |detail|
  details << detail.text.strip
end

# Write data to csv file
CSV.open("airbnb_listing.csv", "w") do |file|
  file << ["Listing Name", "Price", "Details"]

  name.length.times do |i|
    file << [name[i], price[i], details[i]]
  end
end 

puts page.css('div.text-muted.listing-location.text-truncate')