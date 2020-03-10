class OpeningStartingLineup::DefaultLineups

	LINEUPS = {
		giants: [
			"吉川　尚輝",
			"坂本　勇人",
			"丸",
			"岡本　和真",
			"大城　卓三",
			"亀井　善行",
			"山下　航汰",
			"投手",
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
			"投手"
		],
		swallows: [
			"坂口　智隆",
			"青木　宣親",
			"山田　哲人",
			"村上　宗隆",
			"雄平",
			"中山　翔太",
			"中村　悠平",
			"投手",
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
			"投手"
		],
		baystars: [
			"桑原",
			"大和",
			"梶谷",
			"ソト",
			"ロペス",
			"宮﨑",
			"戸柱",
			"投手",
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
			"投手"
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
			"田中　和基"
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
		],
		japan: [
			"近藤　健介",
			"坂本　勇人",
			"柳田　悠岐",
			"鈴木　誠也",
			"森　友哉",
			"岡本　和真",
			"山川　穂高",
			"外崎　修汰",
			"山田　哲人"
		]
	}

	private_constant :LINEUPS

	def initialize(team_name, year)
		@team_name = team_name
		@year = year
	end

	def lineup_player_ids
		result = []
		LINEUPS[@team_name.to_sym].each do |player_name|
			player_id = Batter.where(
					year: @year,
					team_id: Team.team_id(@team_name)
				)
				.where("name like '%#{player_name}%'").take&.id
			result << player_id if player_id
		end
		result
	end
end
