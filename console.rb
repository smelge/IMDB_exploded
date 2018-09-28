require('pry')
require_relative('./models/actor.rb')
require_relative('./models/movie.rb')
require_relative('./models/role.rb')

Role.delete_all()
Actor.delete_all()
Movie.delete_all()

# Create actors
actor1 = Actor.new({'first_name' => 'John','last_name' => 'Cusack'})
actor2 = Actor.new({'first_name' => 'Paul','last_name' => 'Rabbit'})
actor3 = Actor.new({'first_name' => 'Arnold','last_name' => 'Schwifty'})
actor4 = Actor.new({'first_name' => 'Gabriel','last_name' => 'Hammers'})
actor5 = Actor.new({'first_name' => 'Judy','last_name' => 'McMadeupname'})
# binding.pry
actor1.save()
actor2.save()
actor3.save()
actor4.save()
actor5.save()

# Create Movies
movie1 = Movie.new({'title' => 'Final Biscuit','genre'=>'horror','budget'=>54})
movie2 = Movie.new({'title' => 'The Lost Shovel','genre'=>'fantasy','budget'=>90})
movie3 = Movie.new({'title' => 'Total Recoil','genre'=>'action','budget'=>76})
movie4 = Movie.new({'title' => 'Bloodgore Splatter','genre'=>'family comedy','budget'=>678})
movie5 = Movie.new({'title' => 'Debbie Does Chitty Chitty Bang Bang','genre'=>'documentary','budget'=>23})

movie1.save()
movie2.save()
movie3.save()
movie4.save()
movie5.save()

# Create Roles
role1 = Role.new({'movie_id'=> movie1.id,'actor_id'=> actor2.id,'fee'=>8})
role2 = Role.new({'movie_id'=> movie2.id,'actor_id'=> actor4.id,'fee'=>12})
role3 = Role.new({'movie_id'=> movie4.id,'actor_id'=> actor5.id,'fee'=>4})
role4 = Role.new({'movie_id'=> movie2.id,'actor_id'=> actor1.id,'fee'=>9})

role1.save()
role2.save()
role3.save()
role4.save()

# movie2.budget()
binding.pry
nil
