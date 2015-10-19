require 'csv'

desc "Import Menu Items from CSV file"
task :import_menu_items => [:environment] do

  file = "db/menu_items.csv"

  CSV.foreach(file, :headers => true) do |row|
    puts "Importing #{row[0]}"
    MenuItem.create(
      name: row[0],
      description: row[1],
      labels: row[2],
      meal_type: row[3]
    )
  end

end

