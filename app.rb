require_relative 'book'
require_relative 'classroom'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def main_menu
    loop do
      puts "Welcome to the Library Management System!"
      puts "1. List all books"
      puts "2. List all people"
      puts "3. Create a person"
      puts "4. Create a book"
      puts "5. Create a rental"
      puts "6. List rentals by person ID"
      puts "7. Exit"
      print "Enter your choice: "
      choice = gets.chomp.to_i

      case choice
      when 1
        list_all_books
      when 2
        list_all_people
      when 3
        create_person
      when 4
        create_book
      when 5
        create_rental
      when 6
        display_rentals_by_person_id
      when 7
        puts "Thank you for using this app!"
        exit
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_code = gets.chomp.to_i

    case person_code
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid input'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    has_permission = gets.chomp.downcase == 'y'
    
    student = Student.new(age, name, has_permission)
    @people.push(student)
    puts 'Student created successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    
    teacher = Teacher.new(age, specialization, name)
    @people.push(teacher)
    puts 'Teacher created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully'
  end

  def list_all_books
    if @books.empty?
      puts 'No books available.'
    else
      @books.each do |book|
        puts "Title: \"#{book.title}\", Author: #{book.author}"
      end
    end
  end

  def list_all_people
    if @people.empty?
      puts 'No people available.'
    else
      @people.each do |person|
        type = person.instance_of?(Student) ? 'Student' : 'Teacher'
        puts "[#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_rental
    if @books.empty? || @people.empty?
      puts 'You need to create books and people first before creating a rental.'
      return
    end

    puts 'Select a book from the following list by number:'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id):'
    @people.each_with_index do |person, index|
      type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "#{index}) [#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp
    rental = Rental.new(date, @books[book_index], @people[person_index])
    @rentals.push(rental)
    puts 'Rental created successfully'
  end

  def display_rentals_by_person_id
    if @people.empty?
      puts 'No people available to list rentals for.'
      return
    end

    list_all_people
    print 'Enter person ID: '
    person_id = gets.chomp.to_i

    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts 'Person not found with that ID.'
      return
    end

    puts 'Rentals:'
    rentals = @rentals.select { |rental| rental.person == person }
    if rentals.empty?
      puts 'No rentals found for this person.'
    else
      rentals.each do |rental|
        puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
      end
    end
  end
end

app = App.new
app.main_menu
