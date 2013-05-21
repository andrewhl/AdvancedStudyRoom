# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  handle     :string(255)
#  user_id    :integer
#  server_id  :integer
#  rank       :integer
#  active     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base

  belongs_to :server
  belongs_to :user

  has_many :events, through: :registrations
  has_many :points
  has_many :registrations, dependent: :destroy

  attr_accessible :handle,
                  :rank,
                  :server_id,
                  :user_id

  validates :handle, presence: true, uniqueness: {scope: :server_id}
  validates :server_id, presence: true
  validate  :unique_servers_per_user


  def event_points *event_id
    if event_id
      self.points.where(:event_id => event_id)
    else
      self.points.event_points
    end
  end

  private

    def unique_servers_per_user
      account = user && user.accounts.where(server_id: server_id).first
      if account && account.id != id
        errors.add(:server_id, "is already used")
      end
    end

end
