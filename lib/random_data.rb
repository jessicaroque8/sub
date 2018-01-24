module RandomData

   def self.datetime(from, to=Time.now)
      Time.at(rand * (to.to_f - from.to_f) + from.to_f)
   end

   def self.word
      letters = ('a'..'z').to_a
      letters.shuffle!
      letters[0,rand(3..8)].join
   end

   def self.sentence
     strings = []
     rand(3..8).times do
       strings << word
     end

     sentence = strings.join(" ")
     sentence.capitalize << "."
  end


end
