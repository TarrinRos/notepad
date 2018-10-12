require_relative 'lib/post'
require_relative 'lib/memo'
require_relative 'lib/link'
require_relative 'lib/task'

current_path = File.dirname(__FILE__)

puts 'Привет! Я твой блокнот.'
puts 'Что ты хочешь записать?'

choices = Post.post_types

choice = -1

until choice >= 0 && choice < choices.size
  choices.each_with_index do |title, index|
    puts "\t#{index}. #{title}"
  end

  choice = STDIN.gets.to_i
end

entry = Post.create(choice)

entry.read_from_console

entry.save(current_path)

puts 'Ура! Запись сохранена'