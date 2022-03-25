class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :Post do |t|
      t.references :User, null: false, foreign_key: true, index: true
      t.string :Title
      t.text :Text
      t.timestamps
      t.integer :CommentsCounter, default: 0, null: false
      t.integer :LikesCounter, default: 0, null: false
    end
  end
end
