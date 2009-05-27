class PickWinner

  def self.parent
    @@parent
  end

  
  def self.raffle
    @@raffle ||= Raffle.new
  end

  def self.description 
    "Pick a winner" 
  end
  
  def self.create(parent_class)
    @@parent = parent_class
    
    layout_view :frame => [10, 0, 0, 0], :layout => {:expand => [:width, :height]}, :margin => 10, :spacing => 0 do |view|
      @@raffle = Raffle.new(APP.participants.data)
      raffle.normal_mode
      
      @run_button     = button(:title => "Pick a another winner", :bezel => :regular_square, :layout => {:start => false}, :on_action => Proc.new {reveal_the_winner})      
      reveal_the_winner
      
      view << @run_button
    end
  end
  
  def self.reveal_the_winner
    Stylist.large_style(parent.winner_field)
      winner = raffle.pick_a_winner
      if winner
        speech_synthesizer.speak('And the winner is...')
        sleep 1
        speech_synthesizer.speak(winner[:first_name])
        parent.winner_field.text = "#{winner[:first_name]} #{winner[:last_name]}"
      else
        speech_synthesizer.speak('Everyone already won')
        parent.winner_field.text = ""
      end
  end
  
  RaffleApplication.register(self)
  
end
