class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    # params hash:Parameters: {"the_title"=>"1", "the_year"=>"2", "the_duration"=>"3", "the_description"=>"4", "the_image"=>"5", "the_director_id"=>"6"}
     #Retrieve the user's inputs from params
     #Create a record in the movie table
     #Populate each column with the user input
     #Save
     d = Director.new
     d.name = params.fetch("the_name")
     d.dob = params.fetch("the_dob")
     d.bio = params.fetch("the_bio")
     d.image = params.fetch("the_image")
     d.save
 
     #Redirect to /movies url
     redirect_to("/directors")
   end
 
   def destroy
     the_id = params.fetch("an_id")
     matching_director = Director.where({:id => the_id}).first
     matching_director.destroy
     redirect_to("/directors")
   end
 
   def update
     #get id from params
     #look up existing record
     #overwrite each column w/ new values
     #save and redirect to movie details page
 
     the_id = params.fetch("the_id")
     d = Director.where({:id => the_id}).first
     d.name = params.fetch("the_name")
     d.dob = params.fetch("the_dob")
     d.bio = params.fetch("the_bio")
     d.image = params.fetch("the_image")
     d.save
 
     redirect_to("/directors/#{d.id}")
 
   end

end
