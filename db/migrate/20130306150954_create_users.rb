class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_handle
      t.text :tweet
      t.string :access_token
      t.string :access_token_secret
    end 
  end
end
