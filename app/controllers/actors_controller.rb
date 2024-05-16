class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    # params hash:Parameters: {"the_title"=>"1", "the_year"=>"2", "the_duration"=>"3", "the_description"=>"4", "the_image"=>"5", "the_director_id"=>"6"}
     #Retrieve the user's inputs from params
     #Create a record in the movie table
     #Populate each column with the user input
     #Save
     a = Actor.new
     a.name = params.fetch("the_name")
     a.dob = params.fetch("the_dob")
     a.bio = params.fetch("the_bio")
     a.image = params.fetch("the_image")
     a.save
 
     #Redirect to /movies url
     redirect_to("/actors")
   end
 
   def destroy
     the_id = params.fetch("an_id")
     matching_actor = Actor.where({:id => the_id}).first
     matching_actor.destroy
     redirect_to("/actors")
   end
 
   def update
     #get id from params
     #look up existing record
     #overwrite each column w/ new values
     #save and redirect to movie details page
 
     the_id = params.fetch("the_id")
     a = Actor.where({:id => the_id}).first
     a.name = params.fetch("the_name")
     a.dob = params.fetch("the_dob")
     a.bio = params.fetch("the_bio")
     a.image = params.fetch("the_image")
     a.save
 
     redirect_to("/actors/#{a.id}")
 
   end
end
