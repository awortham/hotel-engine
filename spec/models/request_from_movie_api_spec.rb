require 'rails_helper'

describe RequestFromMovieApi do
  subject { described_class.new(params) }
  let(:params) { {} }

  context '#get_move' do
    let(:params) { { id: 330457 } }

    it 'gets data' do
      stub_request(:get, "https://api.themoviedb.org/3/movie/330457?api_key=#{HotelEngine::Application.credentials.movie_api_key}").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
           }).
           to_return(status: 200, body: movie.to_json, headers: {})
      expect { subject.get_movie }.to change { Movie.count }.by 1
    end
  end

  context '#search' do
    let(:params) { { query: 'frozen', page: '1' } }

    it 'gets data' do
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{HotelEngine::Application.credentials.movie_api_key}&page=1&query=frozen").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
           }).
           to_return(status: 200, body: movie_collection.to_json, headers: {})
      expect { subject.search }.to change { Movie.count }.by 1
    end
  end

  private

  def movie
    {
      "adult"=>false,
      "backdrop_path"=>"/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
      "belongs_to_collection"=>{
        "id"=>386382,
        "name"=>"Frozen Collection",
        "poster_path"=>"/rpoXnE9UzCbjmINhxIi8bZF557B.jpg",
        "backdrop_path"=>"/vZiqhw6oFoMlHSneIdVip9rRou2.jpg"
      },
      "budget"=>0,
      "genres"=>[{
        "id"=>16,
        "name"=>"Animation"
      },
      {
        "id"=>10751,
        "name"=>"Family"
      },
      {"id"=>10402,
       "name"=>"Music"
      }],
      "homepage"=>"https://movies.disney.com/frozen-2",
      "id"=>330457,
      "imdb_id"=>"tt4520988",
      "original_language"=>"en",
      "original_title"=>"Frozen II",
      "overview"=>"Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
      "popularity"=>278.444,
      "poster_path"=>"/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg",
      "production_companies"=>[{
        "id"=>6125,
        "logo_path"=>"/tVPmo07IHhBs4HuilrcV0yujsZ9.png",
        "name"=>"Walt Disney Animation Studios",
        "origin_country"=>"US"
      }, {
        "id"=>2,
        "logo_path"=>"/wdrCwmRnLFJhEoH8GSfymY85KHT.png",
        "name"=>"Walt Disney Pictures",
        "origin_country"=>"US"
      }],
      "production_countries"=>[{
        "iso_3166_1"=>"US",
        "name"=>"United States of America"
      }],
      "release_date"=>"2019-11-20",
      "revenue"=>742060467,
      "runtime"=>104,
      "spoken_languages"=>[{
        "iso_639_1"=>"en",
        "name"=>"English"
      }],
      "status"=>"Released",
      "tagline"=>"",
      "title"=>"Frozen II",
      "video"=>false,
      "vote_average"=>7.0,
      "vote_count"=>907
    }
  end

  def movie_collection
    {"results"=>[movie]}
  end
end
