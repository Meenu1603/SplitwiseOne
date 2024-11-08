# frozen_string_literal: true

class CreateExpenseSplits < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_splits do |t|
      t.references :user, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
