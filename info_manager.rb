# frozen_string_literal: true

# Module InfoManager Representative
module InfoManager
  def cls
    system('cls') || system('clear')
  end

  def info_showcase(records)
    if records.any?
      header = ['ID'.rjust(20), 'NAME'.rjust(20), 'URL'.rjust(20), 'LOGIN'.rjust(20), 'PASSWORD'.rjust(20)].join('|')
      puts header
      puts '-' * header.length
      records.each do |record|
        puts [record['rowid'].to_s.rjust(20), record['name'].rjust(20), record['url'].rjust(20), record['login'].rjust(20),
              record['password'].rjust(20)].join('|')
      end
    else
      puts 'No such entries'
    end
  end

  def show_all
    cls
    info_showcase(Account.all)
  end

  def create_account
    cls

    args = {}
    puts 'Type Name:'
    args[:name] = gets.chomp
    puts 'Type URL:'
    args[:url] = gets.chomp
    puts 'Type Login:'
    args[:login] = gets.chomp
    puts 'Type Password:'
    args[:password] = gets.chomp

    args.each { |key, value| args.delete(key) if value.empty? }

    Account.create(**args).to_s

    puts "\nThe following entry has been added:\n#{args[:name]}, #{args[:url]}, #{args[:login]}, #{args[:password]}"
  end

  def find_account
    cls

    puts "Select the search method:\n"
    puts '1. By name'
    puts '2. By URL'
    puts "3. Back to main menu\n"

    search_choice = gets.chomp
    case search_choice
    when '1'
      puts 'Enter a word:'
      input_word = gets.chomp
      puts 'Result(s) found:'
      info_showcase(Account.find_by_name(input_word))
    when '2'
      puts 'Enter a word:'
      input_word = gets.chomp
      puts 'Result(s) found:'
      info_showcase(Account.find_by_url(input_word))
    when '3'
      puts 'Returning to main menu...'
    end
  end

  def update_account
    cls
    puts "Type entry's ID:"
    entry_choice = gets.chomp

    entry = Account.find(entry_choice)
    info_showcase(entry)

    if entry.nil?
      puts 'No such entry'
      return
    end

    args = {}
    puts "\nChange the following: (press 'enter' to skip)\n"
    puts 'Type Name:'
    args[:name] = gets.chomp
    puts 'Type URL:'
    args[:url] = gets.chomp
    puts 'Type Login:'
    args[:login] = gets.chomp
    puts 'Type Password:'
    args[:password] = gets.chomp

    args.each { |key, value| args.delete(key) if value.empty? }

    Account.update(id: entry_choice, **args).to_s

    puts "\nThe following entry has been changed to: \n"

    info_showcase(Account.find(entry_choice))
  end

  def delete_account
    cls
    puts "Type entry's ID:"
    entry_choice = gets.chomp

    find_entry = Account.find(entry_choice)
    info_showcase(find_entry)

    if find_entry.nil?
      puts 'No such entry'
      return
    end

    puts "\nDo you want to delete the following entry? (type yes/no)\n"

    decision = gets.chomp
    return unless decision == 'yes'

    Account.destroy(entry_choice)

    puts "\nThe entry has been deleted\n"
  end
end
