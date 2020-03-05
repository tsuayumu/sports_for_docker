class RotationManage < ActiveRecord::Base
  has_many :rotation_manage_user_comments
  has_many :rotations
  belongs_to :team

  scope :team, ->(team){ where(team_id: team.id) }
  scope :year, ->(year){ where(year: year) } 
  
  delegate :name, to: :team, prefix: :team, allow_nil: true

  class << self
		def create_by!(team_id:, year:, comment:, rotation:)
			transaction do
				rotation_manage = create!(
					team_id: team_id,
					year: year,
					comment: comment
				)
				rotation.each.with_index(1) do |pitcher_id, index|
					Rotation.create(
						rotation_manage: rotation_manage,
						pitcher_id: pitcher_id,
						order: index
					)
				end
				rotation_manage.reload
      end
    end
  end
    

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
