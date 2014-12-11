require 'csv'    

csv_text = File.read('legislators.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
	Pol.create!(row.to_hash)
end