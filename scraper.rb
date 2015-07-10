require 'open-uri'
require 'nokogiri'
require 'csv'

# Store URL to be scraped
url = "https://www.airbnb.ca/s/Cartagena-~-Bolivar--Colombia"

# Parse the page with nokogiri
page = Nokogiri::HTML(open(url))

# store page numbers in an array variable, convert all to integers first
page_numbers = []
page.css("div.pagination ul li a[target]").each do |element|
  page_numbers << element.text.to_i
end

max_page = page_numbers.max

# Initialize empty arrays
  name = []
  price = []
  details = []

# Loop once for every page of search results
max_page.times do |n|

  url = "https://www.airbnb.ca/s/Cartagena-~-Bolivar--Colombia?page=#{n+1}"
  page = Nokogiri::HTML(open(url))


  page.css('h3.h5.listing-name.text-truncate').each do |element|
    name << element.text.strip
  end

  page.css('span.h3.price-amount').each do |cost|
    price << cost.text
  end

  page.css('div.text-muted.listing-location.text-truncate').each do |detail|
    details << detail.text.gsub(/\s/, ' ').squeeze(' ').strip.split(/ · /)
  end

  details.length.times do |n|
    if details[n][1]
      details[n][1] = details[n][1].gsub(/· /, '').strip
    else
      details[n] << "No reviews"
    end
  end

end


# Write data to csv file
CSV.open("airbnb_listing.csv", "w") do |file|
  file << ["Listing Name", "Price", "Room", "Reviews"]

  name.length.times do |i|
    file << [name[i], price[i], details[i][0], details[i][1]]
  end
end 
