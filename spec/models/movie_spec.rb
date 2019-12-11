require 'rails_helper'

describe Movie do
  let(:sample_json) do
    {
      "adult":false,
      "homepage":"https://movies.disney.com/frozen-2",
      "api_id":330457,
      "imdb_id":"tt4520988",
      "overview":"Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
      "popularity":405.917,
      "poster_path":"/qdfARIhgpgZOBh3vfNhWS4hmSo3.jpg",
      "release_date":"2019-11-20",
      "revenue":742060467,
      "status":"Released",
      "tagline":"",
      "title":"Frozen II",
      "vote_average":7.1,
      "vote_count":844
    }
  end

  it 'is valid' do
    movie = Movie.new(sample_json)

    expect(movie).to be_valid
  end
end
