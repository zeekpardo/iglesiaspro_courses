class RemoveImageFileFromCourses < ActiveRecord::Migration[7.1]
  def change
    remove_column :courses, :image_file, :string
  end
end
