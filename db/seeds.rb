# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create([
                {
                    name: 'Angga Ari Wijaya',
                    username: 'anggadarkprince',
                    email: 'anggadarkprince@gmail.com',
                    password: 'secret',
                    avatar: 'avatar-1.jpg',
                    about: 'Full stack programmer',
                    role: 'admin'
                }
            ])
10.times do |index|
  User.create([
                  {
                      name: Faker::Name.name,
                      username: Faker::Internet.user_name,
                      email: Faker::Internet.email,
                      password: Faker::Internet.password,
                      avatar: 'avatar-'+Random.rand(1..10).to_s+'.jpg',
                      about: Faker::Lorem.paragraph,
                      role: 'writer'
                  }
              ]);
end
p "Created #{User.count} users"

Category.destroy_all
Category.create([
                    {
                        category: 'Computer',
                        description: 'A computer is an electronic device that manipulates information, or data. It has the ability to store, retrieve, and process data. You may already know that you can use a computer to type documents, send email, play games, and browse the Web.',
                        featured: 'computer.jpg',
                    },
                    {
                        category: 'Health',
                        description: 'Health is the level of functional and metabolic efficiency of a living organism. In humans it is the ability of individuals or communities to adapt and self-manage when facing physical, mental, psychological and social changes with environment.',
                        featured: 'health.jpg',
                    },
                    {
                        category: 'Relationship',
                        description: 'An interpersonal relationship is a strong, deep, or close association or acquaintance between two or more people that may range in duration from brief to enduring.',
                        featured: 'relationship.jpg',
                    },
                    {
                        category: 'Movies',
                        description: 'Find new releases and all movies playing in Regal, Edwards, and United Artists Theatres now, plus movies coming soon. Entertainment is your source for the latest TV, movies, music, and celebrity news, including interviews, trailers, photos, and first looks.',
                        featured: 'movies.jpg',
                    },
                    {
                        category: 'Food',
                        description: 'Food is any substance consumed to provide nutritional support for an organism. It is usually of plant or animal origin, and contains essential nutrients',
                        featured: 'food.jpg',
                    },
                    {
                        category: 'Sport',
                        description: 'Watch the best live coverage of your favourite sports: Football, Golf, Rugby, Cricket, Tennis, F1, Boxing, plus the latest sports news, transfers & scores.',
                        featured: 'sport.jpg',
                    },
                    {
                        category: 'Life',
                        description: 'The meaning of life, or the answer to the question "What is the meaning of life?", pertains to the significance of living or existence in general.',
                        featured: 'life.jpg',
                    },
                    {
                        category: 'Work',
                        description: 'Work–life balance is a concept including proper prioritizing between "work" (career and ambition) and "lifestyle This is related to the idea of lifestyle choice.',
                        featured: 'work.jpg',
                    }
                ])
p "Created #{Category.count} categories"

Tag.destroy_all
Tag.create([
               {tag: 'life'}, {tag: 'gadget'}, {tag: 'tech'}, {tag: 'stuff'},
               {tag: 'things'}, {tag: 'hack'}, {tag: 'daily'}, {tag: 'support'},
               {tag: 'knowledge'}, {tag: 'awesome'}, {tag: 'fancy'}, {tag: 'social'},
               {tag: 'good'}, {tag: 'cheap'}, {tag: 'black'}, {tag: 'energy'},
               {tag: 'internet'}, {tag: 'delicious'}, {tag: 'drink'}, {tag: 'warm'},
               {tag: 'kick'}, {tag: 'exercise'}, {tag: 'patient'}, {tag: 'love'}
           ])
p "Created #{Tag.count} tags"

Article.destroy_all
100.times do |index|
  articles = Article.create([
                     {
                         slug: Faker::Internet.slug(Faker::Lorem.sentence(3), '-'),
                         title: Faker::Lorem.sentence(3),
                         content: Faker::Lorem.paragraph(5),
                         featured: 'feature-'+Random.rand(1..10).to_s+'.jpg',
                         views: Random.rand(1..10000),
                         category_id: rand(1..8),
                         user_id: rand(2..11),
                     }
                 ])
  articles.each do |article|
    total = Random.rand(1..10)
    total.times do |counter|
      article.article_tags.create(tag_id: Random.rand(1..24))
    end
  end
end
p "Created #{Article.count} articles"
