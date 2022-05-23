require 'rails_helper'

RSpec.describe Pokemon, type: :model do

  let(:pokemon){Pokemon.new(name: "Pokemon1", order: 1, base_expirence: 1, heigth:1, weight:1)}
  let(:pokemon_hash) {{ :name => "Pokemon1", :order => 1, :base_expirence  =>1, :heigth => 1, :weight => 1}}
  
  def validate_pokemon attribute: "name", value: nil
    pokemon[attribute.to_sym] = value
    pokemon.valid?
  end

  context "Validations" do
    it 'name cannot be blank' do 
      validate_pokemon
      expect(pokemon.errors[:name][0]).to eq("can't be blank")
    end

    it 'name cannot have than 255 characters' do
      validate_pokemon attribute: "name", value: "a"*256
      expect(pokemon.errors[:name][0]).to eq("is too long (maximum is 255 characters)")
    end

    it "Order can't be blank" do 
      validate_pokemon attribute: "order"
      expect(pokemon.errors[:order][0]).to eq("can't be blank")
    end

    it "Order is not a number" do 
      validate_pokemon attribute: "order", value: "cero"
      expect(pokemon.errors[:order][0]).to eq("is not a number")
    end 

    it "Base_expirence can't be blank" do 
      validate_pokemon attribute: "base_expirence"
      expect(pokemon.errors[:base_expirence][0]).to eq("can't be blank")
    end 
    it "Base_expirence is not a number" do
      validate_pokemon attribute: "base_expirence",value:"cero"
      expect(pokemon.errors[:base_expirence][0]).to eq("is not a number")
    end

    it "Heigth is not a number" do
      validate_pokemon attribute: "heigth", value:"cero"
      expect(pokemon.errors[:heigth][0]).to eq("is not a number")
    end
    it "Heigth can't be blank" do
      validate_pokemon attribute: "heigth"
      expect(pokemon.errors[:heigth][0]).to eq("can't be blank")
    end
    it "Weight can't be blank" do
      validate_pokemon attribute: "weight"
      expect(pokemon.errors[:weight][0]).to eq("can't be blank")
    end
    it "Weight is not a number" do
      validate_pokemon attribute: "weight", value:"cero"
      expect(pokemon.errors[:weight][0]).to eq("is not a number")
    end
  end

  context "Associations" do
    it "should have many ablitites" do 
      should have_many(:abilities).through(:ability_pokemons)
    end

    it "should have many types" do 
      should have_many(:types).through(:pokemon_types)
    end 
  end
   
   it 'Should return a collection of pokemons in ascending order' do 
      pok_B = Pokemon.create(name: "B_pokemon", order: 2, base_expirence: 1, heigth:1, weight:1)
      pok_A = Pokemon.create(name: "A_pokemon", order: 1, base_expirence: 1, heigth:1, weight:1)

      expect(Pokemon.name_sort).to contain_exactly(pok_A, pok_B)
    end

end
