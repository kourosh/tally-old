FactoryGirl.define do
  factory :event do
    sequence :headline do |n|
    	"event headline #{n}"
    end
		source "http://eventsourceurl.com"
		pol_id 1
  end
end
