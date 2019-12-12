class CreateMovieSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_searches do |t|
      t.integer :search_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
