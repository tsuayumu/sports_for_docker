class RotationManage < ActiveRecord::Base
  has_many :rotation_comments
  has_many :rotations
  belongs_to :team
  accepts_nested_attributes_for :rotations

  scope :team, ->(team){ where(team_id: team.id) }
  scope :year, ->(year){ where(year: year) } 
  
  delegate :name, to: :team, prefix: :team, allow_nil: true

  def tweet_text(request_url:, line_code:)
		result = ''
		result << "#{comment}#{line_code}#{line_code}" if comment.present?
		rotations.each.with_index(1) do |l, i|
      if i == 1
        result << "【先発】#{line_code}"
      elsif i == 7
        result << "#{line_code}【中継ぎ】#{line_code}"
      elsif i == 10
        result << "#{line_code}【抑え】#{line_code}"
      end
      result << "#{l.name}#{line_code}"
		end
		result << "#{line_code}詳しくはこちら#{line_code}#{request_url} #{line_code}#{line_code}"
    result << "##{team_name} ##{year}開幕ローテーション"
    result
	end
end
