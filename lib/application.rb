require 'HotCocoa'
include HotCocoa
require File.join(File.dirname(__FILE__), 'raffle')
require File.join(File.dirname(__FILE__), 'stylist')
require File.join(File.dirname(__FILE__), 'models', 'participants_store')

class RaffleApplication

  attr_reader :current_view, :main_window, :about_button, :winner_field, :participants
  attr_accessor :cached_views

  ## Class methods
  def self.register(view_class)
    view_classes << view_class
  end
  
  def self.view_classes
    @view_classes ||= []
  end
  
  def self.cached_views
    @cached_views ||= {}
  end
  
  # Find a view using a description
  def self.view_with_description(description)
    cached_views[description] ||= @view_classes.detect {|view| view.description == description}
  end
  
  def self.about_button
    @about_button
  end
  
  def participants
    @participants ||= ::ParticipantsStore.new([{first_name: "Matt", last_name: "Aimonetti"}])
  end
  
  ## Instance methods
  def start
    load_demo_files
    application :name => "Raffle" do |app|
      app.delegate = self      
            
      @main_window = window :frame => [100, 100, 604, 500], :title => "SDRuby Raffle", :style => [:titled, :closable, :miniaturizable, :resizable] do |win|
        win.contentView.margin  = 0
        win.background_color    = color(:name => 'white')
        @logo                   = image_view(:frame => [0,0,604,100], :layout => {:start => false})
        @logo.file              = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "resources", "sdruby.png"))       
        win << @logo        
        win.will_close { exit }
      end
      
      get_started
    end
  end
  
  # file/open
  def on_open(menu)
  end
  
  # file/new 
  def on_new(menu)
  end
  
  # help menu item
  def on_help(menu)
  end
  
  # This is commented out, so the minimize menu item is disabled
  #def on_minimize(menu)
  #end
  
  # window/zoom
  def on_zoom(menu)
  end
  
  # window/bring_all_to_front
  def on_bring_all_to_front(menu)
  end
  
  def get_started
    @winner_field   = label(:text => "SDRuby Raffle #{Time.now.strftime('%Y-%m-%d')}", :layout => {:start => false, :align => :left}, :frame => [0, 0, 600, 90])
    Stylist.large_style(@winner_field)
    
    winner_view = layout_view :frame => [0, 0, 600, 80], :layout => {:start => false}, :margin => 10, :spacing => 0 do |view|
      view << @winner_field
    end
    
    about_and_winner = layout_view(:frame => [0, 0, 0, 60], :mode => :horizontal, :layout => {:expand => :width, :align => :left}) do |hview|
      # @about_button     = button(:title => "About",             :frame => [0, 0, 70, 30],   :bezel => :regular_square, :layout => {:align => :right}, :on_action => Proc.new { display_view("About SDRuby Raffle") })           
      @winner_button    = button(:title => "Pick A winner",     :frame => [0, 0, 170, 30],  :bezel => :regular_square, :layout => {:align => :right}, :on_action => Proc.new { display_view("Pick a winner") })
      @add_participants = button(:title => "Add Participants",  :frame => [0, 0, 170, 30],  :bezel => :regular_square, :layout => {:align => :right}, :on_action => Proc.new { display_view("Participants") })
      # hview << @about_button
      hview << @add_participants
      hview << @winner_button
    end
    
    main_window << winner_view
    #display_view("About SDRuby Raffle")
    main_window << about_and_winner
  end
  
  def display_view(description)
    main_window.view.remove(current_view) if current_view
    @current_view = RaffleApplication.view_with_description(description).create(self)
    main_window << @current_view
  end
  
  private
  
    def load_demo_files
      Dir.glob(File.join(File.dirname(__FILE__), 'views', '*.rb')).each do |file|
        load file
      end
    end
  
end

APP = RaffleApplication.new
APP.start