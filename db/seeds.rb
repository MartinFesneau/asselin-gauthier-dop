# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

projects = [["clip", "https://www.youtube.com/watch?v=p-RDyY6b47k" , "Jamais" , "Tessa B" , "Remi Danino" , "Dissidence Production"],

["clip","https://vimeo.com/317245732 ","Mercutio","Sean","Nathan Almeras","Dissidence Production"],

["clip"," https://www.youtube.com/watch?v=hpGNRHdNSDU","Mechant","Niska feat. Ninho","Liswaya","Glitch Paris"],

["pub","https://vimeo.com/443420902","Ready For Football","A.D.I.D.A.S.","William S. Touitou","When We Were Kids"],

["clip","https://vimeo.com/364310814","Trigger","Form","Yanis & Mehdi Hamnane","Dissidence Production"]]

puts "starting seed"

projects.each do |project|
  Project.create(
    category: project[0],
    url: project[1],
    name: project[2],
    artist: project[3],
    director: project[4],
    producer: project[5])
end

puts 'end of seed'
puts "created #{Project.all.count}"