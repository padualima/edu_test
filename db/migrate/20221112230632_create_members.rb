class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :cpf, limit: 11
      t.string :ide, limit: 10

      t.timestamps
    end

    add_index :members, [:id, :ide], unique: true
  end
end
