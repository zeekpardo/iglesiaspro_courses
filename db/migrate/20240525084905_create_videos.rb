class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.string :youtube_id
      t.string :call_to_action
      t.string :resource
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
