# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.decimal :amount
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
