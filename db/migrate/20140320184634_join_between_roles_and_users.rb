class JoinBetweenRolesAndUsers < ActiveRecord::Migration
  def change
    create_join_table :roles, :users
    change_table :roles do |t|
      t.remove :user_id
    end
  end
end
