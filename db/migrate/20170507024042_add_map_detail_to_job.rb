class AddMapDetailToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :cp_lng, :string
    add_column :jobs, :cp_lat, :string
  end
end
