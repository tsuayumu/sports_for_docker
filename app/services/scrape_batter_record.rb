require 'nokogiri'
require 'open-uri'

class ScrapeBatterRecord
  SCRAPE_DOMAIN = "https://npb.jp"
  private_constant :SCRAPE_DOMAIN

  def initialize(batter_name)
    @batter_name = batter_name
  end

  # [
  #   { year: 2018, match: 1, win: 2,・・・}
  #   { year: 2019, match: 1, win: 2,・・・}
  #   ・・・
  # ]
  def all_year_records
    batter_record_path = scrape_batter_record_path_by_name
    record_doc = scrape_batter_record(batter_record_path)
    parse_record_doc(record_doc)
  end

  private

  def scrape_batter_record_path_by_name
    batter_name_search_url = "#{SCRAPE_DOMAIN}/bis/players/search/result?search_keyword=#{@batter_name}&active_flg="
    search_doc = scrape(batter_name_search_url)
    # /bis/players/31935132.html
    search_doc.css("a.player_unit_1")[0][:href]
  end

  def scrape_batter_record(batter_record_path)
    batter_record_url = "#{SCRAPE_DOMAIN}#{batter_record_path}"
    scrape(batter_record_url)
  end

  def parse_record_doc(record_doc)
    # 0 年度
    # 1 チーム
    # 2 登板
    # 3 勝利
    # 4 敗北
    # 5 セーブ
    # 7 ホールドポイント
    # 24 防御率
    result = []
    record_doc.css("div#stats_p").css("tr.registerStats").each do |year_record|
      result << {
        year: year_record.css("td")[0].text.gsub(/[^0-9]/,""),
        match: year_record.css("td")[2].text,
        win: year_record.css("td")[3].text,
        defeat: year_record.css("td")[4].text,
        save_point: year_record.css("td")[5].text,
        hold: year_record.css("td")[7].text,
        era: year_record.css("td")[24].text.gsub(/[^0-9.]/,"")
      }
    end
    result
  end

  def scrape(url)
    charset = nil
    html = open(URI.encode(url)) do |f|
      charset = f.charset
      f.read
    end
    Nokogiri::HTML.parse(html, nil, charset)
  end
end
