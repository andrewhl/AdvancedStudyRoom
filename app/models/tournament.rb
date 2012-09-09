# == Schema Information
#
# Table name: tournaments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tournament < ActiveRecord::Base
  # attr_accessible :title, :body
end
