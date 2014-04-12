class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.text :description
      t.belongs_to :charity
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
