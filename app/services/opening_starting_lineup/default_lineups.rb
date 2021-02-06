class OpeningStartingLineup::DefaultLineups

	LINEUPS = {
		giants: [
			"梶谷　隆幸",
			"坂本　勇人",
			"丸",
			"岡本　和真",
			"スモーク",
			"テームズ",
			"大城　卓三",
			"吉川　尚輝",
			"投手",
		],
		tigers: [
			"近本　光司",
			"糸原",
			"ロハス",
			"大山　悠輔",
			"サンズ",
			"佐藤",
			"梅野　隆太郎",
			"木浪",
			"投手"
		],
		swallows: [
			"坂口　智隆",
			"青木　宣親",
			"山田　哲人",
			"村上　宗隆",
			"サンタナ",
			"オスナ",
			"西浦",
			"西田",
			"投手"
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
			"神里",
			"オースティン",
			"ソト",
			"佐野",
			"宮﨑",
			"ロペス",
			"倉本",
			"戸柱",
			"投手"
		],
		dragons: [
			"大島",
			"京田",
			"阿部",
			"ビシエド",
			"高橋",
			"平田",
			"福留",
			"木下",
			"投手"
		],
		hawks: [
			"周東",
			"中村",
			"柳田",
			"グラシアル",
			"栗原",
			"デスパイネ",
			"松田",
			"今宮",
			"甲斐　拓也"
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
			"藤原",	
			"荻野",
			"中村",
			"安田",
			"井上",
			"レアード",
			"角中",
			"田村",
			"藤岡"
		],
		eagles: [
			"小深田",
			"鈴木　大地",
			"茂木",
			"浅村",
			"銀次",
			"島内",
			"太田",
			"黒川",
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
