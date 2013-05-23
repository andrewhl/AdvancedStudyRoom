# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  admin               :boolean          default(FALSE), not null
#  email                  :string(255)      default(""), not null
#  username            :string(255)
#  password_digest     :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#

class User < ActiveRecord::Base
  has_secure_password

  has_many :accounts, validate: true, autosave: true, dependent: :destroy
  has_many :awards
  has_many :events, through: :registrations
  has_many :registrations, through: :accounts
  has_many :servers, through: :accounts

  attr_accessible :username,
                  :email,
                  :password,
                  :password_confirmation,
                  :first_name,
                  :last_name,
                  :accounts_attributes

  accepts_nested_attributes_for :accounts, allow_destroy: true


  validates :email,
              presence: true,
              uniqueness: {case_sensitive: false},
              format: { with: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i,
                        message: 'is an invalid email' }
  validates :username,  presence: true, 
                        uniqueness: {case_sensitive: false}
  validates :password, confirmation: true, unless: Proc.new { |u| u.password.blank? }


  def joined_event? event_id
    events.exists?(id: event_id)
  end
end
