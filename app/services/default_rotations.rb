class DefaultRotations

  ROTATIONS = {
		giants: [
			"菅野",
			"サンチェス",
      "髙橋　優貴",
      "戸郷　翔征",
      "田口　麗斗",
      "古川　侑利",
      "中川　皓太",
      "澤村　拓一",
      "高木　京介",
      "デラロサ"
		],
		tigers: [
			"西　勇輝",
			"青柳　晃洋",
			"髙橋　遥人",
			"ガルシア",
			"小野　泰己",
			"秋山　拓巳",
			"能見　篤史",
			"中田　賢一",
      "岩崎　優",
      "藤川　球児"
		],
		swallows: [
			"石川　雅規",
			"奥川　恭伸",
			"山田　大樹",
			"高梨　裕稔",
			"小川　泰弘",
			"高橋　奎二",
			"近藤　一樹",
			"マクガフ",
      "梅野　雄吾",
      "石山　泰稚"
		],
		carp: [
			"大瀬良　大地",
			"床田　寛樹",
			"森下　暢仁",
			"ジョンソン",
			"野村　祐輔",
			"遠藤　淳志",
			"今村　猛",
      "菊池　保則",
      "スコット",
			"中﨑　翔太"
		],
		baystars: [
			"今永　昇太",
			"濵口　遥大",
			"東　克樹",
			"上茶谷　大河",
			"平良　拳太郎",
			"井納　翔一",
			"エスコバー",
			"パットン",
      "藤岡　好明",
      "山﨑　康晃"
		],
		dragons: [
			"大野　雄大",
			"柳　裕也",
			"ロメロ",
			"小笠原　慎之介",
			"笠原　祥太郎",
			"梅津　晃大",
			"マルティネス",
			"藤嶋　健人",
      "又吉　克樹",
      "岡田　俊哉"
		],
		hawks: [
			"千賀　滉大",
			"高橋　礼",
			"バンデンハーク",
			"和田　毅",
			"大竹　耕太郎",
			"髙橋　純平",
			"武田　翔太",
			"石川　柊太",
      "モイネロ",
      "森　唯斗"
		],
		fighters: [
			"上沢　直之",
			"金子　弌大",
			"有原　航平",
			"バーヘイゲン",
			"加藤　貴之",
			"杉浦　稔大",
			"宮西　尚生",
			"公文　克彦",
      "ロドリゲス",
      "秋吉　亮"
		],
		buffaloes: [
			"山岡　泰輔",
			"山本　由伸",
			"榊原　翼",
			"Ｋ－鈴木",
			"張　奕",
			"田嶋　大樹",
			"近藤　大亮",
			"吉田　一将",
      "比嘉　幹貴",
      "増井　浩俊"
		],
		marines: [
			"美馬　学",
			"種市　篤暉",
			"二木　康太",
			"石川　歩",
			"岩下　大輝",
			"小島　和哉",
			"ジャクソン",
			"ハーマン",
      "松永　昂大",
      "益田　直也"
		],
		eagles: [
			"則本　昂大",
			"松井　裕樹",
			"岸　孝之",
			"塩見　貴洋",
			"辛島　航",
			"涌井　秀章",
			"宋　家豪",
			"森原　康平",
      "ブセニッツ",
      "青山　浩二"
		],
		lions: [
			"ニール",
			"髙橋　光成",
			"松本　航",
			"多和田　真三郎",
			"今井　達也",
			"十亀　剣",
			"本田　圭佑",
      "平良　海馬",
      "田村　伊知郎",
			"増田　達至"
		]
  }

  private_constant :ROTATIONS
  
  def initialize(team_name, year)
		@team_name = team_name
		@year = year
	end
	
	def pitcher_ids
		result = []
		10.times do |n|
			result << name_to_id(n)
		end
		result
	end

  def pitcher_id_by(order)
    name_to_id(order)
  end
  
  private

  def name_to_id(order)
		player = Pitcher.where(
				year: @year,
				team_id: Team.team_id(@team_name)
			)
			.where("name like '%#{ROTATIONS[@team_name.to_sym][order]}%'").take
		return nil if player.nil?
		player.id
	end
end
