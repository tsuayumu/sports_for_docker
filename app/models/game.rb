class Game < ActiveRecord::Base
  belongs_to :team
  has_one :game_top_one_inning
  has_one :game_top_two_inning
  has_one :game_top_three_inning
  has_one :game_top_four_inning
  has_one :game_top_five_inning
  has_one :game_top_six_inning
  has_one :game_top_seven_inning
  has_one :game_top_eight_inning
  has_one :game_top_nine_inning
  has_one :game_top_ten_inning
  has_one :game_bottom_one_inning
  has_one :game_bottom_two_inning
  has_one :game_bottom_three_inning
  has_one :game_bottom_four_inning
  has_one :game_bottom_five_inning
  has_one :game_bottom_six_inning
  has_one :game_bottom_seven_inning
  has_one :game_bottom_eight_inning
  has_one :game_bottom_nine_inning
  has_one :game_bottom_ten_inning
end
