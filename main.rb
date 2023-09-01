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

def main
  app = App.new

  loop do
    display_options
    choice = gets.chomp.to_i

    case choice
    when 1
      app.list_all_books
    when 2
      app.list_all_people
    when 3
      app.create_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.display_rentals_by_person_id
    when 7
      puts 'Thank you for using School Library App!'
      exit
    else
      puts 'Invalid choice. Please try again.'
    end

    puts "\n"
  end
end

main
