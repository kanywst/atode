class AddOgImageToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :og_image, :string
  end
end
