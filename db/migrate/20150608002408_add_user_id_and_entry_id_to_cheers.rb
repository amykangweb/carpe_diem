class AddUserIdAndEntryIdToCheers < ActiveRecord::Migration
  def change
    add_reference :cheers, :user, index: true
    add_reference :cheers, :entry, index: true
  end
end
