class CreatePols < ActiveRecord::Migration
      def change
            create_table :pols do |t|
                  t.string :bioguide_id
                  t.string :birthdate
                  t.string :chamber
                  t.string :webform
                  t.string :crp_id
                  t.string :congresspedia_url
                  t.integer :district
                  t.string :facebook_id
                  t.string :fax
                  t.string :fec_id
                  t.string :firstname
                  t.string :gender
                  t.string :govtrack_id
                  t.boolean :in_office
                  t.string :lastname
                  t.string :leadership_role
                  t.string :middlename
                  t.string :name_suffix
                  t.string :nickname
                  t.string :oc_email
                  t.string :ocd_id
                  t.string :official_rss
                  t.string :congress_office
                  t.string :party
                  t.string :phone
                  t.string :senate_class
                  t.string :state
                  t.string :state_name
                  t.string :term_end
                  t.string :term_start
                  t.string :thomas_id
                  t.string :title
                  t.string :twitter_id
                  t.string :votesmart_id
                  t.string :website
                  t.string :youtube_url

                  t.timestamps
            end
      end

end