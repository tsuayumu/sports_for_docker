require 'nokogiri'
require 'open-uri'

class GameInningService
  def initialize(game)
    @game = game
  end

  def update
    charset = nil
    html = open(game_list_url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    game_detail_urls = []
    doc.css(".nScore").each do |link|
      game_detail_urls << link.css("a")[0][:href]
    end

    game_detail_urls.reverse! if @game.team.league.pacific?

    game_detail_urls.each do |game_detail_url|
      charset = nil
      begin
        html = open("https://www.nikkansports.com#{game_detail_url}") do |f|
          charset = f.charset
          f.read
        end
      rescue
        next
      end
      doc = Nokogiri::HTML.parse(html, nil, charset)

      # cardTitle
      # ex "巨人 対 ヤクルト"
      next unless doc.xpath('//*[(@id = "cardTitle")]').text.include?(team_name)

      unless DailyLineupManage.where(team: @game.team, date: @game.date).present?
        names = StartingMember.new(
          doc: doc,
          team_name: team_name
        ).names
        DailyLineupManage.create_by_prefix_match_name!(
          team_id: @game.team_id,
          date: @game.date,
          names: names
        )
      end      

      [:top, :bottom].each do |top_or_bottom|
        10.times do |int|
          inning_model = "Game#{top_or_bottom.to_s.capitalize}#{IntegerConvertAlphabet.convert(int+1).capitalize}Inning".constantize
          inning = inning_model.find_or_create_by(
            game: @game
          )
          inning.update(
            text: InningText.new(
              doc: doc,
              inning_sym: "#{IntegerConvertAlphabet.convert(int+1)}_inning".to_sym,
              top_or_bottom: top_or_bottom
            ).text
          )
        end
      end

      break
    end
  end

  private

  def game_list_url
    "https://www.nikkansports.com/baseball/professional/score/2020/pf-score-#{@game.date.strftime("%Y%m%d")}.html"
  end

  def team_name
    result = '巨人' if @game.team.giants?
    result = '阪神' if @game.team.tigers?
    result = 'ヤクルト' if @game.team.swallows?
    result = '広島' if @game.team.carp?
    result = 'ＤｅＮＡ' if @game.team.baystars?
    result = '中日' if @game.team.dragons?
    result = 'ソフトバンク' if @game.team.hawks?
    result = '日本ハム' if @game.team.fighters?
    result = 'オリックス' if @game.team.buffaloes?
    result = 'ロッテ' if @game.team.marines?
    result = '楽天' if @game.team.eagles?
    result = '西武' if @game.team.lions?
    result
  end

  class StartingMember
    SCRAPING_HASH = {
      position: 0,
      batter: 1
    }

    def initialize(doc:, team_name:)
      @doc = doc
      @team_name = team_name
    end

    def names
      result = []
      @doc.xpath('//table[(@class = "batter")]')[top_or_bottom].xpath('tr').each do |tr|
        if tr.xpath('td')[SCRAPING_HASH[:position]]&.text&.include?("(")
          result << tr.xpath('td')[SCRAPING_HASH[:batter]]&.text
        end
      end
      result
    end

    private

    def top_or_bottom
      @doc.xpath('//caption').each_with_index do |caption, index|
        return index if caption.text == "【#{@team_name}】"
      end
    end
  end

  class InningText
    SCRAPING_HASH = {
      top: 0,
      bottom: 1,
      one_inning: 9,
      two_inning: 10,
      three_inning: 11,
      four_inning: 12,
      five_inning: 13,
      six_inning: 14,
      seven_inning: 15,
      eight_inning: 16,
      nine_inning: 17,
      ten_inning: 18,
      batter: 1
    }

    def initialize(doc:, inning_sym:, top_or_bottom:)
      @doc = doc
      @inning_sym = inning_sym
      @top_or_bottom = top_or_bottom
    end

    def text
      inning_texts = []
      @doc.xpath('//table[(@class = "batter")]')[SCRAPING_HASH[@top_or_bottom]].xpath('tr').each do |tr|
        inning_texts << {
          batter: tr.xpath('td')[SCRAPING_HASH[:batter]]&.text, # バッター
          result: tr.xpath('td')[SCRAPING_HASH[@inning_sym]]&.text # 打席結果
        }
      end
      inning_texts = inning_texts.select do |inning_text|
        inning_text[:result].present? && inning_text[:result] != "……"
      end
      inning_texts.map{|inning_text| "#{inning_text[:batter]}  #{inning_text[:result]}"}.join("\n")
    end
  end
end
