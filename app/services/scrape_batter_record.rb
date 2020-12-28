require 'nokogiri'
require 'open-uri'

class ScrapeBatterRecord
  def initialize(batter_name)
    @batter_name = batter_name
  end

  # [
  #   { year: 2018, match: 1, win: 2,・・・}
  #   { year: 2019, win: 1, lose: 2,・・・}
  #   ・・・
  # ]
  def all_year_records
    batter_name_search_url = URI.encode("https://npb.jp/bis/players/search/result?search_keyword=#{@batter_name}&active_flg=")

    charset = nil
    html = open(batter_name_search_url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    # /bis/players/31935132.html
    batter_record_path = doc.css("a.player_unit_1")[0][:href]

    batter_record_url = URI.encode("https://npb.jp#{batter_record_path}")
    charset = nil
    html = open(batter_record_url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)

    # 0 年度
    # 1 チーム
    # 2 登板
    # 3 勝利
    # 4 敗北
    # 5 セーブ
    # 7 ホールドポイント
    # 24 防御率
    res = []
    doc.css("div#stats_p").css("tr.registerStats").each do |year_record| 
      res << {
        year: year_record.css("td")[0].text.gsub(/[^0-9]/,""),
        match: year_record.css("td")[2].text,
        win: year_record.css("td")[3].text,
        defeat: year_record.css("td")[4].text,
        save_point: year_record.css("td")[5].text,
        hold: year_record.css("td")[7].text,
        era: year_record.css("td")[24].text.gsub(/[^0-9.]/,"")
      }
    end

    res
  end
end