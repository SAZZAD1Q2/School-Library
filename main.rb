require './app'

def display_options
  puts "Welcome to school library app!
  Please choose an option by entering a number:
    1 - List all books
    2 - List all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - List all rentals for a given person id
    7 - Exit"
end

def main
  app = App.new
  loop do
    display_options
    app.choose_option
    puts "\n"
  end
end

main
