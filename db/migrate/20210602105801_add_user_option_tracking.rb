# frozen_string_literal: true

# adding migration to keep track of selected options
class AddUserOptionTracking < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :selected_options, :text, array: true, default: []
  end
end
