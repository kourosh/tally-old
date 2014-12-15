# Models
## User Model
* user_first_name
* user_last_name
* email
* user_street_address
* user_city
* user_street_address
* user_zip
* user_phone
* occupation
* employer_name
* unemployed_or_retired (users can be unemployed or retired; otherwise they have to declare their job and employer)

Users have many transactions

## Pol Model
* bioguide_id (ID used by the Biographical Directory of the United States Congress)
* birthdate
* chamber (Senate or House of Representatives)
* webform (URL of page on website where users can send emails)
* crp_id (Center for Responsive Politics ID)
* congresspedia_url 
* district
* facebook_id
* fax
* fec_id (Federal Election Commission ID)
* firstname 
* gender
* govtrack_id 
* in_office (boolean, indicated whether person is in office)
* lastname
* leadership_role
* middlename
* name_suffix
* nickname
* oc_email
* ocd_id
* official_rss
* congress_office
* party (Democrat, Republican or independent)
* phone
* senate_class
* state
* state_name
* term_end
* term_start
* thomas_id
* title (Rep or Sen)
* twitter_id
* votesmart_id
* website
* youtube_url

Pols have many events

## Event Model
* headline
* source (URL of article, tweet, YouTube video, etc. that is source of the event)

Events have many pols

## Transaction Model

