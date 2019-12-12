class RequestFromMovieApi
  attr_reader :id, :query, :page

  MOVIE_ATTRS = [
    :adult,
    :api_id,
    :homepage,
    :imdb_id,
    :overview,
    :popularity,
    :poster_path,
    :release_date,
    :revenue,
    :status,
    :tagline,
    :title,
    :vote_average,
    :vote_count
  ]

  def initialize(params)
    @id    = params[:id].to_s
    @query = params[:query]
    @page  = params[:page]
  end

  def get_movie
    movie_data = request(movie_url)
    create_movie(movie_data)
  end

  def search
    data = request(search_url, search_params)

    data[:results].map do |movie_data|
      create_movie(movie_data)
    end
  end

  private

  def api_key
    HotelEngine::Application.credentials.movie_api_key
  end

  def create_movie(movie_data)
    movie_data[:api_id] = movie_data[:id]
    movie_data.slice!(*MOVIE_ATTRS)
    Movie.find_or_create_by(movie_data)
  end

  def movie_url
    "#{url_base}/movie/#{id}"
  end

  def request(url, params = request_params)
    response = Faraday.get(url, params)

    JSON.parse(response.body).deep_symbolize_keys

  rescue JSON::ParserError
    params == request_params ? {} : { results: [] }
  end

  def request_params
    @request_params ||= { api_key: api_key }
  end

  def search_params
    request_params.merge({ query: query, page: page })
  end

  def search_url
    "#{url_base}/search/movie"
  end

  def url_base
    "https://api.themoviedb.org/3"
  end
end
