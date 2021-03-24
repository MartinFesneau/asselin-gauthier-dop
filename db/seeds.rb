# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "starting seed"
Project.destroy_all
index = 1
20.times do
  projet = Project.new(
    category: ["clip", "pub"].sample,
    format: "16by9",
    url: "https://vimeo.com/354045295",
    name: "project#{index}",
    artist: "artist project #{index}",
    director: "someone",
    producer: "don't know",
    position: index)
  
  file = URI.open('https://source.unsplash.com/random/800x600')
  projet.photos.attach(io: file, filename: "cover", content_type: 'image/jpeg')
  projet.save!
  puts projet.name
  index += 1
end

puts 'end of seed'
puts "created #{Project.all.count}"