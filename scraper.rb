require 'open-uri'
require 'nokogiri'
require 'yaml'

def find_movies_links
  movies = []
  html_content = open("http://www.imdb.com/chart/top").read
  html_doc = Nokogiri::HTML(html_content)
  html_doc.search('.titleColumn a').first(5).each do |tag|
    href = tag.attribute('href').value
    movies << "http://www.imdb.com#{href}"
  end
  movies
end

  # {
  #   cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
  #   director: "Christopher Nolan",
  #   storyline: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham. The Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
  #   title: "The Dark Knight",
  #   year: 2008
  # }

def scrape_movie(url)
  html_content = open(url, "Accept-Language" => "en").read
  html_doc = Nokogiri::HTML(html_content)
  all_cast = []
  html_doc.search(".credit_summary_item:contains('Stars:') a").first(3).each do |tag|
    all_cast << tag.text.strip  
  end 
  {
    cast: all_cast,
    title: html_doc.search(".title_wrapper h1").text.scan(/[A-Za-z]+/).join(" "),
    year: html_doc.search('#titleYear a').text.strip.to_i, 
    director: html_doc.search(".credit_summary_item:contains('Director:') a").text.strip,
    storyline: html_doc.search(".summary_text").text.strip
  }
end


def write_yaml
  url = "http://www.imdb.com/title/tt0468569/"
  movie = scrape_movie(url)
  File.open('movie.yml', 'wb') do |file|
    file.write(movie.to_yaml)
  end
end