class API::V1::PendidikanPolitik::OnlyStaging::Resources::Quiz < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "only_staging" do
    params do
      requires :total_question, type: Integer
    end
    post "/generate_random_quiz" do
      quiz = ::Quiz.create title: ::Faker::Lorem.sentence(3), description: ::Faker::Lorem.sentence(8), image: Rails.root.join("spec/images/html.png").open
      quiz.published!

      present :quiz, quiz

      params.total_question.times do |i|
        question = ::QuizQuestion.create content: ::Faker::Lorem.sentence(5), quiz: quiz
        ::QuizAnswer.create content: ::Faker::Lorem.sentence(5), team: 1, quiz_question: question
        ::QuizAnswer.create content: ::Faker::Lorem.sentence(8), team: 2, quiz_question: question
        present :"question_#{i}", question
        present :"answer_#{i}", question.quiz_answers
      end

    end
  end
end
