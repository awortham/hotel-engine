class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.boolean :adult, null: false, default: false
      t.string :poster_path
      t.string :homepage
      t.integer :api_id
      t.integer :imdb_id
      t.string :title
      t.text :overview
      t.integer :popularity
      t.datetime :release_date
      t.integer :revenue
      t.string :status
      t.string :tagline
      t.integer :vote_average
      t.integer :vote_count

      t.timestamps
    end
  end
end
