class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.integer :list_id
      t.integer :product_id

      t.timestamps
    end
  end
end
