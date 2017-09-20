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
                        slug: 'computer',
                        category: 'Computer',
                        description: 'A computer is an electronic device that manipulates information, or data. It has the ability to store, retrieve, and process data. You may already know that you can use a computer to type documents, send email, play games, and browse the Web.',
                        featured: 'computer.jpg',
                    },
                    {
                        slug: 'health',
                        category: 'Health',
                        description: 'Health is the level of functional and metabolic efficiency of a living organism. In humans it is the ability of individuals or communities to adapt and self-manage when facing physical, mental, psychological and social changes with environment.',
                        featured: 'health.jpg',
                    },
                    {
                        slug: 'relationship',
                        category: 'Relationship',
                        description: 'An interpersonal relationship is a strong, deep, or close association or acquaintance between two or more people that may range in duration from brief to enduring.',
                        featured: 'relationship.jpg',
                    },
                    {
                        slug: 'movies',
                        category: 'Movies',
                        description: 'Find new releases and all movies playing in Regal, Edwards, and United Artists Theatres now, plus movies coming soon. Entertainment is your source for the latest TV, movies, music, and celebrity news, including interviews, trailers, photos, and first looks.',
                        featured: 'movies.jpg',
                    },
                    {
                        slug: 'food',
                        category: 'Food',
                        description: 'Food is any substance consumed to provide nutritional support for an organism. It is usually of plant or animal origin, and contains essential nutrients',
                        featured: 'food.jpg',
                    },
                    {
                        slug: 'sport',
                        category: 'Sport',
                        description: 'Watch the best live coverage of your favourite sports: Football, Golf, Rugby, Cricket, Tennis, F1, Boxing, plus the latest sports news, transfers & scores.',
                        featured: 'sport.jpg',
                    },
                    {
                        slug: 'life',
                        category: 'Life',
                        description: 'The meaning of life, or the answer to the question "What is the meaning of life?", pertains to the significance of living or existence in general.',
                        featured: 'life.jpg',
                    },
                    {
                        slug: 'work',
                        category: 'Work',
                        description: 'Work–life balance is a concept including proper prioritizing between "work" (career and ambition) and "lifestyle This is related to the idea of lifestyle choice.',
                        featured: 'work.jpg',
                    }
                ])
p "Created #{Category.count} categories"

Tag.destroy_all
Tag.create([
               {slug: 'life', tag: 'life'}, {slug: 'gadget', tag: 'gadget'}, {slug: 'tech', tag: 'tech'}, {slug: 'stuff', tag: 'stuff'},
               {slug: 'things', tag: 'things'}, {slug: 'hack', tag: 'hack'}, {slug: 'daily', tag: 'daily'}, {slug: 'support', tag: 'support'},
               {slug: 'knowledge', tag: 'knowledge'}, {slug: 'awesome', tag: 'awesome'}, {slug: 'fancy', tag: 'fancy'}, {slug: 'social', tag: 'social'},
               {slug: 'good', tag: 'good'}, {slug: 'cheap', tag: 'cheap'}, {slug: 'black', tag: 'black'}, {slug: 'energy', tag: 'energy'},
               {slug: 'internet', tag: 'internet'}, {slug: 'delicious', tag: 'delicious'}, {slug: 'drink', tag: 'drink'}, {slug: 'warm', tag: 'warm'},
               {slug: 'kick', tag: 'kick'}, {slug: 'exercise', tag: 'exercise'}, {slug: 'patient', tag: 'patient'}, {slug: 'love', tag: 'love'}
           ])
p "Created #{Tag.count} tags"

Article.destroy_all
200.times do |index|
  articles = Article.create([
                                {
                                    slug: Faker::Internet.slug(Faker::Lorem::words(3).join(' '), '-'),
                                    title: Faker::Lorem.sentence(3),
                                    content: '<p>'+Faker::Lorem.paragraph(10)+'</p><p>'+Faker::Lorem.paragraph(12)+'</p><p>'+Faker::Lorem.paragraph(10)+'</p><p>'+Faker::Lorem.paragraph(12)+'</p><p>'+Faker::Lorem.paragraph(10)+'</p>',
                                    featured: 'feature-'+Random.rand(1..10).to_s+'.jpg',
                                    views: Random.rand(1..10000),
                                    category_id: rand(1..8),
                                    user_id: rand(2..11)
                                }
                            ])


  counterComment = 0
  articles.each do |article|
    totalTags = Random.rand(1..10)
    totalTags.times do |counter|
      article.article_tags.create(tag_id: Random.rand(1..24))
    end

    counterReset = 0
    totalComments = Random.rand(1..10)
    totalComments.times do |counter|
      if ([true, false].sample && counterReset >= 1)
        article.comments.create(
            name: Faker::Name.name,
            email: Faker::Internet.email,
            comment: Faker::Lorem.sentence(5),
            votes: Random.rand(1..100),
            status: %w(pending approved rejected).sample,
            user_id: rand(1..11),
            comment_id: counterComment
        )
      else
        article.comments.create(
            name: Faker::Name.name,
            email: Faker::Internet.email,
            comment: Faker::Lorem.sentence(5),
            votes: Random.rand(1..100),
            status: %w(pending approved rejected).sample,
            user_id: rand(1..11),
        )
      end
      counterComment += 1
      counterReset += 1
    end

  end
end
p "Created #{Article.count} articles"

Contact.destroy_all
10.times do |index|
  Contact.create([
                  {
                      name: Faker::Name.name,
                      email: Faker::Internet.email,
                      subject: Faker::Lorem.sentence(3),
                      about: Faker::Lorem.paragraph,
                  }
              ]);
end
p "Created #{Contact.count} contact"