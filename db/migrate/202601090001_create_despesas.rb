class CreateDespesas < ActiveRecord::Migration[8.0]
  def change
    create_table :despesas do |t|
      t.decimal :valor, precision: 12, scale: 2, null: false
      t.date :data, null: false
      t.string :categoria
      t.string :descricao

      t.timestamps
    end
  end
end
