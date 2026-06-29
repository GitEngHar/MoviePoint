class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :id
      t.string :name
      t.integer :age

      t.timestamps
    end
  end
end
