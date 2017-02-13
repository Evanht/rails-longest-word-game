require 'open-uri'
require 'json'
require "game_logic.rb"

class PagesController < ApplicationController

  GAMENOW = GameLogic.new



  def game
    @grid = GAMENOW.generate_grid(9)
    @start_time = Time.now
  end

  def score
    @end_time = Time.now
    @word = params[:query]
    @grid_param = params[:grid]

    @time_array = params[:start_time].split("-") #1st 2 elements of this array are year and month
    @day_time_diff_array = @time_array[2].split(" ") #1st element is day, 3rd is diff time
    @hour_minute_second_array = @day_time_diff_array[1].split(":")



    @start_time_param = Time.new(@time_array[0], @time_array[1], @day_time_diff_array[0], @hour_minute_second_array[0], @hour_minute_second_array[1], @hour_minute_second_array[2], "+00:00")


    @result = GAMENOW.run_game(@word, @grid_param, @start_time_param, @end_time)
  end

end
