10.times do
  Person.create!(
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      age: rand(18..99),
      email: FFaker::Internet.email
  )
end

people = Person.all.load
tags = ["Fruits", "Vegetables", "Meats"]

10.times do
  Post.create!(
      person: people.sample,
      published_at: [true, true, false].sample ? rand(1..365).days.from_now : nil,
      private: [false, false, true].sample,
      content: FFaker::HipsterIpsum.paragraph,
      tags: tags.shuffle.first(2)
  )
end

posts = Post.all

10.times do
  Comment.create!(
      person: people.sample,
      content: FFaker::HipsterIpsum.paragraph,
      post: posts.sample
  )
end
