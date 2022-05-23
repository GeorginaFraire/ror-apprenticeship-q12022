class PokemonsController < ApplicationController
  before_action :set_pokemon, only: %i[ show edit update destroy ]

  # GET /pokemons or /pokemons.json
  def index
    @pokemons = Pokemon.all.name_sort
  end

  # GET /pokemons/1 or /pokemons/1.json
  def show
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
  end

  # GET /pokemons/1/edit
  def edit
  end

  # POST /pokemons or /pokemons.json
  def create
    @pokemon = Pokemon.new(pokemon_params)

    respond_to do |format|
      if @pokemon.save
        format.html { redirect_to pokemon_url(@pokemon), notice: "Pokemon was successfully created." }
        format.json { render :show, status: :created, location: @pokemon }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemons/1 or /pokemons/1.json
  def update
    respond_to do |format|
      if @pokemon.update(pokemon_params)
        format.html { redirect_to pokemon_url(@pokemon), notice: "Pokemon was successfully updated." }
        format.json { render :show, status: :ok, location: @pokemon }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_ability
    begin 
      ability = Ability.find(relacion_params[:ability_id])
      pokemon = Pokemon.find(relacion_params[:pokemon_id])
      pokemon.abilities << ability
      flash[:notice] = 'Ability was successfully added'
      redirect_to edit_pokemon_path
    rescue ActiveRecord::RecordInvalid  => error
      flash[:notice] = error.message
      redirect_to edit_pokemon_path
    rescue ActiveRecord::RecordNotFound => error
      flash[:notice] = error.message
      redirect_to edit_pokemon_path
    end
  end

  def add_type
    begin 
      type = Type.find(relacion_params[:type_id])
      pokemon = Pokemon.find(relacion_params[:pokemon_id])
      pokemon.types << type
      flash[:notice] = 'Type was successfully added'
      redirect_to edit_pokemon_path
    rescue ActiveRecord::RecordInvalid  => error
      flash[:notice] = error.message
      redirect_to edit_pokemon_path
    rescue ActiveRecord::RecordNotFound => error
      flash[:notice] = error.message
      redirect_to edit_pokemon_path
    end
  end


  # DELETE /pokemons/1 or /pokemons/1.json
  def destroy
    @pokemon.destroy

    respond_to do |format|
      format.html { redirect_to pokemons_url, alert: "Pokemon was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def delete_ability
    ability = Ability.find(relacion_params[:ability_id])
    pokemon = Pokemon.find(relacion_params[:pokemon_id])
    pokemon.abilities.delete(ability)
    flash[:alert] = "Ability '#{ability.name}' was deleted"
    redirect_to edit_pokemon_path
  end

  def delete_type
    type = Type.find(relacion_params[:type_id])
    pokemon = Pokemon.find(relacion_params[:pokemon_id])
    pokemon.types.delete(type)
    flash[:alert] = "Type #{type.name} was deleted"
    redirect_to edit_pokemon_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pokemon_params
      params.require(:pokemon).permit(:name, :order, :base_expirence, :heigth, :weight, :img_url)
    end

   def relacion_params
      params.permit(:ability_id, :pokemon_id, :type_id)
    end

end
