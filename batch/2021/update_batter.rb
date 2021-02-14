# 巨人
Batter.find_by(name: "梶谷　隆幸", year: 2021).update(team_id: 1)
Pitcher.find_by(name: "井納　翔一", year: 2021).update(team_id: 1)
Batter.find_or_create_by(name: "スモーク", year: 2021, team_id: 1)
Batter.find_or_create_by(name: "テームズ", year: 2021, team_id: 1)
Pitcher.find_or_create_by(name: "平内　龍太", year: 2021, team_id: 1)
Pitcher.find_or_create_by(name: "伊藤　優輔", year: 2021, team_id: 1)
Batter.find_or_create_by(name: "秋広　優人", year: 2021, team_id: 1)

# 阪神
Batter.find_or_create_by(name: "ロハスJr", year: 2021, team_id: 2)
Batter.find_or_create_by(name: "佐藤　輝明", year: 2021, team_id: 2)
Pitcher.find_or_create_by(name: "チェン", year: 2021, team_id: 2)
Pitcher.find_or_create_by(name: "アルカンタラ", year: 2021, team_id: 2)

# カープ
Batter.find_or_create_by(name: "ケビン・クロン", year: 2021, team_id: 4)
Pitcher.find_or_create_by(name: "栗林　良吏", year: 2021, team_id: 4)

# 横浜
Pitcher.find_or_create_by(name: "入江　大生", year: 2021, team_id: 5)
Batter.find_by(name: "田中　俊太", year: 2021).update(team_id: 5)

# 中日
Batter.find_by(name: "福留　孝介", year: 2021).update(team_id: 6)
Batter.find_or_create_by(name: "ガーバー", year: 2021, team_id: 6)
Pitcher.find_or_create_by(name: "高橋　宏斗", year: 2021, team_id: 6)

# ヤクルト
Batter.find_by(name: "内川　聖一", year: 2021).update(team_id: 3)
Batter.find_or_create_by(name: "オスナ", year: 2021, team_id: 3)
Batter.find_or_create_by(name: "サンタナ", year: 2021, team_id: 3)
Pitcher.find_or_create_by(name: "木澤　尚文", year: 2021, team_id: 3)

# ソフトバンク

# ファイターズ
Pitcher.find_or_create_by(name: "伊藤　大海", year: 2021, team_id: 8)
Batter.find_or_create_by(name: "五十幡　亮汰", year: 2021, team_id: 8)

# オリックス
Pitcher.find_or_create_by(name: "平野　佳寿", year: 2021, team_id: 9)
Pitcher.find_or_create_by(name: "山下　舜平大", year: 2021, team_id: 9)
Batter.find_or_create_by(name: "来田　涼斗", year: 2021, team_id: 9)
Batter.find_by(name: "ロメロ", year: 2021).update(team_id: 9)

# ロッテ
Batter.find_or_create_by(name: "エチェバリア", year: 2021, team_id: 10)
Pitcher.find_or_create_by(name: "鈴木　昭汰", year: 2021, team_id: 10)

# 楽天
Pitcher.find_or_create_by(name: "早川　隆久", year: 2021, team_id: 11)
Pitcher.find_or_create_by(name: "田中　将大", year: 2021, team_id: 11)
Batter.find_or_create_by(name: "カスティーヨ", year: 2021, team_id: 11)

# ライオンズ
Batter.find_or_create_by(name: "渡部　健人", year: 2021, team_id: 12)
