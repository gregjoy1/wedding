require 'csv'

desc "Import Guests from CSV file"
task :import => [:environment] do

  file = "db/guests.csv"

  CSV.foreach(file, :headers => true) do |row|
    Guest.new(
      name: row[0],
      password: HashHelper.password_hash(row[1]),
      rspv: '-'
    )
  end

end

