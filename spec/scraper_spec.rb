require_relative '../scraper'

describe "#find_movies_links" do
  it "should return an array of the top 5 movies" do
    expected = [
      "http://www.imdb.com/title/tt0111161/",
      "http://www.imdb.com/title/tt0068646/",
      "http://www.imdb.com/title/tt0071562/",
      "http://www.imdb.com/title/tt0468569/",
      "http://www.imdb.com/title/tt0050083/"
    ]

    result = find_movies_links
    expect(result).to eq(expected)
  end
end

describe "#scrape_movie" do
  it "should return the info from the movie url" do
    result = scrape_movie("http://www.imdb.com/title/tt0468569/")

    expected = {
      cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
      director: "Christopher Nolan",
      storyline: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      title: "The Dark Knight",
      year: 2008
    }
    expect(result).to eq(expected)
  end
end
