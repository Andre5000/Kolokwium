#5 razy generuje z Fakera tytul i lorem ipsum
#rails db:seed
5.times do
	Article.create({
		title: Faker::Book.title,
		body: Faker::Lorem.sentence
		})	
end