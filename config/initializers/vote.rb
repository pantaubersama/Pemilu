ActsAsVotable::Vote.class_eval do
  after_create :give_achievement

  def give_achievement
    total = ActsAsVotable::Vote.where(voter_id: voter_id, votable_type: "Question", vote_flag: true).count
    Publishers::QuestionUpvotingBadge.publish({user_id: voter_id, badge_code: "tanyainteraksi", total: total})
  end

end