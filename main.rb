# frozen_string_literal: true

require 'sqlite3'
require_relative 'account'
require_relative 'info_manager'

# AccountManager class representation
class AccountManager
  include InfoManager

  def menu
    puts 'Account Manager v.1.0'
    sleep 1

    Account.create_db

    loop do
      puts "\nSelect an option:\n\n"
      puts '1. Show all entries'
      puts '2. Create an entry'
      puts '3. Find an entry'
      puts '4. Update an entry'
      puts '5. Delete an entry'
      puts "6. Exit\n"

      choice = gets.chomp
      handle_user_choice(choice)
    end
  end

  private

  def handle_user_choice(choice)
    case choice
    when '1'
      show_all
    when '2'
      create_account
    when '3'
      find_account
    when '4'
      update_account
    when '5'
      delete_account
    when '6'
      puts 'Come again!'
      exit
    end
  end
end

AccountManager.new.menu
