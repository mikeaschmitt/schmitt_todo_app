class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.string :author
      t.string :description
    end
    
    create_table :comments do |t|
      t.belongs_to :video, index: true
      t.string :author
      t.string :body
    end
  end
end
