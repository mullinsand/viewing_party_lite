require 'faker'

FactoryBot.define do
  factory :viewing_party do
    host { Faker::Internet.username }
    duration { Faker::Number.between(from: 60, to: 240) }
    movie_id { Faker::Number.unique.number(digits: 3) }
    image_path { Faker::File.mime_type(media_type: 'image')}
    movie_title { Faker::Movie.title}
    start_time { Faker::Time.forward(days:14)}
  end
end 