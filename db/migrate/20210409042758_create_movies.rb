class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :url
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
