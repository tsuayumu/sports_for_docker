class OpeningStartingLineup::DefaultLineups

	LINEUPS_2018 = {
		giants: [
			"吉川　尚輝",
			"坂本　勇人",
			"丸",
			"岡本　和真",
			"大城　卓三",
			"亀井　善行",
			"山下　航汰",
			"菅野　智之",
			"重信　慎之介"
		],
		tigers: [
			"木浪　聖也",
			"近本　光司",
			"糸井　嘉男",
			"大山　悠輔",
			"福留　孝介",
			"中谷　将大",
			"髙山　俊",
			"梅野　隆太郎",
			"藤浪　晋太郎"
		],
		swallows: [
			"坂口　智隆",
			"青木　宣親",
			"山田　哲人",
			"村上　宗隆",
			"雄平",
			"中山　翔太",
			"中村　悠平",
			"小川　泰弘",
			"川端　慎吾"
		],
		carp: [
			"田中",
			"菊池",
			"西川",
			"鈴木",
			"松山",
			"安部",
			"小園",
			"會澤",
			"薮田"
		],
		baystars: [
			"桑原",
			"大和",
			"梶谷",
			"ソト",
			"ロペス",
			"宮﨑",
			"戸柱",
			"今永",
			"倉本"
		],
		dragons: [
			"平田",
			"京田",
			"大島",
			"ビシエド",
			"アルモンテ",
			"高橋",
			"福田",
			"阿部",
			"大野"
		],
		hawks: [
			"今宮",
			"柳田",
			"グラシアル",
			"バレンティン",
			"松田",
			"デスパイネ",
			"内川",
			"甲斐　拓也",
			"中村"
		],
		fighters: [
			"西川",
			"大田",
			"近藤",
			"中田",
			"清宮",
			"王",
			"万波",
			"清水",
			"中島"
		],
		buffaloes: [
			"福田",
			"中川",
			"吉田　正尚",
			"ジョーンズ",
			"ロドリゲス",
			"モヤ",
			"西浦",
			"若月",
			"安達"
		],
		marines: [
			"荻野",
			"福田",
			"中村",
			"井上",
			"レアード",
			"角中",
			"安田",
			"田村",
			"平沢"
		],
		eagles: [
			"茂木",
			"鈴木　大地",
			"浅村",
			"ウィーラー",
			"銀次",
			"島内",
			"岡島",
			"オコエ",
			"嶋"
		],
		lions: [
			"スパンジェンバーグ",
			"源田",
			"森",
			"山川",
			"外崎",
			"中村",
			"木村　文紀",
			"栗山",
			"金子"
		]
	}

	private_constant :LINEUPS_2018

	def initialize(team_name, year)
		@team_name = team_name
		@year = year
	end

	def lineup
		lineup_to_id
	end

	def lineup_to_id
		team = LINEUPS_2018[@team_name.to_sym]
		team_id = {}
		team_id[:lineups] = {}
		9.times do |n|
			team_id[:lineups].store(n.to_s, { player_id: name_to_id(team, n) })
		end
		team_id
	end

	def name_to_id(team, order)
		player = Player.where(year: @year).where(team_id: Team.team_id(@team_name)).where("name like '%#{team[order]}%'").take
		return nil if player.nil?
		player.id
	end
end
