class Participants

  def self.description 
    "Participants" 
  end
  
  def self.create(parent=nil)
    
    layout_view :frame => [0, 0, 0, 0], :layout => {:expand => [:width, :height]}, :margin => 0, :spacing => 0 do |view|
      view << scroll_view(:layout => {:expand => [:width, :height]}) do |scroll|
        @tv = table_view( 
          :columns => [
            column(:id => :first_name,  :title => "First Name"), 
            column(:id => :last_name,   :title => "Last Name"),
            column(:id => :email,       :title => "Email")
            ]
        )
        @tv.data = APP.participants
        scroll << @tv
      end
      
      new_field =  layout_view :frame => [0, 0, 0, 0], :layout => {:expand => [:width, :height]}, :margin => 0, :spacing => 0 do |new_participant|
        fields_layout = layout_view(:frame => [0, 0, 0, 60], :mode => :horizontal, :layout => {:expand => :width, :start => false, :layout => :left}) do |hview|
          hview << @email = text_field(:text => "",      :frame => [0,0,110,25], :layout => {:start => false, :align => :left, :right_padding => 10})
          hview << label(:text => "Email: ",            :frame => [0,0,50,25], :layout => {:start => false, :align => :left, :right_padding => 10, :left_padding => 10})
          hview << @last_name = text_field(:text => "",  :frame => [0,0,110,25], :layout => {:start => false, :align => :left, :right_padding => 10})
          @email.nextResponder = @last_name
          hview << label(:text => "Last Name: ",        :frame => [0,0,75,25], :layout => {:start => false, :align => :left, :right_padding => 10, :left_padding => 10})
          hview << @first_name = text_field(:text => "", :frame => [0,0,110,25], :layout => {:start => false, :align => :left, :right_padding => 10})
          hview << label(:text => "First Name: ",       :frame => [0,0,75,25], :layout => {:start => false, :align => :left})
          
          parent.main_window.makeFirstResponder @first_name
          @first_name.nextKeyView = @last_name
          @last_name.nextKeyView = @email
        end
        new_participant << fields_layout
        new_participant << @add = button(:title => "Add", :frame => [0, 0, 70, 30], :bezel => :regular_square, :on_action => Proc.new { APP.participants.add_participant(@tv, {:first_name => @first_name.stringValue, :last_name => @last_name.stringValue, :email => @email.stringValue}) })
        @email.nextKeyView = @add

        # new_participant << button(:title => "Save Participant List",
        #                           :frame => [0, 0, 40, 30],
        #                           :bezel => :regular_square,
        #                           :on_action => Proc.new { APP.participants })
      end
      
      view << new_field
    end
  end
  
  RaffleApplication.register(self)
end
