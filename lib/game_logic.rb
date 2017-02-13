class GameLogic

  def check_grid(attempt, grid)
    attempt.upcase!
    attempt.split("").all? { |x| attempt.count(x) <= grid.count(x) }
  end

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    (0..grid_size-1).map { (65 + rand(26)).chr }
  end

  def run_game(attempt, grid, start_time, end_time)
    # TODO: runs the game and return detailed hash of result

    url = "https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=9e6f9218-0467-417d-ac4e-508e52e976dd&input=#{attempt}"
    translation_serialized = open(url).read
    translation_data = JSON.parse(translation_serialized)
    translation = translation_data["outputs"][0]["output"]


    if check_grid(attempt.downcase, grid)

      if translation != attempt
       result =  {
          time: end_time - start_time,
          translation: translation,
          score: attempt.length/(end_time - start_time) ,
          message: "well done"
        }
      else

        result =  {
            time: end_time - start_time,
            translation: nil,
            score: 0,
            message: "not an english word"
          }
      end

    else
       if translation != attempt
            result =  {
            time: end_time - start_time,
            translation: nil,
            score: 0,
            message: "not in the grid"
          }
        elsif translation == attempt
          result =  {
            time: end_time - start_time,
            translation: nil,
            score: 0,
            message: "not in the grid"
          }
        end
    end


  end
end


# run_game("spell", %w(W G G Z O N A L), Time.now, Time.now + 1.0)
