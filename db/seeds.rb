require 'faker'

25.times do
  Project.create!([{
    name: Faker::Superhero.power,
    description: Faker::Marketing.buzzwords,
    user_id: User.first.id,
    content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
  }])
end
