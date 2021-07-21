# frozen_string_literal: true

# Account class representation
class Account
  DATABASE_FILENAME = 'accounts.db'

  class << self
    def create_db
      connection.execute <<-SQL
      create table if not exists my_accounts (
        name text,
        url text,
        login text,
        password text
      );
      SQL
    end

    def all
      connection.execute('SELECT rowid, * FROM my_accounts;')
    end

    def find_by_name(word)
      connection.execute("SELECT rowid, * FROM my_accounts WHERE name LIKE '%#{word}%';")
    end

    def find_by_url(word)
      connection.execute("SELECT rowid, * FROM my_accounts WHERE url LIKE '%#{word}%';")
    end

    def find(id)
      connection.execute('SELECT rowid, * FROM my_accounts WHERE rowid = ? limit 1;', id)
    end

    def destroy(id)
      connection.execute('DELETE FROM my_accounts WHERE rowid = ?;', id)
    end

    def create(**args)
      fields = args.keys.join(', ')
      values = args.values.map { |value| "'#{value}'" }.join(', ')
      connection.execute("INSERT INTO my_accounts (#{fields}) VALUES (#{values});")
    end

    def update(id:, **args)
      fields = args.map { |key, value| "#{key} = '#{value}'" }.join(', ')
      connection.execute("UPDATE my_accounts SET #{fields} WHERE rowid = ?;", id)
    end

    private

    def connection
      db = SQLite3::Database.open(DATABASE_FILENAME)
      db.results_as_hash = true
      db
    end
  end
end
