# == Schema Information
#
# Table name: event_tags
#
#  id         :integer          not null, primary key
#  phrase     :string(255)
#  event_id   :integer
#  node_limit :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventTag < ActiveRecord::Base

  before_validation :format_phrase

  belongs_to :event

  attr_accessible :phrase,
                  :node_limit

  validates :event_id,
    presence: true
  validates :phrase,
    presence: true,
    uniqueness: {scope: :event_id},
    format: {with: /^\s*\#?[^\s]+\s*$/, message: "can't have spaces"}
  validates :node_limit,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}


  def after_initialize
    self.node_limit ||= 0
  end

  private

    def format_phrase
      tag_phrase = phrase.strip
      self.phrase = '#' + tag_phrase unless tag_phrase =~ /^\#/
    end

end
