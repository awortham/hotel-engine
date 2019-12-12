require 'rails_helper'

describe Api::V1::MoviesController do
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

  describe '#index' do
    context 'when no search params' do
      let!(:movie) { Movie.create(title: 'Frozen') }
      it 'returns the movies currently in the db' do
        get :index

        expect(JSON.parse(response.body).length).to eq 1
      end
    end

    context 'when search params are passed' do
      # should look at search params and check the db for any searches that match
      context 'for the first time' do
        let!(:movie) { Movie.create(title: 'Frozen') }
        # if it matches then return the match results
        # add match results (a list of ids) to the searches table
        # this should save all incoming data as well as a search record with cooresponding ids and criteria string
        it 'calls RequestFromMovieApi' do
          allow_any_instance_of(RequestFromMovieApi).to receive(:search).and_return movie

          get :index, params: { query: 'frozen' }

          expect(response.body).to include 'Frozen'
        end
      end

      context 'when there is an existing/matching search' do
        let(:movie) { Movie.create(title: 'Frozen') }
        let!(:search) { Search.create(criteria: 'query=frozen', movies: [movie]) }

        it 'returns the movie' do
          get :index, params: { query: 'frozen' }

          expect(JSON.parse(response.body).length).to eq 1
        end
      end
    end

    context 'when the returning collection has an id of a movie that was deleted' do
      # make sure to account for an id in results record that has been destroyed
    end

    context 'when a query was malformed' do
      # make sure to handle a mis formed query and return an error to the user (don't blow up)
    end
  end

  describe '#show' do
    context 'when a movie exists in db' do
      let(:movie) { Movie.create(title: 'Frozen') }

      it 'returns the movie json' do
        get :show, params: { id: movie.id }, format: :json

        expect(response.status).to eq 200
        expect(response.body).to include 'Frozen'
      end
    end

    context 'when a movie does not exist in db' do
      context 'when the movie is found in the external api' do
        it 'fetches the movie based on id' do
          allow_any_instance_of(RequestFromMovieApi).to receive(:get_movie).and_return(Movie.new(sample_json))
          get :show, params: { id: 330457 }, format: :json

          expect(response.status).to eq 200
          expect(response.body).to include 'Frozen'
        end
      end
    end
  end

  describe '#create' do
    context 'when a movie exists by said title' do
      let!(:movie) { Movie.create(title: 'new movie') }

      it 'returns the existing movie' do
        expect { post :create, params: { movie: { title: 'new movie' } } }.to_not change { Movie.count }
      end
    end

    context 'when a movie does not exist by said title' do
      it 'creates it' do
        expect { post :create, params: { movie: { title: 'new movie' } } }.to change { Movie.count }.by 1
      end
    end
  end

  describe '#update' do
    context 'when movie exists' do
      let!(:movie) { Movie.create(title: 'existing movie') }

      it 'updates the movie' do
        expect { patch :update, params: { id: movie.id, movie: { title: 'new_title' } } }.to change { movie.reload.title }
      end
    end

    context 'when movie would be made invalid' do
      let!(:movie) { Movie.create(title: 'existing movie') }

      it 'returns a 422' do
        patch :update, params: { id: movie.id, movie: { title: '' } }

        expect(response.status).to eq 422
      end

    end

    context 'when movie does not exist' do
      it 'raises error' do
        expect { patch :update, params: { id: 0, movie: { title: 'new_title' } } }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe '#destroy' do
    let!(:movie) { Movie.create(title: 'existing movie') }

    context 'when movie exists' do
      it 'destroys the movie' do
        expect { delete :destroy, params: { id: movie.id } }.to change { Movie.count }
      end
    end

    context 'when movie does not exist' do
      it 'raises an error' do
        expect { delete :destroy, params: { id: 0 } }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
