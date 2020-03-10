player_names = [
  "吉川　尚輝",
  "坂本　勇人",
  "丸　佳浩",
  "小林　誠司",
  "岡本　和真",
  "亀井　善行",
  "近本　光司",
  "糸井　嘉男",
  "大山　悠輔",
  "福留　孝介",
  "青木　宣親",
  "山田　哲人",
  "村上　宗隆",
  "菊池　涼介",
  "會澤　翼",
  "西川　龍馬",
  "鈴木　誠也",
  "宮﨑　敏郎",
  "平田　良介",
  "京田　陽太",
  "大島　洋平",
  "高橋　周平",
	"今宮　健太",
  "柳田　悠岐",
  "松田　宣浩",
  "内川　聖一",
  "甲斐　拓也",
  "中村　晃",
  "西川　遥輝",
  "大田　泰示",
  "近藤　健介",
  "中田　翔",
  "清宮　幸太郎",
  "吉田　正尚",
  "安達　了一",
  "荻野　貴司",
  "井上　晴哉",
  "茂木　栄五郎",
  "鈴木　大地",
  "浅村　栄斗",
  "源田　壮亮",
  "森　友哉",
  "山川　穂高",
  "外崎　修汰",
  "中村　剛也",
  "周東　佑京"
]

player_names.each do |player_name|
  next if Batter.find_by(name: player_name, year: 2020, team_id: 13).present?
  b = Batter.find_by(name: player_name, year: 2020)
  japan_batter = Batter.create(
    name: b.name,
    team_id: 13,
    year: 2020
  )
  BatterRecord.create(
    batter: japan_batter,
    average: b.batter_record.average,
    rbi: b.batter_record.rbi,
    homerun: b.batter_record.homerun,
    year: 2020
  )
end

player_names = [
  "菅野　智之",
  "田口　麗斗",
  "中川　皓太",
  "西　勇輝",
  "岩崎　優",
  "藤川　球児",
  "石山　泰稚",
  "大瀬良　大地",
  "中﨑　翔太",
  "今永　昇太",
  "山﨑　康晃",
  "大野　雄大",
  "柳　裕也",
  "岡田　俊哉",
  "千賀　滉大",
  "高橋　礼",
  "森　唯斗",
  "有原　航平",
  "宮西　尚生",
  "山岡　泰輔",
  "山本　由伸",
  "益田　直也",
  "種市　篤暉",
  "則本　昂大",
  "松井　裕樹",
  "岸　孝之",
  "森原　康平",

]

player_names.each do |player_name|
  next if Pitcher.find_by(name: player_name, year: 2020, team_id: 13).present?
  b = Pitcher.find_by(name: player_name, year: 2020)
  japan_pitcher = Pitcher.create(
    name: b.name,
    team_id: 13,
    year: 2020
  )
  PitcherRecord.create(
    pitcher: japan_pitcher,
    match: b.pitcher_record.match,
    era: b.pitcher_record.era,
    win: b.pitcher_record.win,
    defeat: b.pitcher_record.defeat,
    hold: b.pitcher_record.hold,
    save_point: b.pitcher_record.save_point,
    year: 2020
  )
end
