class QuestionFolder < ApplicationRecord
  acts_as_paranoid

  has_many :questions

  def remove_existing_questions
    questions.update_all(question_folder_id: nil)
    questions.reindex
  end

  def add_questions ids
    qs = Question.where(id: ids)
    questions.pluck(:id, :user_id).each do |q|
      Publishers::QuestionNotification.publish "pemilu.question", { question_id: q[0], receiver_id: q[1], notif_type: :question, event_type: :add_to_folder }
    end
    qs.update_all(question_folder_id: self.id, status: "archived")
    QuestionFolder.reset_counters(self.id, :questions)
    qs.reindex
  end
end
