namespace :dev do

  task :rebuild => ["db:drop", "db:setup", :fake ]
  # task :rebuild => ["db:drop", "db:create", "db:schema:load", "db:seed", :fake ]
  task :fake => :environment do
    User.delete_all
    Po.delete_all
    Comment.delete_all

    puts "Creating fake Data!"

    user = User.create!( :email => "hugo@hotmail.com", :password => "12345678")

    20.times do |i|
      p = Po.create( :title => Faker::App.name, :user => user ) # :user_id => user.id
      10.times do |j|
        p.comments.create( :comment => Faker::Lorem.sentences(1, true) )
      end
    end
  end

  task :ubike => :environment do

    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5"

    json_string = RestClient.get(url)

    data = JSON.parse( json_string )

    data["result"]["results"].each do |u|
      existing = Ubike.find_by_raw_id( u["_id"] )
      if existing
         # update
      else
        Ubike.create( :raw_id => u["_id"], :name => u["sna"])
        puts "create #{u["sna"]}"
      end
    end

   end

end
