class AddSlugToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :slug, :string
  end
end
