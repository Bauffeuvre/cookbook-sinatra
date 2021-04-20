require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative './lib/cookbook.rb'
require_relative './lib/recipe.rb'

csv_file   = File.join(__dir__, 'lib/recipes.csv')
cookbook   = Cookbook.new(csv_file)


set :bind, '0.0.0.0'

configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @recipes = cookbook.all

# binding.pry
  erb :index
end

get '/new' do
# binding.pry
  erb :new
end

get '/recipes' do
   
    name = @params["name"]
    description = @params["description"]
    prep_time = @params["prep_time"]
    rating = @params["rating"]
    done = false
    
    recipe = Recipe.new(name, description, prep_time, rating, done)
    @recipes = cookbook.add_recipe(recipe)
    erb :index
end