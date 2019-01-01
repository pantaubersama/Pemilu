class API::V1::PendidikanPolitik::OnlyStaging::Resources::Quiz < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "only_staging" do
    post "/generate_random_quiz" do
      quiz = ::Quiz.create title: Faker::Lorem.sentence(3), description: Faker::Lorem.sentence(5), image: Rack::Test::UploadedFile.new('spec/images/html.png', 'image/png')
      
      question_1 = ::QuizQuestion.create content: Faker::Lorem.sentence(5), quiz: quiz
      question_2 = ::QuizQuestion.create content: Faker::Lorem.sentence(7), quiz: quiz
      question_3 = ::QuizQuestion.create content: Faker::Lorem.sentence(3), quiz: quiz

      ::QuizAnswer.create content: Faker::Lorem.sentence(5), team: 1, quiz_question: question_1
      ::QuizAnswer.create content: Faker::Lorem.sentence(5), team: 2, quiz_question: question_1

      ::QuizAnswer.create content: Faker::Lorem.sentence(5), team: 1, quiz_question: question_2
      ::QuizAnswer.create content: Faker::Lorem.sentence(5), team: 2, quiz_question: question_2

      ::QuizAnswer.create content: Faker::Lorem.sentence(5), team: 1, quiz_question: question_3
      ::QuizAnswer.create content: Faker::Lorem.sentence(5), team: 2, quiz_question: question_3

      present :quiz, quiz

      present :question1, question_1
      present :question2, question_2
      present :question3, question_3

      present :answer1, question_1.quiz_answers
      present :answer2, question_2.quiz_answers
      present :answer3, question_3.quiz_answers

    end
  end
end
