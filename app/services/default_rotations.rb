class DefaultRotations

  ROTATIONS = {
		giants: [
      "菅野",
      "サンチェス",
      "戸郷　翔征",
      "平内　龍太",
      "畠",
      "髙橋　優貴",
      "大江",
      "デラロサ",
      "高梨",
      "中川　皓太"
		],
		tigers: [
			"西　勇輝",
			"青柳　晃洋",
			"髙橋　遥人",
			"藤浪",
			"岩貞",
			"秋山　拓巳",
			"守屋",
			"中田　賢一",
      "岩崎　優",
      "スアレス"
		],
		swallows: [
			"小川　泰弘",
			"石川　雅規",
			"奥川　恭伸",
			"高橋　奎二",
			"高梨　裕稔",
			"原",
			"長谷川",
			"清水",
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
			"入江",
			"エスコバー",
			"国吉",
      "三嶋",
      "山﨑　康晃"
		],
		dragons: [
			"大野　雄大",
			"福谷",
			"柳　裕也",
			"梅津　晃大",
			"小笠原　慎之介",
			"笠原　祥太郎",
			"祖父江",
			"福",
      "又吉　克樹",
      "マルティネス"
		],
		hawks: [
			"千賀　滉大",
			"石川　柊太",
			"東浜",
			"高橋　礼",
			"和田　毅",
			"大竹　耕太郎",
			"モイネロ",
			"泉",
			"杉山",
      "森　唯斗"
		],
		fighters: [
			"上沢　直之",
			"金子　弌大",
			"河野",
			"吉田",
			"柿木",
			"杉浦　稔大",
			"宮西　尚生",
			"公文　克彦",
      "秋吉",
      "伊藤"
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
			"唐川",
			"ハーマン",
      "澤村",
      "益田　直也"
		],
		eagles: [
			"田中",
			"涌井　秀章",
			"岸　孝之",
			"則本　昂大",
			"早川",
			"辛島　航",
			"牧田",
			"森原　康平",
      "酒",
      "松井　裕樹"
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
		],
		japan: [
			"菅野　智之",
			"千賀　滉大",
			"今永　昇太",
			"高橋　礼",
			"有原　航平",
			"山岡　泰輔",
			"山本　由伸",
      "松井　裕樹",
      "森　唯斗",
			"山﨑　康晃"
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
