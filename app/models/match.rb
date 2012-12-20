# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  datetime_completed :datetime
#  game_type          :string(255)
#  komi               :float
#  winner             :string(255)
#  win_info           :string(255)
#  main_time_control  :float
#  overtime_type      :string(255)
#  ot_stones_periods  :integer
#  ot_time_control    :float
#  url                :string(255)
#  black_player_id    :integer
#  white_player_id    :integer
#  black_player_name  :string(255)
#  white_player_name  :string(255)
#  handicap           :integer
#  game_digest        :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Match < ActiveRecord::Base
  attr_accessible :datetime_completed,
                  :game_type,
                  :komi,
                  :main_time_control,
                  :ot_stones_periods,
                  :ot_time_control,
                  :overtime_type,
                  :result,
                  :url,
                  :winner,
                  :win_info,
                  :black_player,
                  :white_player,
                  :handicap,
                  :black_player_name,
                  :white_player_name,
                  :game_digest,
                  :black_player_id,
                  :white_player_id

  validates_uniqueness_of :game_digest, :on => :create, :message => "must be unique"

  belongs_to :black_player, :class_name => 'Registration'
  belongs_to :white_player, :class_name => 'Registration'

  has_many :comments, :dependent => :destroy
  has_many :points


  def has_valid_tag comments

    # TO DO: TEST IF THE NODE LIMIT WORKS ON A GAME WITH A TAG THAT APPEARS
    # AFTER NODE 0

    valid_tag = false

    comments.each do |node, line|
      next if line.is_a? String
      line.each do |key, value|

        # binding.pry
        # see if tag exists that matches the current line's comment
        if Tag.where("phrase like ?", value[:comment]).exists?
          tag = Tag.where("phrase like ?", value[:comment]).first
          valid_tag = true
          node_limit ||= tag.node_limit

        end

        # check node limit (i.e., move limit in which tag phrase must appear)
        if node_limit
          # returns false if the current node key (when parsed) is greater than the node limit
          return false if node.to_s.scan(/\d/).pop.to_i > node_limit
        end


      end

      return valid_tag
    end

  end

  def is_valid?

    # will check first that a rule in this ruleset is not nil
    # if not nil, it will check to see that the match applies the rule
    # if it fails, the game will not be saved, will return false



    #  datetime_completed :datetime
    #  game_type          :string(255)
    #  komi               :float
    #  winner             :string(255)
    #  win_info           :string(255)
    #  main_time_control  :float
    #  overtime_type      :string(255)
    #  ot_stones_periods  :integer
    #  ot_time_control    :float
    #  url                :string(255)
    #  black_player_id    :integer
    #  white_player_id    :integer
    #  black_player_name  :string(255)
    #  white_player_name  :string(255)
    #  handicap           :integer
    #  game_digest        :string(255)


  end

end
