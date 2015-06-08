class CreateCheers < ActiveRecord::Migration
  def change
    create_table :cheers do |t|

      t.timestamps null: false
    end
  end
end
