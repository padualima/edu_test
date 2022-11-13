class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :document, limit: 14

      t.timestamps
    end
  end
end
