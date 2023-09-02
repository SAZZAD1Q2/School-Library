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

  def choose_option
    option = gets.chomp
    case option
    when '1'
      display_books
    when '2'
      display_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      display_rentals_by_person_id
    when '7'
      puts 'Thank you for using this app!'
      exit
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '

    input = gets.chomp

    if %w[1 2].include?(input)
      puts 'Age: '
      age_input = gets.chomp

      puts 'Name: '
      name_input = gets.chomp
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

  def create_student(age, name)
    puts 'Has parent permission? [Y/N]'
    permission_input = gets.chomp
    case permission_input.upcase
    when 'Y'
      @people << Student.new(age, name)
      puts 'Person created successfully'
    when 'N'
      @people << Student.new(age, name, parent_permission: false)
      puts 'Person created successfully'
    else
      puts 'Please enter a valid input'
    end
  end

  def create_teacher(age, name)
    puts 'Specialization: '
    specialization = gets.chomp
    @people << Teacher.new(specialization, age, name)
    puts 'Person created successfully!'
  end

  def display_people
    puts 'There is no people yet.' if @people.empty?
    @people.map { |people| people_printer(people) }
  end

  def people_printer(people)
    puts "[#{people.class}] Name: #{people.name}, ID: #{people.id}, Age: #{people.age}"
  end

  def create_book
    puts 'Title: '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book created successfully!'
  end

  def display_books
    puts 'There is no books yet.' if @books.empty?
    @books.map { |book| book_printer(book) }
  end

  def book_printer(book)
    puts "Title: \"#{book.title}\", Author: #{book.author}"
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.map.with_index do |book, idx|
      print "#{idx}) "
      book_printer(book)
    end
    book_choice = gets.chomp.to_i

    if book_choice.negative? || book_choice >= @books.length
      puts 'Invalid input! Please enter a number within the range.'
      return
    end

    puts 'Select a person from the following list by number (not id)'
    @people.map.with_index do |people, idx|
      print "#{idx}) "
      people_printer(people)
    end
    people_choice = gets.chomp.to_i

    if people_choice.negative? || people_choice >= @people.length
      puts 'Invalid input! Please enter a number within the range.'
      return
    end

    puts 'Date: '
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_choice], @people[people_choice])
    puts 'Rental created successfully!'
  end

  def display_rentals_by_person_id
    display_people
    puts 'Enter person ID'
    id = gets.chomp.to_i
    puts 'Rentals:'
    filtered_rentals = @rentals.select { |rental| rental.person.id == id }
    if filtered_rentals.empty?
      puts 'This person has no rentals.'
      return
    end
    filtered_rentals.map { |rental| rental_printer(rental) }
  end

  def rental_printer(rental)
    puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
  end
end
