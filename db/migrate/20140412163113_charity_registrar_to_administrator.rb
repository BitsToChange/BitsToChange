class CharityRegistrarToAdministrator < ActiveRecord::Migration
  def change
    role = Role.find_by_name('charity registrar')
    unless role.nil?
      role.name = Constants::Roles::CHARITY_ADMINISTRATOR
      role.save!
    end
  end
end
