class Charity < ActiveRecord::Base

  validates_presence_of :name
  validates_length_of :name, :maximum => 100

  validates_presence_of :description
  validates_length_of :description, :maximum => 5000

end
