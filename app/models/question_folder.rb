class QuestionFolder < ApplicationRecord
  acts_as_paranoid

  has_many :questions

  def remove_existing_questions
    questions.update_all(question_folder_id: nil)
    questions.reindex
  end

  def add_questions ids
    qs = Question.where(id: ids)
    qs.update_all(question_folder_id: self.id)
    QuestionFolder.reset_counters(self.id, :questions)
    qs.reindex
  end
  
  
end
