require 'faker'

25.times do
  number = Faker::Number.non_zero_digit
  Project.create!([{
    name: Faker::Superhero.power,
    description: Faker::Marketing.buzzwords,
    user_id: User.first.id,
    duration: "#{number} min",
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
  }])
end
