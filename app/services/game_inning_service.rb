class GameInningService
  def initialize(game)
    @game = game
  end

  def update    
    game_count_array.each do |game_count|
      charset = nil
      begin
        html = open(scraping_url(game_count)) do |f|
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

  def scraping_url(game_count)
    "https://www.nikkansports.com/baseball/professional/score/2020/#{league_name}l#{@game.date.strftime("%Y%m%d")}#{game_count}.html"
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

  def game_count_array
    if @game.team.league.central?
      [12, 13, 14, 11, 10, 15, 16, 17]
    elsif @game.team.league.pacific?
      [15, 16, 17, 14, 18, 11, 12, 13]
    end
  end

  def league_name
    if @game.team.central?
      'c'
    elsif @game.team.pacific?
      'p'
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
      inning_text_array = []
      @doc.xpath('//table[(@class = "batter")]')[SCRAPING_HASH[@top_or_bottom]].xpath('tr').each do |tr|
        inning_text_array << {
          batter: tr.xpath('td')[SCRAPING_HASH[:batter]]&.text, # バッター
          result: tr.xpath('td')[SCRAPING_HASH[@inning_sym]]&.text # 打席結果
        }
      end
      inning_text_array = inning_text_array.select do |inning_text|
        inning_text[:result].present? && inning_text[:result] != "……"
      end
      inning_text_array.map{|inning_text| "#{inning_text[:batter]} #{inning_text[:result]}"}.join('\n')
    end
  end
end

class IntegerConvertAlphabet
  CONVERT_ALPHA = {
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten'
  }

  class << self
    def convert(int)
      CONVERT_ALPHA[int]
    end
  end
end