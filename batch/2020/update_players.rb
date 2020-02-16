require 'nokogiri'
require 'open-uri'
require 'kconv'

TEAM = [
	{ name_en: "giants", key: "g" },
	{ name_en: "tigers", key: "t" },
	{ name_en: "swallows", key: "s" },
	{ name_en: "carp", key: "c" },
	{ name_en: "baystars", key: "db" },
	{ name_en: "dragons", key: "d" },
	{ name_en: "hawks", key: "h" },
	{ name_en: "fighters", key: "f" },
	{ name_en: "buffaloes", key: "b" },
	{ name_en: "marines", key: "m" },
	{ name_en: "eagles", key: "e" },
	{ name_en: "lions", key: "l" }
]


def update_players(team)
  url = "http://npb.jp/bis/teams/rst_#{team[:key]}.html"

	charset = nil

	html = open(url) do |f|
		charset = f.charset
		f.read
	end

  doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
  
  player_names = {}
  key = nil
  doc.xpath('//tr').each do |node|
    name = node.search('td[@class="rosterRegister"]').text.delete("\"")
    if name.present? && key
      player_names[key] << name
    else
      key = node.search('th[@class="rosterPos"]').text.delete("\"")
      if key.present?
        player_names[key] = player_names[key] || []
      end
    end
  end

  team_id = Team.team_id("#{team[:name_en]}")
  player_names["投手"].each do |player_name|
    Pitcher.find_or_create_by(team_id: team_id, name: player_name, year: 2020)
  end

  (player_names["内野手"] + player_names["捕手"] + player_names["外野手"]).each do |player_name|
    Batter.find_or_create_by(team_id: team_id, name: player_name, year: 2020)
  end
end

TEAM.each do |team|
  update_players(team)
end