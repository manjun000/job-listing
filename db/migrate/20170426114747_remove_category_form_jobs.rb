class RemoveCategoryFormJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :category
  end
end
