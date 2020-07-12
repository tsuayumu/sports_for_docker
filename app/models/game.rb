require 'nokogiri'
require 'open-uri'

class Game < ActiveRecord::Base
  belongs_to :team
  has_one :game_inning
end
