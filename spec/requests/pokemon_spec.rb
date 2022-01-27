require 'rails_helper'

RSpec.describe PokemonsController, type: :controller do
  login_user
  
  describe "GET Pokemons/index" do
   it "Go to index!" do
    get :index
    expect(response).to have_http_status(200)  
   end 
  end

  describe "Get Pokemons/new" do
     it "render new template" do 
      get :new
      should render_template('new')
     end
  end

  describe "Create pokemon" do
    it "redirect to the pokemos created" do 
      post :create, :params => {:pokemon => {:name => "pokemon1", :order => 1, :base_expirence => 1, :heigth => 2 , :weight => 3, :img_url => '' }}
      expect(response).to  have_http_status(302) 
      expect(response).to redirect_to(pokemon_path :id=> Pokemon.last.id)   
    end 
  end


end
