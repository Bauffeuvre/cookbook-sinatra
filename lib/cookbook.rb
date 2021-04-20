require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []

    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    store_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    store_csv
  end

  # def mark_rad(recipe_index)
  #   @recipes.find(recipe_index)
  #   store_csv
  # end

  def load_csv
    CSV.foreach(@csv_file_path, 'r') do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def store_csv
    CSV.open(@csv_file_path, 'wb') do |row|
      @recipes.each do |recipe|
        row << [recipe.name, recipe.description, recipe.prep_time, recipe.rating, recipe.done]
      end
    end
  end
end
