class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :twitter_token
      t.string :twitter_secret

      t.timestamps
    end
  end
end
