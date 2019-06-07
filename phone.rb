class Phone
  # initialize method
  # ruby Phone.new.start

  def initialize
    # Method to read the dictionary.txt
    get_dictionary_words
    # Hash of numbers associated with mobile keypad.
    get_keypad
    # Get user input
    get_input
  end


   # Dictionary file words assign to variable
  def get_dictionary_words
    @dictionary_words = File.read("./dictionary.txt").split("\n").map(&:downcase)
  end

  # Phone number Validation.
  def get_input
    p "Please enter a 10 digit phone number not contain 0 / 1"
    number = gets.chomp
    get_word_combinations(number)
  end

  # keypad array stored in a variable
  def get_keypad
    @keypad = {
      "2" => ['a','b','c'],
      "3" => ['d','e','f'],
      "4" => ['g','h','i'],
      "5" => ['j','k','l'],
      "6" => ['m','n','o'],
      "7" => ['p','q','r','s'],
      "8" => ['t','u','v'],
      "9" => ['w','x','y','z']
    }
  end

  def get_word_combinations(phone_no)
    check_valid_phone_no(phone_no)
    start_time = Time.now
    # Convert the phone number into an array Using split
    number_array = phone_no.split("")

    # Convert that array of numbers into each of the number from keypad list.
    key_characters = number_array.map{|n| @keypad[n]}

    # Take all possible combinations of the words on the keys. 
    # Product of each key's characters with all other key's characters
    begin
      key_words = key_characters.shift.product(*key_characters).map(&:join)
    rescue TypeError
      return "The number you have entered is not a valid number. Please try again."
    end

    search_word_combinations(key_words)
    end_time = Time.now

    p "start time : #{start_time}"
    p "end time : #{end_time}"
    p "Load Time : #{end_time - start_time}"
  end

  def check_valid_phone_no(phone_no)
    unless (phone_no.length == 10 && phone_no.match(/^[2-9]*$/))
      puts "The phone number you have entered is not a valid number. Please enter a 10 digit phone number not contain 0 / 1"
      phone_no = gets.chomp
      get_word_combinations(phone_no)
    end
  end


  # Method to search all possible combinations of dictionary.txt.
  def search_word_combinations(key_words)
    final_words = []
    # Loop to get all combinations of words (Minimum word length 3)
    i = 2
    while i < 7 do
      a = key_words.map{|x| x[0..i]}.uniq
      b = key_words.map{|y| y[i+1..-1]}.uniq

      # Find all matching words from dictionary
      lookup_one = @dictionary_words & a
      lookup_two = @dictionary_words & b

      # Combining the lookup result arrays
      merge_lookup = lookup_one.product(lookup_two)
      final_words << merge_lookup unless merge_lookup.empty?
      i += 1
    end  

    # Get exact matches
    exact_matches = @dictionary_words & key_words
    final_words << exact_matches

    # Flatten final array by one level.
    p final_words.flatten(1)


  end




  

end

Phone.new