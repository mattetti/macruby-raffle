class IntroView

  def self.description 
    "Intro" 
  end
  
  def self.create(parent=nil)
    layout_view :frame => [10, 0, 300, 300], :layout => {:expand => [:width, :height]}, :margin => 10, :spacing => 0 do |view|
      @run_button = button(:title => "Pick a winner", :bezel => :regular_square, :layout => {:start => false}, :on_action =>  Proc.new{parent.display_view("Pick a winner")})    
      @add_participants = button(:title => "Add Participants", :bezel => :regular_square, :layout => {:start => false}, :on_action =>  Proc.new{parent.display_view("Participants")})
      
      Stylist.small_style(parent.winner_field)
      parent.winner_field.text = "SDRuby Raffle #{Time.now.strftime('%Y-%m-%d')}" if parent
      view << @run_button
      view << @add_participants
    end
  end
  
  RaffleApplication.register(self)
  
end
