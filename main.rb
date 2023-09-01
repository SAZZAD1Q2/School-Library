# require_relative 'person'
# require_relative 'student'
# require_relative 'teacher'

# student = Student.new(1, 16, 'Physics', 'Alice')
# teacher = Teacher.new(2, 35, 'Mathematics', 'Mr. Smith')

# puts student.name
# puts teacher.name


require './app'

def display_options
  puts 'Welcome to School Library App!'
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person ID'
  puts '7 - Exit'
end

def handle_choice(app, choice)
  actions = {
    1 => -> { app.list_all_books },
    2 => -> { app.list_all_people },
    3 => -> { app.create_person },
    4 => -> { app.create_book },
    5 => -> { app.create_rental },
    6 => -> { app.display_rentals_by_person_id },
    7 => -> do
      puts 'Thank you for using School Library App!'
      exit
    end
  }

  action = actions[choice]

  if action.nil?
    puts 'Invalid choice. Please try again.'
  else
    action.call
  end
end

def main
  app = App.new

  loop do
    display_options
    choice = gets.chomp.to_i
    handle_choice(app, choice)
    puts "\n"
  end
end

main
