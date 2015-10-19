require 'csv'

desc "Import Guests from CSV file"
task :import_guests => [:environment] do

  file = "db/guests.csv"

  CSV.foreach(file, :headers => true) do |row|
    puts "Importing #{row[0]}"

    login = Login.create(
      name: row[0],
      password: HashHelper.password_hash(row[1])
    )

    for inc in 2..(row.count - 1) do
      login.guests << Guest.new(
        name: row[inc],
        rspv: '-'
      )
    end

    login.save
  end

end

