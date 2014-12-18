p = Pol.all

p.each do |pol|
  puts "Pol.create(:firstname => '#{pol.firstname}', :lastname => '#{pol.lastname}', :bioguide_id => '#{pol.bioguide_id}', :state => '#{pol.state}', :party => '#{pol.party}', :title => '#{pol.title}')"
end