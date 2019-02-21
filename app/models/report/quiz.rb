module Report
  class Quiz

    def self.per_questions qid
      query = QuizAnswering.joins(:quiz, :quiz_question, :quiz_answer)
        .where(quiz_participation_id: QuizParticipation.finished.map(&:id))
        .order("quiz_answerings.quiz_id asc, quiz_answerings.quiz_question_id asc")
        .select("quiz_answerings.quiz_id, quiz_answerings.quiz_question_id, quiz_answerings.quiz_answer_id,quiz_answerings.id, quizzes.title as quiz_title, quiz_questions.content as quiz_question_content, quiz_answers.team as quiz_answer_team")
      query = query.where("quiz_answerings.quiz_id = ?", qid) if qid.present?
      result = query.group_by {|k,v|
        [k.quiz_question_id, k.quiz_title, k.quiz_question_content]
      }.map{|x, y|
        {
          quiz: x[1],
          question: x[2],
          total: y.size,
          teams: [
            {
              id: 1,
              total: y.select{|y1| y1.quiz_answer_team == 1}.size,
              percentage: percentage(y.select{|y1| y1.quiz_answer_team == 1}.size, y.size)
            },
            {
              id: 2,
              total: y.select{|y1| y1.quiz_answer_team == 2}.size,
              percentage: percentage(y.select{|y1| y1.quiz_answer_team == 2}.size, y.size)
            }
          ]
        }
      }
    end

    def self.percentage base, total
      ((base / total.to_f) * 100).round(2)
    end

  end
end
