class Api::V1::MoviesController < ApplicationController
  before_action :find_movie, only: [:update, :destroy]

  def index
    if params[:query]
      set_movies_with_query_params
    else
      @movies = Movie.all
    end

    render json: sorted_movies
  end

  def show
    @movie = Movie.find_by(params[:id]) || RequestFromMovieApi.new(params).get_movie
    render json: @movie
  end

  def create
    @movie = Movie.find_or_initialize_by(title: movie_params[:title])
    @movie.assign_attributes(movie_params)
    if @movie.save
      render json: @movie, status: :created, location: api_v1_movie_url(@movie)
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
  end

  private

  def find_movie
    @movie = Movie.find(params[:id])
  end

  def set_movies_with_query_params
    if search = Search.find_by(criteria: request.query_string)
      @movies = search.movies
    else
      @movies = RequestFromMovieApi.new(params).search
    end
  end

  def sorted_movies
    @movies.order(title: params[:sort])
  rescue ArgumentError
    @movies
  end

  def movie_params
    params.require(:movie).permit(
      :adult,
      :homepage,
      :api_id,
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
    )
  end
end
