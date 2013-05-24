class Page < ActiveRecord::Base
  attr_accessible :date, :html, :title, :user_id
end
