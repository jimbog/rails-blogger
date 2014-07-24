class AddDefaultToPublished < ActiveRecord::Migration
  def change
    change_column_default :posts, :published, false
  end
end
