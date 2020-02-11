Pitcher.find_by(name: "中田　賢一", year: 2020).update(team_id: 2)
Pitcher.find_by(name: "美馬　学", year: 2020).update(team_id: 10)
Pitcher.find_by(name: "ハーマン", year: 2020).update(team_id: 10)
Pitcher.find_by(name: "涌井　秀章", year: 2020).update(team_id: 11)
Pitcher.find_by(name: "松坂　大輔", year: 2020).update(team_id: 12)
Pitcher.find_or_create_by(name: "サンチェス", year: 2020, team_id: 1)
Pitcher.find_or_create_by(name: "奥川　恭伸", year: 2020, team_id: 3)
Pitcher.find_or_create_by(name: "スコット", year: 2020, team_id: 4)
Pitcher.find_or_create_by(name: "森下　暢仁", year: 2020, team_id: 4)
Pitcher.find_or_create_by(name: "バーヘイゲン", year: 2020, team_id: 8)
Pitcher.find_or_create_by(name: "佐々木　朗希", year: 2020, team_id: 10)
Pitcher.find_or_create_by(name: "ジャクソン", year: 2020, team_id: 10)


