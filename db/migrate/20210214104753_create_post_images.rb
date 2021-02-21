class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.integer :post_id
      t.string :image_id
      t.index ["post_id"], name: "index_post_images_on_post_id"
      t.timestamps
    end
  end
end
