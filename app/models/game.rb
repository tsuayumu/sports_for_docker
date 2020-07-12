require 'nokogiri'
require 'open-uri'

class Game < ActiveRecord::Base
  belongs_to :team
  has_one :game_inning

  def update_game_inning
    if game_inning.nil?
      GameInning.create(game: self)
      reload
    end

    6.times do |game_count|
      url = "https://baseball.yahoo.co.jp/npb/game/#{date.strftime("%Y%m%d")}0#{game_count+1}/text"

      charset = nil
      
      html = open(url) do |f|
        charset = f.charset
        f.read
      end

      doc = Nokogiri::HTML.parse(html, nil, charset)

      # bb-head01__title
      # ex "\n 7月10日（金）\n 中日 vs. 広島 4回戦\n"
      team_name = '巨人' if team.giants?
      team_name = '阪神' if team.tigers?
      team_name = 'ヤクルト' if team.swallows?
      team_name = '広島' if team.carp?
      team_name = 'ＤｅＮＡ' if team.baystars?
      team_name = '中日' if team.dragons?
      team_name = 'ソフトバンク' if team.hawks?
      team_name = '日本ハム' if team.fighters?
      team_name = 'オリックス' if team.buffaloes?
      team_name = 'ロッテ' if team.marines?
      team_name = '楽天' if team.eagles?
      team_name = '西武' if team.lions?
      
      next unless doc.xpath('//*[(@class = "bb-head01__title")]').text.include?(team_name)

      # t1が1回表、b1が1回裏
      if doc.xpath('//*[(@id = "t1")]').present?
        game_inning.update(one_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t2")]').present?
        game_inning.update(two_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t3")]').present?
        game_inning.update(three_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t4")]').present?
        game_inning.update(four_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t5")]').present?
        game_inning.update(five_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t6")]').present?
        game_inning.update(six_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t7")]').present?
        game_inning.update(seven_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t8")]').present?
        game_inning.update(eight_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t9")]').present?
        game_inning.update(nine_inning_at: Time.now)
      end
      if doc.xpath('//*[(@id = "t10")]').present?
        game_inning.update(ten_inning_at: Time.now)
      end

      break
    end
  end
end
