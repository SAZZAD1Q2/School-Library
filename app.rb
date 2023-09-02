require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def run
    loop do
      display_menu
      option = gets.chomp
      handle_option(option)
    end
  end
  
  def handle_option(option)
    case option
    when '1' then display_books
    when '2' then display_people
    when '3' then create_person
    when '4' then create_book
    when '5' then create_rental
    when '6' then display_rentals_by_person_id
    when '7' then exit_app
    else
      puts 'Invalid option. Please select a valid option.'
    end
  end

  def display_menu
    puts '1. Display Books'
    puts '2. Display People'
    puts '3. Create Person'
    puts '4. Create Book'
    puts '5. Create Rental'
    puts '6. Display Rentals by Person ID'
    puts '7. Exit'
    print 'Select an option: '
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    input = gets.chomp

    if %w[1 2].include?(input)
      puts 'Age: '
      age_input = gets.chomp

      puts 'Name: '
      name_input = gets.chomp
    else
      puts 'Please enter a valid input'
      return
    end

    case input
    when '1'
      create_student(age_input, name_input)
    when '2'
      create_teacher(age_input, name_input)
    else
      puts 'Please enter a valid input'
    end
  end

  # ... (create_student and create_teacher methods as before)

  def create_rental
    book_choice = select_book
    return if book_choice.nil?

    people_choice = select_person
    return if people_choice.nil?

    puts 'Date: '
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_choice], @people[people_choice])
    puts 'Rental created successfully!'
  end

  def select_book
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, idx|
      puts "#{idx}) #{book.title} by #{book.author}"
    end
    book_choice = gets.chomp.to_i

    if book_choice.negative? || book_choice >= @books.length
      puts 'Invalid input! Please enter a number within the range.'
      return nil
    end

    book_choice
  end

  def select_person
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, idx|
      puts "#{idx}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    people_choice = gets.chomp.to_i

    if people_choice.negative? || people_choice >= @people.length
      puts 'Invalid input! Please enter a number within the range.'
      return nil
    end

    people_choice
  end

  # ... (display_people and display_books methods as before)

  def exit_app
    puts 'Thank you for using this app!'
    exit
  end

  # ... (display_rentals_by_person_id and rental_printer methods as before)
end

# Create instances of App and start the application
app = App.new
app.run
